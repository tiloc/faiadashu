import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:faiadashu/coding/coding.dart';
import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/primitive_types/primitive_types.dart';
import 'package:fhir/r4/r4.dart';
import 'package:fhir_path/fhir_path.dart';

/// Model a response item to a question.
///
/// A single response might reference multiple answers.
class QuestionItemModel extends ResponseItemModel {
  static final _qimLogger = Logger(QuestionItemModel);

  Code? _dataAbsentReason;

  /// Reason why this response is empty.
  ///
  /// see [DataAbsentReason]
  Code? get dataAbsentReason => _dataAbsentReason;

  set dataAbsentReason(Code? newDataAbsentReason) {
    if (_dataAbsentReason != newDataAbsentReason) {
      _dataAbsentReason = newDataAbsentReason;
      nextGeneration(
        isStructuralChange: false,
        isAnsweredChange: true,
      );
    }
  }

  late final FhirExpressionEvaluator? _calculatedExpression;

  QuestionItemModel(
    super.parentNode,
    super.questionnaireResponseModel,
    super.itemModel,
  ) {
    final calculatedExpression = questionnaireItemModel.calculatedExpression;
    _calculatedExpression = (calculatedExpression != null)
        ? FhirExpressionEvaluator.fromExpression(
            null,
            calculatedExpression,
            [
              ...itemWithPredecessorsExpressionEvaluators,
            ],
            jsonBuilder: () =>
                questionnaireResponseModel.fhirResponseItemByUid(nodeUid),
          )
        : null;
  }

  void populate(QuestionnaireResponseItem? responseItem) {
    dataAbsentReason = responseItem?.extension_?.dataAbsentReason;
  }

  /// Is the response 'asked but declined'
  bool get isAskedButDeclined =>
      dataAbsentReason == dataAbsentReasonAskedButDeclinedCode;

  /// Triggers all required activities when any of the answers have changed.
  ///
  /// Creates nested fillers if needed.
  void handleChangedAnswer(
    AnswerModel answerModel, {
    required bool isAnsweredChange,
  }) {
    final flow = Flow.begin();
    Timeline.startSync('handleChangedAnswer', flow: flow);
    bool isStructuralChange = false;

    if (answerModel.value != null) {
      // An answer has been provided, check whether a nested filler structure needs to be created.
      if (questionnaireItemModel.hasChildren) {
        final fillerItems = questionnaireResponseModel
            .orderedFillerItemModels()
            .toList(growable: false);

        // Nested structural items exist. Create fillers.
        final descendantItems =
            questionnaireResponseModel.insertFillerItemsIfAbsent(
          answerModel,
          questionnaireItemModel.children,
        );

        final newFillerItems = questionnaireResponseModel
            .orderedFillerItemModels()
            .toList(growable: false);

        isStructuralChange =
            !const ListEquality().equals(fillerItems, newFillerItems);

        // Activate dynamic behavior
        for (final item in descendantItems) {
          item.activateEnableWhen();
        }

        questionnaireResponseModel.updateEnabledItems();
      }
    }

    // Updates all error texts, but will not notify.
    validate();

    nextGeneration(
      flow: Flow.end(flow.id),
      isAnsweredChange: isAnsweredChange,
      isStructuralChange: isStructuralChange,
    );
    Timeline.finishSync();
  }

  /// Changes the generation and notifies all listeners.
  ///
  /// Each generation is unique during a run of the application.
  void nextGeneration({
    Flow? flow,
    required bool isAnsweredChange,
    required bool isStructuralChange,
  }) {
    Timeline.timeSync(
      'QuestionItemModel.nextGeneration',
      () {
        questionnaireResponseModel.nextGeneration(
          isAnsweredChange: isAnsweredChange,
          isStructuralChange: isStructuralChange,
        );
        // This notifies aggregators on changes to individual items
        notifyListeners();
      },
      flow: flow,
    );
  }

  /// Is this response invalid?
  ///
  /// This is currently entirely based on the [dataAbsentReason].
  @override
  bool get isInvalid {
    _qimLogger.trace('isInvalid $nodeUid');

    return dataAbsentReason == dataAbsentReasonAsTextCode;
  }

  /// Returns a [Decimal] value which can be added to a score.
  ///
  /// Returns null if not applicable (either question unanswered, or wrong type)
  Decimal? get ordinalValue {
    final answerModel = firstAnswerModel;

    return answerModel.isNotEmpty &&
            answerModel is CodingAnswerModel &&
            !questionnaireItemModel.isRepeating
        ? answerModel.singleSelection?.fhirOrdinalValue
        : null;
  }

  /// Returns all answers belonging to this question.
  Iterable<AnswerModel> get answerModels {
    return questionnaireResponseModel.orderedAnswerModels(this);
  }

  // Ensures at least a single answer model exists.
  void _ensureAnswerModel() {
    final existingAnswers = answerModels;
    if (existingAnswers.isEmpty) {
      addAnswerModel();
    }
  }

  @override
  Map<String, String>? validate({
    bool updateErrorText = true,
    bool notifyListeners = false,
  }) {
    // Non-existent answer models can be invalid, e.g. if minOccurs is not met.
    _ensureAnswerModel();

    final responseErrorTexts = super.validate(
          updateErrorText: updateErrorText,
          notifyListeners: notifyListeners,
        ) ??
        <String, String>{};

    final answersErrorTexts = <String, String>{};
    for (final am in answerModels) {
      final answerValidationText = am.validate(
        updateErrorText: updateErrorText,
        notifyListeners: notifyListeners,
      );

      if (answerValidationText != null) {
        answersErrorTexts[am.nodeUid] = answerValidationText;
      }
    }

    final combinedErrorTexts = responseErrorTexts..addAll(answersErrorTexts);

    return responseErrorTexts.isEmpty && answersErrorTexts.isEmpty
        ? null
        : combinedErrorTexts;
  }

  @override
  bool get isAnswered {
    _qimLogger.trace('isAnswered $nodeUid');
    if (!isAnswerable) {
      return false;
    }

    return answerModels.any((am) => am.isNotEmpty);
  }

  @override
  bool get isUnanswered {
    if (!isAnswerable) {
      return false;
    }

    final returnValue = answerModels.every((am) => am.isEmpty);
    _qimLogger.debug('isUnanswered $nodeUid: $returnValue');

    return returnValue;
  }

  @override
  bool get isPopulated {
    return answerModels.any((am) => am.isNotEmpty);
  }

  /// Add the next answer to this response.
  ///
  /// Returns the newly added [AnswerModel].
  AnswerModel addAnswerModel() {
    final newAnswerModel = _createAnswerModel();
    questionnaireResponseModel.addAnswerModel(newAnswerModel);

    return newAnswerModel;
  }

  void removeAnswerModel(AnswerModel answerModel) {
    questionnaireResponseModel.removeAnswerModel(answerModel);
  }

  /// Returns the [AnswerModel] which has been added last.
  AnswerModel get latestAnswerModel {
    _ensureAnswerModel();

    return answerModels.last;
  }

  /// Returns the [AnswerModel] which has been added first.
  AnswerModel get firstAnswerModel {
    _ensureAnswerModel();

    return answerModels.first;
  }

  /// Returns the [AnswerModel]s which have been answered.
  Iterable<AnswerModel> get answeredAnswerModels {
    return answerModels.where((am) => am.isNotEmpty);
  }

  /// Returns the [AnswerModel]s which have been answered,
  /// plus potentially one extra empty one.
  Iterable<AnswerModel> get fillableAnswerModels {
    _ensureAnswerModel();

    final latestAnswerModel = this.latestAnswerModel;

    return answerModels.where((am) => am.isNotEmpty || am == latestAnswerModel);
  }

  /// Creates a new [AnswerModel] of the type for this question.
  AnswerModel _createAnswerModel() {
    final AnswerModel? answerModel;

    switch (questionnaireItemModel.questionnaireItem.type) {
      case QuestionnaireItemType.choice:
      case QuestionnaireItemType.open_choice:
        answerModel = CodingAnswerModel(this);
        break;
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        answerModel = NumericalAnswerModel(this);
        break;
      case QuestionnaireItemType.string:
      case QuestionnaireItemType.text:
      case QuestionnaireItemType.url:
        answerModel = StringAnswerModel(this);
        break;
      case QuestionnaireItemType.date:
      case QuestionnaireItemType.datetime:
      case QuestionnaireItemType.time:
        answerModel = DateTimeAnswerModel(this);
        break;
      case QuestionnaireItemType.boolean:
        answerModel = BooleanAnswerModel(this);
        break;
      case QuestionnaireItemType.display:
        throw UnsupportedError("Items of type 'display' do not have answers.");
      case QuestionnaireItemType.group:
        throw UnsupportedError("Items of type 'group' do not have answers.");
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
        // Throwing an exception here would lead to breakage of filler.
        answerModel = UnsupportedAnswerModel(this);
    }

    return answerModel;
  }

  /// Populates the initial value of the item.
  /// Does nothing if initial value is not specified.
  void populateInitialValue() {
    _qimLogger.debug('populateInitialValue: $nodeUid');
    if (questionnaireItemModel.hasInitialExpression) {
      final initialEvaluationResult = evaluateInitialExpression();
      firstAnswerModel.populateFromExpression(initialEvaluationResult);
    } else {
      // initial.value[x]
      final initialValues = questionnaireItem.initial;

      if (initialValues != null) {
        final initialValue = initialValues.first;

        switch (questionnaireItem.type) {
          case QuestionnaireItemType.integer:
            firstAnswerModel
                .populateFromExpression(initialValue.valueInteger?.value);
            break;
          case QuestionnaireItemType.decimal:
            firstAnswerModel
                .populateFromExpression(initialValue.valueDecimal?.value);
            break;
          case QuestionnaireItemType.string:
            firstAnswerModel.populateFromExpression(initialValue.valueString);
            break;
          case QuestionnaireItemType.date:
            firstAnswerModel.populateFromExpression(initialValue.valueDate);
            break;
          case QuestionnaireItemType.datetime:
            firstAnswerModel.populateFromExpression(initialValue.valueDateTime);
            break;
          case QuestionnaireItemType.boolean:
            firstAnswerModel.populateFromExpression(initialValue.valueBoolean);
            break;
          case QuestionnaireItemType.choice:
          case QuestionnaireItemType.open_choice:
            final initialCodings = initialValues
                .where((qiv) => qiv.valueCoding != null)
                .map<Coding>((qiv) => qiv.valueCoding!);

            final initialOpenTexts = initialValues
                .where((qiv) => qiv.valueString != null)
                .map<String>((qiv) => qiv.valueString!);

            (firstAnswerModel as CodingAnswerModel)
                .populateFromCodings(initialCodings, initialOpenTexts);
            break;
          default:
            // TODO: Implement for more types
            _qimLogger.warn(
              'No support for initial value on ${questionnaireItem.linkId}.',
            );
        }
      }
    }
  }

  /// Returns the value of the initialExpression.
  ///
  /// Returns null if the item does not have an initialExpression,
  /// or it evaluates to an empty list.
  dynamic evaluateInitialExpression() {
    final fhirPathExpression =
        questionnaireItemModel.questionnaireItem.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression',
            )
            ?.valueExpression;

    if (fhirPathExpression == null) {
      return null;
    }

    final initialExpressionEvaluator = FhirExpressionEvaluator.fromExpression(
      null,
      fhirPathExpression,
      questionnaireResponseModel.questionnaireLevelExpressionEvaluators,
    );

    final evaluationResult = initialExpressionEvaluator.evaluate(
      generation: questionnaireResponseModel.generation,
    );

    if (evaluationResult is! List || evaluationResult.isEmpty) {
      return null;
    }

    return evaluationResult.first;
  }

  void updateCalculatedExpression() {
    final calculatedExpression = _calculatedExpression;
    if (calculatedExpression == null) {
      return;
    }

    try {
      final rawEvaluationResult = calculatedExpression.evaluate(
        generation: questionnaireResponseModel.generation,
      );

      _qimLogger.debug('calculatedExpression: $rawEvaluationResult');

      final evaluationResult =
          (rawEvaluationResult is List && rawEvaluationResult.isNotEmpty)
              ? rawEvaluationResult.first
              : null;

      // TODO: This should be able to populate multiple answers from a list of results
      // Write the value back to the answer model
      firstAnswerModel.populateFromExpression(evaluationResult);
    } catch (ex) {
      errorText =
          (ex is FhirPathEvaluationException) ? ex.message : ex.toString();
      _qimLogger.warn('Calculation problem: $_calculatedExpression', error: ex);
      notifyListeners(); // This could be added to a setter for errorText, but might have side-effects.
    }
  }
}
