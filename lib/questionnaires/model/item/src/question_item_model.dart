import 'package:faiadashu/questionnaires/model/expression/src/fhir_expression_evaluator.dart';
import 'package:fhir/r4.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

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
      nextGeneration();
    }
  }

  late final FhirExpressionEvaluator? _calculatedExpression;

  QuestionItemModel(
    ResponseNode? parentNode,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel itemModel,
  ) : super(
          parentNode,
          questionnaireResponseModel,
          itemModel,
        ) {
    final calculatedExpression = questionnaireItemModel.calculatedExpression;
    // FIXME: Determine all upstream inputs.
    _calculatedExpression = (calculatedExpression != null)
        ? FhirExpressionEvaluator.fromExpression(
            () => questionnaireResponseModel.questionnaireResponse,
            calculatedExpression,
            [
              ...questionnaireResponseModel
                  .questionnaireLevelExpressionEvaluators,
            ],
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
  void onAnswerChanged(AnswerModel answerModel) {
    if (answerModel.value != null) {
      // An answer has been provided, check whether a nested filler structure needs to be created.
      if (questionnaireItemModel.hasChildren) {
        // Nested structural items exist. Create fillers.
        final descendantItems =
            questionnaireResponseModel.insertFillerItemsIfAbsent(
          answerModel,
          questionnaireItemModel.children,
        );

        // Activate dynamic behavior
        for (final item in descendantItems) {
          item.activateEnableBehavior();
        }

        questionnaireResponseModel.updateEnabledItems();
      }
    }

    nextGeneration();
  }

  /// Changes the generation and notifies all listeners.
  ///
  /// Each generation is unique during a run of the application.
  void nextGeneration() {
    questionnaireResponseModel.nextGeneration();
    // This notifies aggregators on changes to individual items
    notifyListeners();
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
    // FIXME: This is expensive and hacky. The codinganswermodel should have a property for its own current ordinalvalue.
    final answerModel = firstAnswerModel;

    if (answerModel.isAnswered && answerModel is CodingAnswerModel) {
      final answers = answerModel.createFhirCodingAnswers(null);
      // Find ordinal value in extensions
      final ordinalExtension =
          answers?.firstOrNull?.valueCoding?.extension_?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value',
              ) ??
              answers?.firstOrNull?.valueCoding?.extension_?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/ordinalValue',
              );
      if (ordinalExtension == null) {
        return null;
      }

      return ordinalExtension.valueDecimal;
    } else {
      return null;
    }
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
  Future<Iterable<QuestionnaireErrorFlag>?> get isComplete async {
    // Non-existent answer models can be incomplete, e.g. if minOccurs is not met.
    _ensureAnswerModel();

    final markers = <QuestionnaireErrorFlag>[];
    final rimMarkers = await super.isComplete;
    if (rimMarkers != null) {
      markers.addAll(rimMarkers);
    }

    for (final am in answerModels) {
      final marker = am.isComplete;
      if (marker != null) {
        markers.add(marker);
      }
    }

    return (markers.isNotEmpty) ? markers : null;
  }

  @override
  bool get isAnswered {
    _qimLogger.trace('isAnswered $nodeUid');
    if (!isAnswerable) {
      return false;
    }

    return answerModels.any((am) => am.isAnswered);
  }

  @override
  bool get isUnanswered {
    if (!isAnswerable) {
      return false;
    }

    final returnValue = answerModels.every((am) => am.isUnanswered);
    _qimLogger.debug('isUnanswered $nodeUid: $returnValue');

    return returnValue;
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
    return answerModels.where((am) => am.isAnswered);
  }

  /// Returns the [AnswerModel]s which have been answered,
  /// plus potentially one extra empty one.
  Iterable<AnswerModel> get fillableAnswerModels {
    _ensureAnswerModel();

    final latestAnswerModel = this.latestAnswerModel;

    return answerModels.where((am) => am.isAnswered || am == latestAnswerModel);
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
  ///
  /// Currently only supports 'initialExpression'.
  Future<void> populateInitialValue() async {
    _qimLogger.debug('populateInitialValue: $nodeUid');
    if (questionnaireItemModel.hasInitialExpression) {
      final initialEvaluationResult = await evaluateInitialExpression();
      firstAnswerModel.populateFromExpression(initialEvaluationResult);
    } else {
      // initial.value[x]
      // TODO: Implement
    }
  }

  /// Returns the value of the initialExpression.
  ///
  /// Returns null if the item does not have an initialExpression,
  /// or it evaluates to an empty list.
  Future<dynamic> evaluateInitialExpression() async {
    final fhirPathExpression =
        questionnaireItemModel.questionnaireItem.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression',
            )
            ?.valueExpression;

    if (fhirPathExpression == null) {
      return Future.value(null);
    }

    final initialExpressionEvaluator = FhirExpressionEvaluator.fromExpression(
      null,
      fhirPathExpression,
      questionnaireResponseModel.questionnaireLevelExpressionEvaluators,
    );

    final evaluationResult = await initialExpressionEvaluator.fetchValue();

    if (evaluationResult is! List || evaluationResult.isEmpty) {
      return Future.value(null);
    }

    return Future.value(evaluationResult.first);
  }

  Future<void> updateCalculatedExpression() async {
    final calculatedExpression = _calculatedExpression;
    if (calculatedExpression == null) {
      return;
    }

    final rawEvaluationResult = await calculatedExpression.fetchValue();

    _qimLogger.debug('calculatedExpression: $rawEvaluationResult');

    final evaluationResult =
        (rawEvaluationResult is List && rawEvaluationResult.isNotEmpty)
            ? rawEvaluationResult.first
            : null;

    // TODO: should this be able to populate multiple answers?
    // Write the value back to the answer model
    firstAnswerModel.populateFromExpression(evaluationResult);
  }
}
