// Going with 'part of' here. 'import' would be preferred, but would force me to
// expose internal methods from QuestionnaireLocation to the public.
// TODO: Would it make sense if TopLocation was not a Location? has-a instead of is-a relationship?
part of 'questionnaire_location.dart';

/// Visit FHIR [Questionnaire] through linkIds.
/// This marks the entry point into the [Questionnaire].
/// All contained items and children are expressed as [QuestionnaireLocation].
class QuestionnaireTopLocation extends QuestionnaireLocation {
  final Map<String, QuestionnaireLocation> _cachedItems = {};
  List<QuestionnaireLocation>? _enabledWhens;
  final List<Aggregator>? _aggregators;
  final ExternalResourceProvider? _extResourceProvider;
  int _revision = 1;
  final Locale locale;
  static final _logger = Logger(QuestionnaireTopLocation);

  /// Create the first location top-down of the given [Questionnaire].
  /// Will throw [Error]s in case this [Questionnaire] has no items.
  /// A newly constructed [QuestionnaireTopLocation] will require an invocation of
  /// [init], or it might malfunction!
  QuestionnaireTopLocation.fromQuestionnaire(Questionnaire questionnaire,
      {required this.locale,
      List<Aggregator>? aggregators,
      ExternalResourceProvider? externalResourceProvider})
      : _aggregators = aggregators,
        _extResourceProvider = externalResourceProvider,
        super._(
            questionnaire,
            null,
            ArgumentError.checkNotNull(questionnaire.item?.first),
            ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
            null,
            0,
            0) {
    _logger.log('QuestionnaireTopLocation.fromQuestionnaire',
        level: LogLevel.debug);
    _top = this;
    // This will set up the traversal order and fill up the cache.
    _ensureOrderedItems();

    for (final location in preOrder()) {
      final enableWhens = location.questionnaireItem.enableWhen;
      if ((enableWhens != null) && enableWhens.isNotEmpty) {
        if (_enabledWhens == null) {
          _enabledWhens = [location];
        } else {
          _enabledWhens!.add(location);
        }
      }
    }

    _logger.log('_enabledWhens: $_enabledWhens', level: LogLevel.debug);

    if (aggregators != null) {
      for (final aggregator in aggregators) {
        aggregator.init(this);
        // Assumption: aggregators that don't autoAggregate will have their aggregate method invoked manually when it matters.
        if (aggregator.autoAggregate) {
          aggregator.aggregate(notifyListeners: true);
        }
      }
    }

    activateEnableWhen();
  }

  /// Bring the model into a fully functional state.
  /// Unfortunately, this is necessary, as some operations are async and
  /// you cannot have an async constructor.
  Future<void> initState() async {
    await _extResourceProvider?.init();
  }

  T aggregator<T extends Aggregator>() {
    if (_aggregators == null) {
      throw StateError('Aggregators have not been specified in constructor.');
    }
    return (_aggregators?.firstWhere((aggregator) => aggregator is T) as T?)!;
  }

  void bumpRevision({bool notifyListeners = true}) {
    final newRevision = _revision + 1;
    _logger.debug(
        'QuestionnaireTopLocation.bumpRevision $notifyListeners: $_revision -> $newRevision');
    _revision = newRevision;
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  /// Get a [Resource] which is referenced in the [Questionnaire].
  /// If [uri] starts with '#' then it is located as a contained element.
  /// Otherwise it is assumed to be external and resolved through [ExternalResourceProvider].
  ///
  /// Will throw if the Resource does not exist.
  Resource getResource(String uri, {dynamic context}) {
    final isResourceContained = uri.startsWith('#');
    final resource = isResourceContained
        ? findContainedByElementId(uri)
        : _extResourceProvider?.getResource(uri);

    if (resource == null) {
      if (isResourceContained) {
        throw QuestionnaireFormatException(
            'Questionnaire does not contain referenced Resource $uri',
            questionnaire.contained);
      } else {
        throw QuestionnaireFormatException(
            'External Resource $uri cannot be located.', context);
      }
    }

    return resource;
  }

  /// Invoke a function on every entry of a ValueSet, incl. all the contained, included, etc. elements.
  void visitValueSet(String uri, void Function(Coding coding) visitor,
      {dynamic context}) {
    final valueSet = getResource(uri, context: context) as ValueSet;

    final List<ValueSetContains>? valueSetContains =
        valueSet.expansion?.contains;

    if (valueSetContains != null) {
      // Expansion has preference over includes. They are not additive.
      for (final contains in valueSetContains) {
        final coding = Coding(
            system: contains.system,
            code: contains.code,
            display: contains.display,
            extension_: contains.extension_);

        visitor.call(coding);
      }
    } else {
      final List<ValueSetInclude>? valueSetIncludes = valueSet.compose?.include;

      if (valueSetIncludes == null) {
        throw QuestionnaireFormatException(
            'Include in ValueSet $uri does not exist.', context);
      }

      for (final valueSetInclude in valueSetIncludes) {
        final List<ValueSetConcept> valueSetConcepts =
            valueSetInclude.concept ?? [];

        if (valueSetConcepts.isEmpty) {
          _logger.log('Concepts in ValueSet $uri is empty.');
          // TODO: Do I need something recursive here? Can there be nested inclusion?
          // ValueSets may contain references to further included ValueSets.
          final includeUri =
              valueSetInclude.valueSet?.firstOrNull?.value?.toString();
          if (includeUri != null) {
            final includeConcepts =
                (getResource(includeUri, context: '$context / concepts')
                        as ValueSet)
                    .compose
                    ?.include
                    .firstOrNull
                    ?.concept;
            valueSetConcepts.addAll(includeConcepts ?? []);
          }

          if (valueSetInclude.system != null) {
            final codeSystem =
                getResource(valueSetInclude.system.toString()) as CodeSystem;
            _logger.debug(
                'Processing included CodeSystem ${codeSystem.url.toString()}');
            if (codeSystem.concept != null) {
              for (final concept in codeSystem.concept!) {
                final coding = Coding(
                    system: valueSetInclude.system,
                    code: concept.code,
                    display: concept.display,
                    extension_: concept.extension_);
                visitor.call(coding);
              }
            }
          }
        }

        for (final concept in valueSetConcepts) {
          final coding = Coding(
              system: valueSetInclude.system,
              code: concept.code,
              display: concept.display,
              extension_: concept.extension_);

          visitor.call(coding);
        }
      }
    }
  }

  /// Find a contained element by its id.
  /// Id may start with a leading '#', which will be stripped.
  /// [elementId] == null will return null.
  /// Will throw [QuestionnaireFormatException] if [elementId] cannot be found.
  Resource? findContainedByElementId(String? elementId) {
    if (elementId == null) {
      return null;
    }

    if (questionnaire.contained == null) {
      throw QuestionnaireFormatException(
          'Questionnaire does not have contained elements.', questionnaire);
    }

    final key = elementId.startsWith('#')
        ? elementId.substring(1)
        : elementId; // Strip leading #

    for (final resource in questionnaire.contained!) {
      if (key == resource.id?.toString()) {
        return resource;
      }

      if (resource.resourceType == R4ResourceType.Bundle) {
        final entries = (resource as Bundle).entry;
        if (entries == null) {
          continue;
        }
        for (final entry in entries) {
          if (key == entry.resource?.id?.toString()) {
            return entry.resource;
          }
        }
      }
    }

    throw QuestionnaireFormatException(
        'Questionnaire does not contain element with id #$elementId',
        questionnaire.contained);
  }

  int get revision => _revision;

  /// Find the [QuestionnaireLocation] that corresponds to the linkId.
  /// Throws an [Exception] when no such [QuestionnaireLocation] exists.
  QuestionnaireLocation findByLinkId(String linkId) {
    final result = _orderedItems![linkId];
    if (result == null) {
      throw QuestionnaireFormatException("Location '$linkId' not found.");
    } else {
      return result;
    }
  }

  QuestionnaireResponseStatus responseStatus =
      QuestionnaireResponseStatus.unknown;

  void _populateItems(List<QuestionnaireResponseItem>? qris) {
    if (qris == null) {
      return;
    }
    for (final item in qris) {
      findByLinkId(item.linkId!).responseItem = item;
      _populateItems(item.item);
      if (item.answer != null) {
        for (final answer in item.answer!) {
          _populateItems(answer.item);
        }
      }
    }
  }

  /// Populate the answers in the questionnaire with the answers from a response.
  void populate(QuestionnaireResponse? questionnaireResponse) {
    _logger.log('Populating with $questionnaireResponse',
        level: LogLevel.debug);
    if (questionnaireResponse == null) {
      return;
    }

    if (questionnaireResponse.item == null ||
        questionnaireResponse.item!.isEmpty) {
      return;
    }

    // TODO: What is the best notification strategy?
    // Assumption: It would be better to first set all responses in bulk and then recalc.
    _populateItems(questionnaireResponse.item);
  }

  /// Update the current enablement status of all items.
  void updateEnableWhen({bool notifyListeners = true}) {
    if (_enabledWhens == null) {
      _logger.log('updateEnableWhen: no conditional items',
          level: LogLevel.trace);
      return;
    }
    _logger.log('updateEnableWhen()', level: LogLevel.trace);

    final previouslyEnabled = List<bool>.generate(
        preOrder().length, (index) => preOrder().elementAt(index).enabled,
        growable: false);
    _logger.log('prevEnabled: $previouslyEnabled', level: LogLevel.trace);
    for (final location in preOrder()) {
      location._enabled = true;
    }

    for (final location in _enabledWhens!) {
      location._calculateEnabled();
    }
    final afterEnabled = List<bool>.generate(
        preOrder().length, (index) => preOrder().elementAt(index).enabled,
        growable: false);
    _logger.log('afterEnabled: $afterEnabled', level: LogLevel.trace);

    if (!listEquals(previouslyEnabled, afterEnabled)) {
      bumpRevision(notifyListeners: notifyListeners);
    } else {
      _logger.log('enableWhen unchanged.', level: LogLevel.debug);
    }
  }

  /// Activate the "enableWhen" behaviors.
  void activateEnableWhen() {
    for (final location in preOrder()) {
      location.forEnableWhens((qew) {
        findByLinkId(qew.question!).addListener(() => updateEnableWhen());
      });
    }

    updateEnableWhen();
  }
}
