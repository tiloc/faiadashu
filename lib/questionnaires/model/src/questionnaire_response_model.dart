import 'dart:collection';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/foundation.dart';

import '../../../logging/logging.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

/// High-level model of a response to a questionnaire.
class QuestionnaireResponseModel extends ChangeNotifier {
  static final _logger = Logger(QuestionnaireResponseModel);

  // In which generation were the enabled items last determined?
  int _updateEnabledGeneration = -1;
  final List<Aggregator>? _aggregators;

  final QuestionnaireModel questionnaireModel;
  final LaunchContext launchContext;

  final Locale locale;

  int _generation = 1;

  final LinkedHashMap<String, FillerItemModel> _orderedFillerItems =
      LinkedHashMap<String, FillerItemModel>();

  // Questionnaire-level variables
  List<VariableModel>? _variables;

  bool get hasVariables => (_variables != null) && _variables!.isNotEmpty;

  List<VariableModel>? get variables => _variables;

  List<VariableModel>? get questionnaireLevelVariables => _variables;

  /// Constructor for empty model.
  ///
  /// Only sets up class fields, but does not enable any dynamic behavior.
  QuestionnaireResponseModel._({
    required this.locale,
    required this.questionnaireModel,
    required this.launchContext,
    required List<Aggregator>? aggregators,
  }) : _aggregators = aggregators {
    _variables =
        VariableModel.variables(questionnaireModel.questionnaire, null);
  }

  /// Create the model for a [QuestionnaireResponse].
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
  static Future<QuestionnaireResponseModel> fromFhirResourceBundle({
    required Locale locale,
    List<Aggregator>? aggregators,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
  }) async {
    _logger.debug('QuestionnaireModel.fromFhirResourceBundle');

    await fhirResourceProvider.init();

    final questionnaireModel = await QuestionnaireModel.fromFhirResourceBundle(
      fhirResourceProvider: fhirResourceProvider,
    );

    final questionnaireResponseModel = QuestionnaireResponseModel._(
      locale: locale,
      questionnaireModel: questionnaireModel,
      aggregators: aggregators ??
          [
            TotalScoreAggregator(),
            NarrativeAggregator(),
            QuestionnaireResponseAggregator()
          ],
      launchContext: launchContext,
    );

    questionnaireResponseModel._addFillerItems(
        null, null, questionnaireModel.siblings);

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
      questionnaireResponseModel
          .orderedResponseItemModels()
          .where((rim) => rim.questionnaireItemModel.hasInitialValue)
          .forEach((rim) {
        if (rim is QuestionItemModel) {
          rim.populateInitialValue();
        }
      });
    } else {
      questionnaireResponseModel.populate(response);
    }

    // Aggregators can only latch onto the model after its initial structure has been created
    final responseAggregators = questionnaireResponseModel._aggregators;
    if (responseAggregators != null) {
      for (final aggregator in responseAggregators) {
        aggregator.init(questionnaireResponseModel);
        // Assumption: aggregators that don't autoAggregate will have their aggregate method invoked manually when it matters.
        if (aggregator.autoAggregate) {
          aggregator.aggregate(notifyListeners: true);
        }
      }
    }

    // Set up updates for values of questionnaire-level variables
    if (questionnaireResponseModel.hasVariables) {
      questionnaireResponseModel._updateVariables();
      questionnaireResponseModel
          .addListener(questionnaireResponseModel._updateVariables);
    }

    // Set up calculatedExpressions on items
    questionnaireResponseModel._updateCalculations();
    questionnaireResponseModel
        .addListener(questionnaireResponseModel._updateCalculations);

    // Set up enableWhen behavior on items
    questionnaireResponseModel.activateEnableBehavior();

    // This ensures screen updates in case of invalid responses.
    questionnaireResponseModel.errorFlags.addListener(() {
      questionnaireResponseModel.nextGeneration();
    });

    return questionnaireResponseModel;
  }

  void _addGroupItem(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    _logger.trace('_addGroupItem $questionnaireItemModel');
    final groupItemModel = GroupItemModel(
        parentItem, parentAnswerIndex, this, questionnaireItemModel);
    _orderedFillerItems[groupItemModel.responseUid] = groupItemModel;

    _addFillerItems(groupItemModel, null, questionnaireItemModel.children);
  }

  void _addQuestionItem(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    _logger.trace('_addQuestionItem $questionnaireItemModel');
    final questionItemModel = QuestionItemModel(
        parentItem, parentAnswerIndex, this, questionnaireItemModel);

    _orderedFillerItems[questionItemModel.responseUid] = questionItemModel;
  }

  void _addDisplayItem(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    _logger.trace('_addDisplayItem $questionnaireItemModel');

    final displayItemModel = DisplayItemModel(
        parentItem, parentAnswerIndex, this, questionnaireItemModel);

    _orderedFillerItems[displayItemModel.responseUid] = displayItemModel;
  }

  void _addFillerItems(FillerItemModel? parentItem, int? parentAnswerIndex,
      List<QuestionnaireItemModel> questionnaireItemModels) {
    _logger.trace('_addFillerItems');
    for (final qim in questionnaireItemModels) {
      if (qim.isGroup) {
        _addGroupItem(parentItem, parentAnswerIndex, qim);
      } else if (qim.isQuestion) {
        _addQuestionItem(parentItem, parentAnswerIndex, qim);
      } else {
        _addDisplayItem(parentItem, parentAnswerIndex, qim);
      }
    }
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

  /// Returns a number that indicates whether the model has changed.
  int get generation => _generation;

  QuestionnaireResponseStatus _responseStatus =
      QuestionnaireResponseStatus.in_progress;

  QuestionnaireResponseStatus get responseStatus => _responseStatus;

  set responseStatus(QuestionnaireResponseStatus newStatus) {
    _responseStatus = newStatus;
    nextGeneration();
  }

  void _updateVariables() {
    _variables?.forEach((variableModel) {
      variableModel.updateValue(questionnaireResponse);
    });
  }

  void _populateItems(
    List<QuestionnaireResponseItem>? questionnaireResponseItems,
  ) {
    if (questionnaireResponseItems == null) {
      return;
    }
// FIXME: Restore functionality
    /*    for (final item in questionnaireResponseItems) {
      fromLinkId(item.linkId!).responseItem = item;
      _populateItems(item.item);
      if (item.answer != null) {
        for (final answer in item.answer!) {
          _populateItems(answer.item);
        }
      }
    } */
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
    orderedResponseItemModels()
        .where((rim) => rim.questionnaireItemModel.isCalculatedExpression)
        .forEach((rim) {
      if (rim is QuestionItemModel) {
        rim.updateCalculatedExpression();
      }
    });
  }

  /// Returns a bitfield of the items with `isEnabled` == true.
  List<bool> get _currentlyEnabledItems => List<bool>.generate(
        orderedFillerItemModels().length,
        (index) => orderedFillerItemModels().elementAt(index).isEnabled,
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
    if (questionnaireModel.itemsWithEnableWhen == null &&
        questionnaireModel.itemsWithEnableWhenExpression == null) {
      _logger.debug(
        'updateEnabledItems: no conditionally enabled items',
      );
      return;
    }

    final previouslyEnabled = _currentlyEnabledItems;
    _logger.trace('prevEnabled: $previouslyEnabled');
    for (final itemModel in orderedFillerItemModels()) {
      itemModel.enable();
    }

    // OPTIMIZE: This feels hacky
    if (questionnaireModel.itemsWithEnableWhen != null) {
      for (final qim in questionnaireModel.itemsWithEnableWhen!) {
        for (final fim in orderedFillerItemModels()
            .where((fim) => fim.questionnaireItemModel.linkId == qim.linkId)) {
          fim.updateEnabled();
        }
      }
    }

    // OPTIMIZE: This feels hacky
    if (questionnaireModel.itemsWithEnableWhenExpression != null) {
      for (final qim in questionnaireModel.itemsWithEnableWhenExpression!) {
        for (final fim in orderedFillerItemModels()
            .where((fim) => fim.questionnaireItemModel.linkId == qim.linkId)) {
          fim.updateEnabled();
        }
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
    if (questionnaireModel.itemsWithEnableWhenExpression != null) {
      // When enableWhenExpression is involved we need to add listeners to every
      // non-static item, as we have no way to find out which items are referenced
      // by the FHIR Path expression.
      addListener(() => updateEnabledItems());
    } else {
      for (final itemModel in orderedResponseItemModels()) {
        itemModel.questionnaireItemModel.forEnableWhens((qew) {
          itemModel
              .fromLinkId(qew.question!)
              .addListener(() => updateEnabledItems());
        });
      }
    }

    updateEnabledItems();
  }

  /// Returns the index of the first [FillerItemModel] which matches the predicate function.
  ///
  /// The items are examined as returned by [orderedFillerItemModels].
  ///
  /// Returns [notFound] if no matching item exists.
  int? indexOfFillerItem(
    bool Function(FillerItemModel) predicate, [
    int? notFound = -1,
  ]) {
    int index = 0;
    for (final fim in orderedFillerItemModels()) {
      if (predicate.call(fim)) {
        return index;
      }
      index++;
    }

    return notFound;
  }

  /// Returns the n-th item from the [orderedFillerItemModels].
  ///
  /// Items at indices can change, and this should not be cached.
  FillerItemModel itemFillerModelAt(int index) {
    return orderedFillerItemModels().toList().elementAt(index);
  }

  /// Returns the count of [ResponseItemModel]s which match the predicate function.
  ///
  /// Considers the item models returned by [orderedResponseItemModels].
  int count(bool Function(ResponseItemModel) predicate) {
    int count = 0;
    for (final rim in orderedResponseItemModels()) {
      if (predicate.call(rim)) {
        count++;
      }
    }

    return count;
  }

  /// Items can change, and this should not be cached.
  Iterable<FillerItemModel> orderedFillerItemModels() {
    return _orderedFillerItems.values;
  }

  /// Items can change, and this should not be cached.
  Iterable<ResponseItemModel> orderedResponseItemModels() {
    return _orderedFillerItems.values.whereType<ResponseItemModel>();
  }

  /// Returns whether the questionnaire meets all completeness criteria.
  ///
  /// Completeness criteria include:
  /// * All required fields are filled
  /// * All filled fields are valid
  /// * All expression-based constraints are satisfied
  ///
  /// Returns null, if everything is complete.
  /// Returns [QuestionnaireErrorFlag]s, if items are incomplete.
  Iterable<QuestionnaireErrorFlag>? get isQuestionnaireComplete {
    final errorFlags = <QuestionnaireErrorFlag>[];
    for (final itemModel in orderedResponseItemModels()) {
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

  /// Returns the [QuestionnaireErrorFlag] for an item with [responseUid].
  QuestionnaireErrorFlag? errorFlagForResponseUid(String responseUid) {
    return errorFlags.value
        ?.firstWhereOrNull((ef) => ef.responseUid == responseUid);
  }
}
