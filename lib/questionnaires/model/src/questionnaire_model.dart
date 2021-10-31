// Going with 'part of' here. 'import' would be preferred, but would force me to
// expose numerous internal methods to the public.
part of 'questionnaire_item_model.dart';

/// Models a questionnaire.
///
/// Higher-level abstraction of a FHIR domain [Questionnaire].
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

  /// Direct access to [FhirResourceProvider]s for special use-cases.
  ///
  /// see: [getResource] for the preferred access method.
  final FhirResourceProvider fhirResourceProvider;
  static final _logger = Logger(QuestionnaireModel);

  QuestionnaireModel._({
    required Questionnaire questionnaire,
    required this.fhirResourceProvider,
  }) : super._(
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
  }

  /// Create the model for a [Questionnaire].
  ///
  /// Will introspect the provided [fhirResourceProvider] to locate a
  /// * mandatory [Questionnaire]
  /// * optional [ValueSet]
  ///
  /// Will throw [Error]s in case the [Questionnaire] has no items.
  ///
  /// The [fhirResourceProvider] is used for access to any required resources,
  /// such as ValueSets.
  static Future<QuestionnaireModel> fromFhirResourceBundle({
    required FhirResourceProvider fhirResourceProvider,
  }) async {
    _logger.debug('QuestionnaireModel.fromFhirResourceBundle');

    final questionnaire = await fhirResourceProvider
        .getAsyncResource(questionnaireResourceUri) as Questionnaire?;

    if (questionnaire == null) {
      throw StateError('No Questionnaire has been provided.');
    }

    final questionnaireModel = QuestionnaireModel._(
      questionnaire: questionnaire,
      fhirResourceProvider: fhirResourceProvider,
    );

    await questionnaireModel.fhirResourceProvider.init();

    return questionnaireModel;
  }

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
}
