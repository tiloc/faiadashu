import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

/// High-level model of a response to a questionnaire.
class QuestionnaireResponseModel {
  static final _logger = Logger(QuestionnaireResponseModel);

  /// Notifies listeners when items have been added or removed dynamically.
  ///
  /// This is meant for filler views to update their internal data model.
  final structuralChangeNotifier = ValueNotifier<int>(-1);

  /// Notifies listeners when the value of any answer has changed.
  ///
  /// This is meant for aggregators, such as total score.
  ///
  /// Since values also become valid/invalid when enablement changes, this
  /// will also trigger when enablement has changed.
  ///
  /// Since values are also considered new/changed when the structure has changed,
  /// this will also trigger when structure has changed.
  final valueChangeNotifier = ValueNotifier<int>(-1);

  // TODO: Notifying on changed validity would allow for richer progress bars.
  /// Notifies listeners when answered/populated of any answer has changed.
  ///
  /// This is meant for progress bars.
  ///
  /// Since values also become answered/unanswered when enablement changes, this
  /// will also trigger when enablement has changed.
  ///
  /// Since values are also considered new/changed when the structure has changed,
  /// this will also trigger when structure has changed.
  final answeredChangeNotifier = ValueNotifier<int>(-1);

  // In which generation were the enabled items last determined?
  int _updateEnabledGeneration = -1;

  final List<Aggregator>? _aggregators;

  final QuestionnaireModel questionnaireModel;
  final LaunchContext launchContext;

  final Locale locale;

  int _generation = 1;

  final List<FillerItemModel> _fillerItems = [];

  /// Maps UIDs to [AnswerModel]s.
  final _answerModels = <String, AnswerModel>{};

  // Questionnaire-level variables
  late final Iterable<FhirExpressionEvaluator> _variables;

  Iterable<ExpressionEvaluator>
      get _questionnaireBelowVariablesExpressionEvaluators {
    final questionnaireExpression = ResourceExpressionEvaluator(
      'questionnaire',
      () => questionnaireModel.questionnaire,
    );

    // The %resource variable when it appears in expressions on elements in
    // Questionnaire will be evaluated as the root of the QuestionnaireResponse.
    final questionnaireResponseExpression = ResourceExpressionEvaluator(
      'resource',
      () => createQuestionnaireResponseForFhirPath(),
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

  bool _visibilityActivated = false;

  /// Constructor for empty model.
  ///
  /// Only sets up class fields, but does not enable any dynamic behavior.
  QuestionnaireResponseModel._({
    required this.locale,
    required this.questionnaireModel,
    required this.launchContext,
    required List<Aggregator>? aggregators,
  }) : _aggregators = aggregators {
    _setupLaunchContext();
    _setupVariables();
  }

  void _setupLaunchContext() {
    // TODO: Implement https://jira.hl7.org/browse/FHIR-32644
    _launchContextExpressions = [
      ResourceExpressionEvaluator('patient', () => launchContext.patient),
    ];
  }

  void _setupVariables() {
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
          () => createQuestionnaireResponseForFhirPath(),
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
      locale: locale,
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

    // Aggregators (the [QuestionnaireResponseAggregator] in particular)
    // need to be initialized for initialExpression to work.
    final responseAggregators = questionnaireResponseModel._aggregators;
    if (responseAggregators != null) {
      for (final aggregator in responseAggregators) {
        aggregator.init(questionnaireResponseModel);
      }
    }

    // Populate initial values if response == null
    if (response == null) {
      questionnaireResponseModel
          .orderedQuestionItemModels()
          .forEach((qim) async {
        qim.populateInitialValue();
      });
    } else {
      questionnaireResponseModel.populate(response);
    }

    // Aggregators can only latch onto the model after its initial structure has been created
    if (responseAggregators != null) {
      for (final aggregator in responseAggregators) {
        // Assumption: aggregators that don't autoAggregate will have their aggregate method invoked manually when it matters.
        if (aggregator.autoAggregate) {
          aggregator.aggregate(notifyListeners: true);
        }
      }
    }

    // Set up calculatedExpressions on items
    questionnaireResponseModel._updateCalculations();
    questionnaireResponseModel.valueChangeNotifier
        .addListener(questionnaireResponseModel._updateCalculations);

    // Set up dynamic enableWhen behavior on items
    questionnaireResponseModel._activateEnablement();

    // Calculate visibility for every item
    for (final fillerItemModel
        in questionnaireResponseModel.orderedFillerItemModels()) {
      fillerItemModel.structuralNextGeneration(notifyListeners: false);
      fillerItemModel.handleResponseStatusChange();
    }

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
  ///
  /// Throws StateError if such an Aggregator does not exist.
  T aggregator<T extends Aggregator>() {
    if (_aggregators == null) {
      throw StateError('Aggregators have not been specified in constructor.');
    }

    final aggregator =
        _aggregators?.firstWhere((aggregator) => aggregator is T) as T?;

    if (aggregator == null) {
      throw StateError('Aggregator not found. Aggregators: $_aggregators');
    } else {
      return aggregator;
    }
  }

  /// Changes the [generation] and notifies all listeners.
  ///
  /// Each generation is unique during a run of the application.
  void nextGeneration({
    bool notifyListeners = true,
    bool isValueChange = true,
    bool isStructuralChange = true,
    bool isAnsweredChange = true,
  }) {
    final newGeneration = _generation + 1;
    _logger.debug(
      'nextGeneration notify: $notifyListeners|value: $isValueChange|answered: $isAnsweredChange|structural: $isStructuralChange|$_generation -> $newGeneration',
    );
    _generation = newGeneration;

    // Invalidate cached items
    _cachedQuestionnaireResponse = null;

    if (notifyListeners) {
      if (isValueChange || isStructuralChange) {
        valueChangeNotifier.value = newGeneration;
      }
      if (isStructuralChange) {
        structuralChangeNotifier.value = newGeneration;
      }
      if (isAnsweredChange || isStructuralChange) {
        answeredChangeNotifier.value = newGeneration;
      }
    }
  }

  Map<String, dynamic>? _cachedQuestionnaireResponse;

  /// INTERNAL ONLY - Returns a FHIR JSON fragment for a node with a given [uid].
  Map<String, dynamic>? fhirResponseItemByUid(String uid) {
    _cachedQuestionnaireResponse ??=
        aggregator<QuestionnaireResponseAggregator>().aggregateResponseItems();

    return _cachedQuestionnaireResponse?[uid] as Map<String, dynamic>?;
  }

  /// Returns a FHIR [QuestionnaireResponse] for use with FHIRPath.
  ///
  /// Does not include disabled items, as these should not be visible to FHIRPath.
  /// Does not include a narrative, as this is costly and not used in real-world.
  ///
  /// The response matches the model as of the current generation.
  QuestionnaireResponse? createQuestionnaireResponseForFhirPath() {
    _cachedQuestionnaireResponse ??=
        aggregator<QuestionnaireResponseAggregator>().aggregateResponseItems(
      responseStatus: QuestionnaireResponseStatus.completed,
      generateNarrative: false,
    );

    return _cachedQuestionnaireResponse?[QuestionnaireResponseAggregator
        .questionnaireResponseKey] as QuestionnaireResponse?;
  }

  /// Returns a number that indicates whether the model has changed.
  int get generation => _generation;

  final responseStatusNotifier = ValueNotifier<QuestionnaireResponseStatus>(
    QuestionnaireResponseStatus.in_progress,
  );

  QuestionnaireResponseStatus get responseStatus =>
      responseStatusNotifier.value;

  set responseStatus(QuestionnaireResponseStatus newStatus) {
    responseStatusNotifier.value = newStatus;
  }

  Id? _id;
  Id? get id => _id;

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

    _id = questionnaireResponse.id;

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

  void _updateCalculations() {
    orderedResponseItemModels()
        .where((rim) => rim.questionnaireItemModel.isCalculatedExpression)
        .forEach((rim) async {
      if (rim is QuestionItemModel) {
        rim.updateCalculatedExpression();
      }
    });
  }

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

    if (!questionnaireModel.isDynamicallyEnabled) {
      _logger.debug(
        'updateEnabledItems: no conditionally enabled items',
      );

      return;
    }

    for (final itemModel in orderedFillerItemModels()) {
      itemModel.nextGenerationEnable();
    }

    bool hasEnablementChanged = false;
    for (final fim in orderedFillerItemModels().where(
      (fim) => fim.isDynamicallyEnabled,
    )) {
      fim.updateEnabled();
    }

    // Go over all items, since the previous loop would not catch
    // updates in descendants.
    for (final fim in orderedFillerItemModels()) {
      hasEnablementChanged |= fim.enableNextGeneration();
    }

    if (hasEnablementChanged) {
      nextGeneration(
        notifyListeners: notifyListeners,
        isStructuralChange: false,
      );
    } else {
      _logger.debug('Enabled items unchanged.');
    }
  }

  /// Activate the dynamic enablement and visibility behaviors.
  ///
  /// * Adds the required listeners to evaluate enableWhen and
  /// enableWhenExpression as items are changed.
  ///
  /// * Adds the required listeners to update visibility based on
  /// questionnaire response status
  ///
  /// Idempotent: Will only execute once during the lifetime of this model.
  void _activateEnablement() {
    if (!_visibilityActivated) {
      // Initial calculation of all enablement.
      updateEnabledItems();

      final hasEnabledWhenExpressions = orderedFillerItemModels()
          .any((fim) => fim.questionnaireItemModel.hasEnabledWhenExpression);

      if (hasEnabledWhenExpressions) {
        // When enableWhenExpression is involved we need to add listeners to every
        // non-static item as we have no way to
        // find out which items are referenced by the FHIRPath expression.
        for (final itemModel in orderedResponseItemModels()) {
          itemModel.addListener(() => updateEnabledItems());
        }
      } else {
        // Activate enable behavior on individual items with surgical precision
        for (final itemModel in orderedFillerItemModels()) {
          itemModel.activateEnableWhen();
        }
      }

      // Add visibility change on response status change.
      responseStatusNotifier.addListener(() {
        for (final itemModel in orderedFillerItemModels()) {
          itemModel.handleResponseStatusChange();
        }
      });

      _visibilityActivated = true;
    }
  }

  // TODO: This is only used by QuestionnaireScrollerState
  // Remove from public API?

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

  // TODO: Should this live in the model, or should it go to a
  // class on the view level (QuestionnaireResponseFiller)? Should I mirror
  // AnimatedList?

  /// Drive all structural model changes to the next stage.
  ///
  /// This changes all items in state [StructuralState.adding] to
  /// [StructuralState.present] and notifies the listeners on the
  /// items if such a change happened. For items already in state
  /// [StructuralState.present] this is a no-op.
  void structuralNextGeneration({bool notifyListeners = true}) {
    orderedFillerItemModels().forEach((fim) {
      fim.structuralNextGeneration(notifyListeners: notifyListeners);
    });
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

  /// Return the [FillerItemModel] that corresponds to the given [uid].
  ///
  /// Will return the parent [QuestionItemModel] if uid corresponds to an answer.
  FillerItemModel? fillerItemModelByUid(String uid) {
    final fillerItem =
        orderedFillerItemModels().firstWhereOrNull((fim) => fim.nodeUid == uid);
    if (fillerItem != null) {
      return fillerItem;
    }

    final answerModel = _answerModels[uid];

    return answerModel == null
        ? null
        : answerModel.parentNode! as QuestionItemModel;
  }

  /// Validates whether the questionnaire meets all completeness criteria.
  ///
  /// **Completeness criteria:**
  ///
  /// * All required fields are filled
  /// * All filled fields are valid
  /// * All expression-based constraints are satisfied
  ///
  /// Returns null, if everything is complete.
  /// Returns a map (UID -> error text) with incomplete entries, if items are incomplete.
  Map<String, String>? validate({
    bool updateErrorText = true,
    bool notifyListeners = false,
  }) {
    final invalidMap = <String, String>{};

    for (final itemModel in orderedResponseItemModels()) {
      final errorTexts = itemModel.validate(
        updateErrorText: updateErrorText,
        notifyListeners: notifyListeners,
      );
      if (errorTexts != null) {
        _logger.debug('$itemModel is invalid.');

        invalidMap.addAll(errorTexts);
      }
    }

    return invalidMap.isNotEmpty ? invalidMap : null;
  }

  /// A map of UIDs -> error texts of invalid [ResponseNode]s.
  /// Is [null] when no items are currently invalid.
  ///
  /// This should only be updated when a global response is desired,
  /// such as the overall filler navigating to an invalid item.
  ///
  /// For local responses, only the local error text, data absent reason, etc.
  /// should be updated.
  ///
  /// see: [answeredChangeNotifier]
  final invalidityNotifier =
      ValueNotifier<Map<String, String>?>(<String, String>{});
}
