// Going with 'part of' here. 'import' would be preferred, but would force me to
// expose numerous internal methods to the public.
part of 'questionnaire_item_model.dart';

/// Models a questionnaire.
///
/// Combined higher-level abstraction of [Questionnaire] and [QuestionnaireResponse].
///
/// Any properties and functions that affect the overall questionnaire are provided by [QuestionnaireModel].
///
/// Properties and functions that affect an individual item are in [QuestionnaireItemModel].
///
/// [QuestionnaireModel] provides direct access to any [QuestionnaireItemModel] through linkId.
class QuestionnaireModel extends QuestionnaireItemModel {
  final Map<String, QuestionnaireItemModel> _cachedItems = {};
  List<QuestionnaireItemModel>? _itemsWithEnableWhen;
  List<QuestionnaireItemModel>? _itemsWithEnableWhenExpression;
  // In which generation were the enabled items last determined?
  int _updateEnabledGeneration = -1;
  final List<Aggregator>? _aggregators;

  /// Direct access to [FhirResourceProvider]s for special use-cases.
  ///
  /// see: [getResource] for the preferred access method.
  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;

  int _generation = 1;
  final Locale locale;
  static final _logger = Logger(QuestionnaireModel);

  QuestionnaireModel._({
    required this.locale,
    required Questionnaire questionnaire,
    required this.fhirResourceProvider,
    required this.launchContext,
    required List<Aggregator>? aggregators,
  })  : _aggregators = aggregators,
        super._(
          questionnaire,
          null,
          ArgumentError.checkNotNull(questionnaire.item?.first),
          ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
          null,
          0,
          0,
        ) {
    _questionnaireModel = this;
    // This will set up the traversal order and fill up the cache.
    _ensureOrderedItems();

    // Set up conventional enableWhen feature
    for (final itemModel in orderedQuestionnaireItemModels()) {
      if (itemModel.isEnabledWhen) {
        if (_itemsWithEnableWhen == null) {
          _itemsWithEnableWhen = [itemModel];
        } else {
          _itemsWithEnableWhen!.add(itemModel);
        }
      }
    }

    _logger.debug('_itemsWithEnableWhen: $_itemsWithEnableWhen');

    // Set up FHIRPath based enableWhenExpression feature
    for (final itemModel in orderedQuestionnaireItemModels()) {
      if (itemModel.isEnabledWhenExpression) {
        if (_itemsWithEnableWhenExpression == null) {
          _itemsWithEnableWhenExpression = [itemModel];
        } else {
          _itemsWithEnableWhenExpression!.add(itemModel);
        }
      }
    }

    _logger.debug(
      '_itemsWithEnableWhenExpression: $_itemsWithEnableWhenExpression',
    );

    if (aggregators != null) {
      for (final aggregator in aggregators) {
        aggregator.init(this);
        // Assumption: aggregators that don't autoAggregate will have their aggregate method invoked manually when it matters.
        if (aggregator.autoAggregate) {
          aggregator.aggregate(notifyListeners: true);
        }
      }
    }

    // TODO: Should the constructor activate any kind of dynamic behavior?
    activateEnableBehavior();

    // This ensures screen updates in case of invalid responses.
    errorFlags.addListener(() {
      nextGeneration();
    });
  }

  /// Create the model for a [Questionnaire].
  ///
  /// Will introspect the provided [fhirResourceProvider] to locate a
  /// * mandatory [Questionnaire]
  /// * mandatory [Subject]
  /// * optional [QuestionnaireResponse]
  /// * optional [ValueSet]
  ///
  /// Will throw [Error]s in case the [Questionnaire] has no items.
  ///
  /// The [fhirResourceProvider] is used for access to any required resources,
  /// such as ValueSets, Subject, or Encounter.
  ///
  /// If no [QuestionnaireResponse] has been provided here, it can still later
  /// be provided through the [populate] function.
  static Future<QuestionnaireModel> fromFhirResourceBundle({
    required Locale locale,
    List<Aggregator>? aggregators,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
  }) async {
    _logger.debug('QuestionnaireModel.fromFhirResourceBundle');

    final questionnaire = await fhirResourceProvider
        .getAsyncResource(questionnaireResourceUri) as Questionnaire?;

    if (questionnaire == null) {
      throw StateError('No Questionnaire has been provided.');
    }

    final questionnaireModel = QuestionnaireModel._(
      questionnaire: questionnaire,
      locale: locale,
      aggregators: aggregators ??
          [
            TotalScoreAggregator(),
            NarrativeAggregator(),
            QuestionnaireResponseAggregator()
          ],
      fhirResourceProvider: fhirResourceProvider,
      launchContext: launchContext,
    );

    await questionnaireModel.fhirResourceProvider.init();

    final response =
        fhirResourceProvider.getResource(questionnaireResponseResourceUri)
            as QuestionnaireResponse?;

    // ================================================================
    // Behaviors require a defined sequence during setup:
    // * initialValue
    // * variables
    // * calculated
    // * enableWhen
    // * error flagging
    // ================================================================

    // Populate initial values if response == null
    // This cannot happen in the constructor, as only this method has the
    // extra information to populate variables.
    if (response == null) {
      questionnaireModel
          .orderedQuestionnaireItemModels()
          .where((qim) => qim.hasInitialValue)
          .forEach((qim) {
        qim._populateInitialValue();
      });
    } else {
      questionnaireModel.populate(response);
    }

    // Set up updates for values of questionnaire-level variables
    questionnaireModel._updateVariables();
    questionnaireModel.addListener(questionnaireModel._updateVariables);

    // WIP: Set up calculatedExpressions on items
    questionnaireModel._updateCalculations();
    questionnaireModel.addListener(questionnaireModel._updateCalculations);

    // WIP: Set up enableWhen behavior on items
    // TODO: Move this here from the constructor

    // TODO: Move error flagging here from constructor

    return questionnaireModel;
  }

  /// Returns an [Aggregator] of the given type.
  T aggregator<T extends Aggregator>() {
    if (_aggregators == null) {
      throw StateError('Aggregators have not been specified in constructor.');
    }
    return (_aggregators?.firstWhere((aggregator) => aggregator is T) as T?)!;
  }

  /// Changes the [generation] and notifies all listeners.
  ///
  /// Each generation is unique during a run of the application.
  void nextGeneration({bool notifyListeners = true}) {
    final newGeneration = _generation + 1;
    _logger.debug(
      'nextGeneration $notifyListeners: $_generation -> $newGeneration',
    );
    _generation = newGeneration;

    // Invalidate cached items
    _cachedQuestionnaireResponse = null;

    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  QuestionnaireResponse? _cachedQuestionnaireResponse;

  /// Returns a [QuestionnaireResponse].
  ///
  /// The response matches the model as of the current generation.
  QuestionnaireResponse? get questionnaireResponse =>
      _cachedQuestionnaireResponse ??=
          aggregator<QuestionnaireResponseAggregator>().aggregate();

  /// Returns a [Resource] which is referenced in the [Questionnaire].
  ///
  /// If [uri] starts with '#' then it is located as a contained element.
  /// Otherwise it is assumed to be external and resolved through [FhirResourceProvider].
  ///
  /// [context] is optional information for logging or throwing.
  ///
  /// Will throw if the Resource does not exist.
  Resource getResource(String uri, {Object? context}) {
    final isResourceContained = uri.startsWith('#');
    final resource = isResourceContained
        ? findContainedByElementId(uri)
        : RegistryFhirResourceProvider(
            // Certain Value Sets need to be made available to questionnaires, even if they are not explicitly provided.
            [FhirValueSetProvider(), fhirResourceProvider],
          ).getResource(uri);

    if (resource == null) {
      if (isResourceContained) {
        throw QuestionnaireFormatException(
          'Questionnaire does not contain referenced Resource $uri',
          questionnaire.contained,
        );
      } else {
        throw QuestionnaireFormatException(
          'External Resource $uri cannot be located.',
          context,
        );
      }
    }

    return resource;
  }

  /// Applies the function `f` to each entry of a ValueSet.
  ///
  /// The ValueSet is identified through the [uri].
  ///
  /// Includes all the contained, included, etc. elements.
  void forEachInValueSet(
    String uri,
    void Function(Coding coding) f, {
    Object? context,
  }) {
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
          extension_: contains.extension_,
        );

        f.call(coding);
      }
    } else {
      final List<ValueSetInclude>? valueSetIncludes = valueSet.compose?.include;

      if (valueSetIncludes == null) {
        throw QuestionnaireFormatException(
          'Include in ValueSet $uri does not exist.',
          context,
        );
      }

      for (final valueSetInclude in valueSetIncludes) {
        final List<ValueSetConcept> valueSetConcepts =
            valueSetInclude.concept ?? [];

        if (valueSetConcepts.isEmpty) {
          _logger.debug('Concepts in ValueSet $uri is empty.');
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
              'Processing included CodeSystem ${codeSystem.url.toString()}',
            );
            if (codeSystem.concept != null) {
              for (final concept in codeSystem.concept!) {
                final coding = Coding(
                  system: valueSetInclude.system,
                  code: concept.code,
                  display: concept.display,
                  extension_: concept.extension_,
                );
                f.call(coding);
              }
            }
          }
        }

        for (final concept in valueSetConcepts) {
          final coding = Coding(
            system: valueSetInclude.system,
            code: concept.code,
            display: concept.display,
            extension_: concept.extension_,
          );

          f.call(coding);
        }
      }
    }
  }

  /// Finds a contained element by its id.
  ///
  /// Id may start with a leading '#', which will be stripped.
  /// [elementId] == null will return null.
  /// Will throw [QuestionnaireFormatException] if [elementId] cannot be found.
  Resource? findContainedByElementId(String? elementId) {
    if (elementId == null) {
      return null;
    }

    if (questionnaire.contained == null) {
      throw QuestionnaireFormatException(
        'Questionnaire does not have contained elements.',
        questionnaire,
      );
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
      questionnaire.contained,
    );
  }

  /// Returns a number that indicates whether the model has changed.
  int get generation => _generation;

  /// Returns the [QuestionnaireItemModel] that corresponds to the linkId.
  ///
  /// Throws an [Exception] when no such [QuestionnaireItemModel] exists.
  QuestionnaireItemModel fromLinkId(String linkId) {
    final result = _orderedItems![linkId];
    if (result == null) {
      throw QuestionnaireFormatException("Location '$linkId' not found.");
    } else {
      return result;
    }
  }

  QuestionnaireResponseStatus _responseStatus =
      QuestionnaireResponseStatus.in_progress;

  QuestionnaireResponseStatus get responseStatus => _responseStatus;

  set responseStatus(QuestionnaireResponseStatus newStatus) {
    _responseStatus = newStatus;
    nextGeneration();
  }

  void _populateItems(
    List<QuestionnaireResponseItem>? questionnaireResponseItems,
  ) {
    if (questionnaireResponseItems == null) {
      return;
    }
    for (final item in questionnaireResponseItems) {
      fromLinkId(item.linkId!).responseItem = item;
      _populateItems(item.item);
      if (item.answer != null) {
        for (final answer in item.answer!) {
          _populateItems(answer.item);
        }
      }
    }
  }

  /// Populate the answers in the questionnaire with the answers from a response.
  ///
  /// Does nothing if [questionnaireResponse] is null.
  void populate(QuestionnaireResponse? questionnaireResponse) {
    _logger.debug('Populating with $questionnaireResponse');
    if (questionnaireResponse == null) {
      return;
    }

    if (questionnaireResponse.item == null ||
        questionnaireResponse.item!.isEmpty) {
      return;
    }

    // OPTIMIZE: What is the best notification strategy?
    // Assumption: It would be better to first set all responses in bulk and then recalc.
    _populateItems(questionnaireResponse.item);

    responseStatus =
        questionnaireResponse.status ?? QuestionnaireResponseStatus.in_progress;
  }

  void _updateCalculations() {
    orderedQuestionnaireItemModels()
        .where((qim) => qim.isCalculatedExpression)
        .forEach((qim) {
      qim._updateCalculatedExpression();
    });
  }

  /// Returns a bitfield of the items with `isEnabled` == true.
  List<bool> get _currentlyEnabledItems => List<bool>.generate(
        orderedQuestionnaireItemModels().length,
        (index) => orderedQuestionnaireItemModels().elementAt(index).isEnabled,
        growable: false,
      );

  /// Update the current enablement status of all items.
  ///
  /// This updates enablement through enableWhen and enableWhenExpression.
  void updateEnabledItems({bool notifyListeners = true}) {
    _logger.trace('updateEnabledItems()');

    if (_updateEnabledGeneration == _generation) {
      _logger.debug(
        'updateEnabledItems: already updated during this generation',
      );
      return;
    }

    _updateEnabledGeneration = _generation;

    if (_itemsWithEnableWhen == null &&
        _itemsWithEnableWhenExpression == null) {
      _logger.debug(
        'updateEnabledItems: no conditionally enabled items',
      );
      return;
    }

    final previouslyEnabled = _currentlyEnabledItems;
    _logger.trace('prevEnabled: $previouslyEnabled');
    for (final itemModel in orderedQuestionnaireItemModels()) {
      itemModel._isEnabled = true;
    }

    if (_itemsWithEnableWhen != null) {
      for (final itemModel in _itemsWithEnableWhen!) {
        itemModel._updateEnabled();
      }
    }

    if (_itemsWithEnableWhenExpression != null) {
      for (final itemModel in _itemsWithEnableWhenExpression!) {
        itemModel._updateEnabled();
      }
    }

    final nowEnabled = _currentlyEnabledItems;
    _logger.trace('nowEnabled: $nowEnabled');

    if (!listEquals(previouslyEnabled, nowEnabled)) {
      nextGeneration(notifyListeners: notifyListeners);
    } else {
      _logger.debug('Enabled items unchanged.');
    }
  }

  /// Activate the enable behavior.
  ///
  /// Adds the required listeners to evaluate enableWhen and
  /// enableWhenExpression as items are changed.
  void activateEnableBehavior() {
    if (_itemsWithEnableWhenExpression != null) {
      // When enableWhenExpression is involved we need to add listeners to every
      // non-static item, as we have no way to find out which items are referenced
      // by the FHIR Path expression.
      addListener(() => updateEnabledItems());
    } else {
      for (final itemModel in orderedQuestionnaireItemModels()) {
        itemModel.forEnableWhens((qew) {
          fromLinkId(qew.question!).addListener(() => updateEnabledItems());
        });
      }
    }

    updateEnabledItems();
  }

  /// Returns the evaluation result of a FHIRPath expression
  List<dynamic> evaluateFhirPathExpression(
    String fhirPathExpression, {
    bool requiresQuestionnaireResponse = true,
  }) {
    final responseResource =
        requiresQuestionnaireResponse ? questionnaireResponse : null;

    // Variables for launch context
    final launchContextVariables = <String, dynamic>{};
    if (launchContext.patient != null) {
      launchContextVariables.addEntries(
        [
          MapEntry<String, dynamic>('%patient', launchContext.patient?.toJson())
        ],
      );
    }

    // Calculated variables
    final calculatedVariables = (_variables != null)
        ? Map.fromEntries(
            _variables!.map<MapEntry<String, dynamic>>(
              (variable) => MapEntry('%${variable.name}', variable.value),
            ),
          )
        : null;

    // SDC variables
    // TODO: %qi, etc.
    // http://hl7.org/fhir/uv/sdc/2019May/expressions.html#fhirpath-and-questionnaire

    final evaluationVariables = launchContextVariables;
    if (calculatedVariables != null) {
      evaluationVariables.addAll(calculatedVariables);
    }

    // TODO: This is a hack. fhir_path package is known to lack the functions for
    // score calculations, so if these are detected we use a hard-coded
    // scoring instead.
    final fhirPathResult = (fhirPathExpression !=
            'answers().sum(value.ordinal())')
        ? r4WalkFhirPath(
            responseResource,
            fhirPathExpression,
            evaluationVariables,
          )
        : [
            questionnaireModel.orderedQuestionnaireItemModels().fold<double>(
                  0.0,
                  (previousValue, element) =>
                      previousValue + (element.ordinalValue?.value ?? 0.0),
                )
          ];

    _logger.debug(
      'evaluateFhirPathExpression on $linkId: $fhirPathExpression = $fhirPathResult',
    );

    return fhirPathResult;
  }

  /// Returns whether the questionnaire meets all completeness criteria.
  ///
  /// Completeness criteria include:
  /// * All required fields are filled
  /// * All filled fields are valid
  ///
  /// Returns null, if everything is complete.
  /// Returns [QuestionnaireErrorFlag]s, if items are incomplete.
  Iterable<QuestionnaireErrorFlag>? get isQuestionnaireComplete {
    final errorFlags = <QuestionnaireErrorFlag>[];
    for (final itemModel in orderedQuestionnaireItemModels()) {
      final itemErrorFlags = itemModel.isComplete;
      if (itemErrorFlags != null) {
        errorFlags.addAll(itemErrorFlags);
      }
    }

    return (errorFlags.isNotEmpty) ? errorFlags : null;
  }

  void resetMarkers() {
    errorFlags.value = null;
  }

  final errorFlags = ValueNotifier<Iterable<QuestionnaireErrorFlag>?>(null);
}
