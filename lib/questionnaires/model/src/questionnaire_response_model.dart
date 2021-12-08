import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:faiadashu/questionnaires/model/expression/src/fhir_expression_evaluator.dart';
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

  final List<FillerItemModel> _fillerItems = [];

  final _answerModels = <String, AnswerModel>{};

  // Questionnaire-level variables
  late final Iterable<FhirExpressionEvaluator> _variables;

  Iterable<ExpressionEvaluator>
      get _questionnaireBelowVariablesExpressionEvaluators {
    final questionnaireExpression = ResourceExpressionEvaluator(
      'questionnaire',
      () => questionnaireModel.questionnaire,
    );

    final questionnaireResponseExpression = ResourceExpressionEvaluator(
      'context',
      () => questionnaireResponse,
    );

    return [
      ..._launchContextExpressions,
      questionnaireResponseExpression,
      questionnaireExpression,
    ];
  }

  /// Questionnaire-level variables
  Iterable<ExpressionEvaluator> get questionnaireLevelExpressionEvaluators {
    return [..._questionnaireBelowVariablesExpressionEvaluators, ..._variables];
  }

  late final Iterable<ExpressionEvaluator> _launchContextExpressions;

  bool _enableWhenExpressionsActivated = false;

  /// Constructor for empty model.
  ///
  /// Only sets up class fields, but does not enable any dynamic behavior.
  QuestionnaireResponseModel._({
    required this.locale,
    required this.questionnaireModel,
    required this.launchContext,
    required List<Aggregator>? aggregators,
  }) : _aggregators = aggregators {
    // FIXME: According to spec I need to map launchcontext items to names from launchContext extension
    _launchContextExpressions = [
      ResourceExpressionEvaluator('patient', () => launchContext.patient),
    ];

    final variableExtensions = questionnaireModel.questionnaire.extension_
        ?.where((ext) => ext.url == variableExtensionUrl);

    if (variableExtensions != null) {
      final resource = questionnaireModel.questionnaire;
      final qLevelVars = <FhirExpressionEvaluator>[];
      for (final variableExtension in variableExtensions) {
        final variableExpression = variableExtension.valueExpression;
        if (variableExpression == null) {
          throw QuestionnaireFormatException(
            'Variable without expression.',
            resource,
          );
        }

        final variable = FhirExpressionEvaluator.fromExpression(
          () => questionnaireResponse,
          variableExpression,
          [..._questionnaireBelowVariablesExpressionEvaluators, ...qLevelVars],
        );

        qLevelVars.add(variable);
      }

      _variables = qLevelVars;
    } else {
      _variables = [];
    }
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
  /// If no [QuestionnaireResponse] has been provided here, it can still
  /// be provided through the [populate] function.
  static Future<QuestionnaireResponseModel> fromFhirResourceBundle({
    required Locale locale,
    List<Aggregator>? aggregators,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
    QuestionnaireModelDefaults questionnaireModelDefaults =
        const QuestionnaireModelDefaults(),
  }) async {
    _logger.debug('QuestionnaireModel.fromFhirResourceBundle');

    await fhirResourceProvider.init();

    final questionnaireModel = await QuestionnaireModel.fromFhirResourceBundle(
      fhirResourceProvider: fhirResourceProvider,
      questionnaireModelDefaults: questionnaireModelDefaults,
    );

    final questionnaireResponseModel = QuestionnaireResponseModel._(
      locale: locale,
      questionnaireModel: questionnaireModel,
      aggregators: aggregators ??
          [
            TotalScoreAggregator(),
            NarrativeAggregator(),
            QuestionnaireResponseAggregator(),
          ],
      launchContext: launchContext,
    );

    // Create the parts of the model that have no dependency on answers.
    // Groups, nested groups, and the first level of questions and display items.
    questionnaireResponseModel._addFillerItems(
      questionnaireResponseModel._fillerItems,
      null,
      questionnaireModel.items,
    );

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
    if (response == null) {
      questionnaireResponseModel
          .orderedQuestionItemModels()
          .forEach((qim) async {
        await qim.populateInitialValue();
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

    // Set up calculatedExpressions on items
    questionnaireResponseModel._updateCalculations();
    questionnaireResponseModel
        .addListener(questionnaireResponseModel._updateCalculations);

    // Set up enableWhen behavior on items
    questionnaireResponseModel._activateEnableBehavior();

    return questionnaireResponseModel;
  }

  void _addGroupItem(
    List<FillerItemModel> fillerItemList,
    ResponseNode? parentNode,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    _logger.trace('_addGroupItem $questionnaireItemModel');
    final groupItemModel = GroupItemModel(
      parentNode,
      this,
      questionnaireItemModel,
    );
    fillerItemList.add(groupItemModel);

    _addFillerItems(
      fillerItemList,
      groupItemModel,
      questionnaireItemModel.children,
    );
  }

  void _addQuestionItem(
    List<FillerItemModel> fillerItemList,
    ResponseNode? parentNode,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    _logger.trace('_addQuestionItem $questionnaireItemModel');
    final questionItemModel = QuestionItemModel(
      parentNode,
      this,
      questionnaireItemModel,
    );

    fillerItemList.add(questionItemModel);
  }

  void _addDisplayItem(
    List<FillerItemModel> fillerItemList,
    ResponseNode? parentNode,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    _logger.trace('_addDisplayItem $questionnaireItemModel');

    if (questionnaireItemModel.isHidden) {
      return;
    }

    final displayItemModel = DisplayItemModel(
      parentNode,
      this,
      questionnaireItemModel,
    );

    fillerItemList.add(displayItemModel);
  }

  void _addFillerItems(
    List<FillerItemModel> fillerItemList,
    ResponseNode? parentNode,
    List<QuestionnaireItemModel> questionnaireItemModels,
  ) {
    _logger.trace('_addFillerItems');
    for (final qim in questionnaireItemModels) {
      if (qim.isGroup) {
        _addGroupItem(fillerItemList, parentNode, qim);
      } else if (qim.isQuestion) {
        _addQuestionItem(fillerItemList, parentNode, qim);
      } else {
        _addDisplayItem(fillerItemList, parentNode, qim);
      }
    }
  }

  List<FillerItemModel> insertFillerItemsIfAbsent(
    ResponseNode parentNode,
    List<QuestionnaireItemModel> questionnaireItemModels,
  ) {
    final List<FillerItemModel> descendantFillerItems = [];
    _addFillerItems(
      descendantFillerItems,
      parentNode,
      questionnaireItemModels,
    );

    if (descendantFillerItems.isEmpty) {
      return descendantFillerItems;
    }

    // If they exist one, they exist all
    final firstUid = descendantFillerItems.first.nodeUid;
    final alreadyExists = _fillerItems.any((fim) => fim.nodeUid == firstUid);

    if (alreadyExists) {
      _logger.debug(
        'Not inserting descendants: $descendantFillerItems. Already exist.',
      );
      final existingFillerItems = <FillerItemModel>[];
      for (final fim in descendantFillerItems) {
        existingFillerItems.add(
          _fillerItems.firstWhere((element) => element.nodeUid == fim.nodeUid),
        );
      }

      return existingFillerItems;
    } else {
      _logger.debug(
        'Inserting new descendants: $descendantFillerItems',
      );

      // TODO: For a really clean solution, each individual answer would
      // also need to be modelled as a filler.
      final insertionPredecessor = (parentNode is FillerItemModel)
          ? parentNode
          : (parentNode as AnswerModel).responseItemModel;

      final insertionIndex = _fillerItems.indexOf(insertionPredecessor) + 1;

      _fillerItems.insertAll(
        insertionIndex,
        descendantFillerItems,
      );

      return descendantFillerItems;
    }
  }

  /// Returns an [Aggregator] of the given type.
  T aggregator<T extends Aggregator>() {
    if (_aggregators == null) {
      throw StateError('Aggregators have not been specified in constructor.');
    }

    // FIXME: better handle non-existent aggregator of requested type.
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

  void _populateItems(
    ResponseNode? parentNode,
    Iterable<ResponseItemModel> responseItemModels,
    List<QuestionnaireResponseItem>? questionnaireResponseItems,
  ) {
    _logger.trace('_populateItems parent ${parentNode?.nodeUid}');

    if (questionnaireResponseItems == null) {
      return;
    }

    for (final item in questionnaireResponseItems) {
      final linkId = item.linkId!;
      final qim = questionnaireModel.fromLinkId(linkId);
      final rim = responseItemModels.firstWhereOrNull(
        (rim) => rim.questionnaireItemModel.linkId == linkId,
      );
      if (qim.isGroup) {
        if (rim != null) {
          _logger.debug('Populating group $linkId into existing item $rim.');
          // Nothing to really populate for group
          // Populate children
          final childrenOfRim =
              orderedResponseItemModelsWithParent(parent: rim);
          _populateItems(
            rim,
            childrenOfRim,
            item.item,
          );
        } else {
          _logger.debug('Group $linkId not found');
          if (parentNode != null) {
            _logger.debug('Creating group $linkId.');
            // TODO: Create missing group and then populate.
          } else {
            _logger.warn('Top-level group $linkId does not exist. Data loss!');
          }
        }
      } else {
        // Individual question
        if (rim != null) {
          final qrim = rim as QuestionItemModel;
          _logger.debug(
            'Populating question response $linkId into existing item $qrim.',
          );

          qrim.populate(item);

          final itemAnswers = item.answer;
          if (itemAnswers != null && itemAnswers.isNotEmpty) {
            _logger.debug(
              'Populating answers under ${qrim.nodeUid}.',
            );
            itemAnswers.forEachIndexed((answerIndex, answer) {
              bool newAnswer = false;
              AnswerModel? addedAnswerModel;

              // Populate the answer models
              if (qrim.questionnaireItemModel.isCodingType) {
                // TODO: This is hacky!
                if (answerIndex == 0) {
                  addedAnswerModel = qrim.addAnswerModel();
                  addedAnswerModel.populateCodingAnswers(itemAnswers);
                  newAnswer = true;
                }
              } else {
                addedAnswerModel = qrim.addAnswerModel();
                addedAnswerModel.populate(answer);
                newAnswer = true;
              }

              if (newAnswer) {
                // If the answer had any nested items, then first ensure that the
                // required structures exist, then populate them as well.
                final answerResponseItems = answer.item;
                if (answerResponseItems != null &&
                    answerResponseItems.isNotEmpty) {
                  final descendantFillerItems = insertFillerItemsIfAbsent(
                    addedAnswerModel!,
                    qrim.questionnaireItemModel.children,
                  );

                  _populateItems(
                    addedAnswerModel,
                    descendantFillerItems.whereType<ResponseItemModel>(),
                    answerResponseItems,
                  );
                }
              }
            });
          }
        } else {
          // This should never happen! Items should have been created when
          // previous fields have been populated.
          throw StateError('Question response $linkId not found. Data loss!');
        }
      }
    }
  }

  /// Populate the answers in the questionnaire with the answers from a response.
  ///
  /// Does nothing if [questionnaireResponse] is null.
  ///
  /// This should only be invoked a single time, and only before the first UI build.
  void populate(QuestionnaireResponse? questionnaireResponse) {
    _logger.debug('Populating with $questionnaireResponse');
    if (questionnaireResponse == null) {
      return;
    }

    final questionnaireResponseItems = questionnaireResponse.item;

    if (questionnaireResponseItems == null ||
        questionnaireResponseItems.isEmpty) {
      return;
    }

    // OPTIMIZE: What is the best notification strategy?
    // Assumption: It would be better to first set all responses in bulk and then recalc.
    _populateItems(
      null,
      orderedResponseItemModelsWithParent(parent: null),
      questionnaireResponseItems,
    );

    responseStatus =
        questionnaireResponse.status ?? QuestionnaireResponseStatus.in_progress;
  }

  Future<void> _updateCalculations() async {
    orderedResponseItemModels()
        .where((rim) => rim.questionnaireItemModel.isCalculatedExpression)
        .forEach((rim) async {
      if (rim is QuestionItemModel) {
        await rim.updateCalculatedExpression();
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

    // OPTIMIZE: Is this check worth it?
    if (!orderedFillerItemModels().any(
      (fim) =>
          fim.questionnaireItemModel.isEnabledWhen ||
          fim.questionnaireItemModel.isEnabledWhenExpression ||
          fim.questionnaireItemModel.isNestedItem,
    )) {
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

    for (final fim in orderedFillerItemModels().where(
      (fim) =>
          fim.questionnaireItemModel.isEnabledWhen ||
          fim.questionnaireItemModel.isEnabledWhenExpression ||
          fim.questionnaireItemModel.isNestedItem,
    )) {
      fim.updateEnabled();
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
  void _activateEnableBehavior() {
    final hasEnabledWhenExpressions = orderedFillerItemModels()
        .any((fim) => fim.questionnaireItemModel.isEnabledWhenExpression);

    if (hasEnabledWhenExpressions) {
      // When enableWhenExpression is involved we need to add listeners to every
      // non-static item (or the overall response model), as we have no way to
      // find out which items are referenced by the FHIRPath expression.
      if (!_enableWhenExpressionsActivated) {
        addListener(() => updateEnabledItems());
        _enableWhenExpressionsActivated = true;
      }
    } else {
      // Activate enable behavior on individual items
      for (final itemModel in orderedFillerItemModels()) {
        itemModel.activateEnableBehavior();
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

  /// Returns the count of [QuestionItemModel]s which match the predicate function.
  ///
  /// Considers the item models returned by [orderedQuestionItemModels].
  ///
  /// The limitation to questions is in place to prevent groups from being counted.
  int count(bool Function(QuestionItemModel) predicate) {
    int count = 0;
    for (final qim in orderedQuestionItemModels()) {
      if (predicate.call(qim)) {
        count++;
      }
    }

    return count;
  }

  /// Items can change, and this should not be cached.
  Iterable<FillerItemModel> orderedFillerItemModels() {
    return _fillerItems;
  }

  /// Items can change, and this should not be cached.
  Iterable<FillerItemModel> orderedFillerItemModelsWithParent({
    required ResponseNode? parent,
  }) {
    return _fillerItems.where((fim) => fim.parentNode == parent);
  }

  /// Items can change, and this should not be cached.
  Iterable<ResponseItemModel> orderedResponseItemModels() {
    return _fillerItems.whereType<ResponseItemModel>();
  }

  /// Items can change, and this should not be cached.
  Iterable<ResponseItemModel> orderedResponseItemModelsWithParent({
    required ResponseNode? parent,
  }) {
    return _fillerItems
        .whereType<ResponseItemModel>()
        .where((rim) => rim.parentNode == parent);
  }

  /// Items can change, and this should not be cached.
  Iterable<QuestionItemModel> orderedQuestionItemModels() {
    return _fillerItems.whereType<QuestionItemModel>();
  }

  /// [AnswerModel]s in the order in which they were previously added
  /// through [addAnswerModel].
  Iterable<AnswerModel> orderedAnswerModels(
    QuestionItemModel questionItemModel,
  ) {
    return _answerModels.values
        .where((am) => am.parentNode == questionItemModel);
  }

  /// Add an [AnswerModel] to the list of known [AnswerModel]s.
  void addAnswerModel(AnswerModel answerModel) {
    _answerModels[answerModel.nodeUid] = answerModel;
    nextGeneration(notifyListeners: false);
  }

  void removeAnswerModel(AnswerModel answerModel) {
    _answerModels.remove(answerModel.nodeUid);
    nextGeneration();
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
  Future<Iterable<QuestionnaireErrorFlag>?> get isQuestionnaireComplete async {
    final errorFlags = <QuestionnaireErrorFlag>[];
    for (final itemModel in orderedResponseItemModels()) {
      final itemErrorFlags = await itemModel.isComplete;
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

  /// Returns the [QuestionnaireErrorFlag] for an item with [nodeUid].
  QuestionnaireErrorFlag? errorFlagForNodeUid(String responseUid) {
    return errorFlags.value
        ?.firstWhereOrNull((ef) => ef.nodeUid == responseUid);
  }
}
