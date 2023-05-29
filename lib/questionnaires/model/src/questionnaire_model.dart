import 'dart:ui';

import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4.dart';

// TODO: Should this be modeled the same as usageMode?

/// Codes that guide the display of disabled questionnaire items
enum QuestionnaireDisabledDisplay {
  /// The item (and its children) should not be visible to the user at all.
  hidden,

  /// The item (and possibly its children) should not be selectable or editable
  /// but should still be visible - to allow the user to see what questions
  /// *could* have been completed had other answers caused the item to be
  /// enabled.
  protected,

  /// Same as [protected] for populated items, same as [hidden] for unpopulated items.
  ///
  /// see [FillerItemModel.isPopulated]
  protectedNonEmpty,
}

/// Models a questionnaire.
///
/// Higher-level abstraction of a FHIR domain [Questionnaire].
///
/// Any properties and functions that affect the overall questionnaire are provided by [QuestionnaireModel].
///
/// Properties and functions that affect an individual item are in [QuestionnaireItemModel].
///
/// [QuestionnaireModel] provides direct access to any [QuestionnaireItemModel] through linkId.
///
/// Responses and all dynamic behaviors are modeled through [QuestionnaireResponseModel].
///
class QuestionnaireModel {
  /// The FHIR [Questionnaire]
  final Questionnaire questionnaire;

  // OPTIMIZE: Can I get rid of _cachedItems because of _orderedItems?
  // Careful: _buildOrderedItems uses both to ensure the proper order of items!

  /// Maps linkId to [QuestionnaireItemModel]
  final _cachedItems = <String, QuestionnaireItemModel>{};
  final _orderedItems = <String, QuestionnaireItemModel>{};

  /// Direct access to [FhirResourceProvider]s for special use-cases.
  ///
  /// See also:
  /// * [getResource], which is the preferred access method.
  final FhirResourceProvider fhirResourceProvider;

  final QuestionnaireModelDefaults questionnaireModelDefaults;

  final Locale? locale;

  static final _logger = Logger(QuestionnaireModel);

  QuestionnaireModel._({
    required this.questionnaire,
    required this.fhirResourceProvider,
    required this.questionnaireModelDefaults,
    this.locale,
  }) {
    _buildOrderedItems();

    _calculateIsDynamicallyEnabled();
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
    required QuestionnaireModelDefaults questionnaireModelDefaults,
    Locale? locale,
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
      questionnaireModelDefaults: questionnaireModelDefaults,
      locale: locale,
    );

    await questionnaireModel.fhirResourceProvider.init();

    return questionnaireModel;
  }

  RenderingString? get title {
    final plainTitle = questionnaire.title;

    return (plainTitle != null)
        ? RenderingString.fromText(
            plainTitle,
            extensions: questionnaire.titleElement?.extension_,
          )
        : null;
  }

  /// Returns the questionnaire items of this questionnaire.
  List<QuestionnaireItemModel> get items => _orderedItems.values
      .where((qim) => qim.parent == null)
      .toList(growable: false);

  bool get hasNestedItems =>
      _orderedItems.values.any((qim) => qim.isNestedItem);

  Map<String, QuestionnaireItemModel> _addChildren(
    QuestionnaireItemModel qim,
  ) {
    _logger.trace('_addChildren $qim');
    final itemModelMap = <String, QuestionnaireItemModel>{};
    if (itemModelMap.containsKey(qim.linkId)) {
      throw QuestionnaireFormatException(
        'Duplicate linkId: ${qim.linkId}',
        qim,
      );
    }
    itemModelMap[qim.linkId] = qim;
    if (qim.hasChildren) {
      for (final child in qim.children) {
        itemModelMap.addAll(_addChildren(child));
      }
    }

    return itemModelMap;
  }

  void _buildOrderedItems() {
    final questionnaireItems = questionnaire.item;
    if (questionnaireItems == null) {
      _logger.warn('Questionnaire has no items');

      return;
    }

    final topLevelItemModels =
        buildModelsFromItems(questionnaireItems, null, 0);

    for (final topLevelItem in topLevelItemModels) {
      _orderedItems[topLevelItem.linkId] = topLevelItem;
      _orderedItems.addAll(_addChildren(topLevelItem));
    }
  }

  /// Returns an [Iterable] of [QuestionnaireItemModel]s in "pre-order".
  ///
  /// see: https://en.wikipedia.org/wiki/Tree_traversal
  Iterable<QuestionnaireItemModel> orderedQuestionnaireItemModels() {
    return _orderedItems.values;
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
    final result = _orderedItems[linkId];
    if (result == null) {
      throw QuestionnaireFormatException("Location '$linkId' not found.");
    } else {
      return result;
    }
  }

  QuestionnaireItemModel _createIfAbsent(
    QuestionnaireItem questionnaireItem,
    String linkId,
    QuestionnaireItemModel? parent,
    int level,
  ) {
    return _cachedItems.putIfAbsent(
      linkId,
      () => QuestionnaireItemModel(
        this,
        questionnaireItem,
        linkId,
        parent,
        level,
        locale,
      ),
    );
  }

  /// Build list of [QuestionnaireItemModel] from [QuestionnaireItem] and meta-data.
  List<QuestionnaireItemModel> buildModelsFromItems(
    List<QuestionnaireItem> items,
    QuestionnaireItemModel? parent,
    int level,
  ) {
    final itemModelList = <QuestionnaireItemModel>[];

    for (final item in items) {
      itemModelList.add(
        _createIfAbsent(
          item,
          item.linkId,
          parent,
          level,
        ),
      );
    }

    return itemModelList;
  }

  late final bool _isDynamicallyEnabled;

  /// Returns whether any item in this questionnaire is dynamically enabled.
  bool get isDynamicallyEnabled => _isDynamicallyEnabled;

  void _calculateIsDynamicallyEnabled() {
    _isDynamicallyEnabled = orderedQuestionnaireItemModels().any(
      (qim) =>
          qim.isEnabledWhen || qim.hasEnabledWhenExpression || qim.isNestedItem,
    );
  }
}
