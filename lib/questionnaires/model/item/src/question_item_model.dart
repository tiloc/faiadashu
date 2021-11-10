import 'package:fhir/r4.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

/// Model a response item to a question.
///
/// A single response might reference multiple answers.
class QuestionItemModel extends ResponseItemModel {
  static final _qrimLogger = Logger(QuestionItemModel);

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

  QuestionItemModel(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel itemModel,
  ) : super(
          parentItem,
          parentAnswerIndex,
          questionnaireResponseModel,
          itemModel,
        ) {
    // FIXME: Should this be populated here? Or better a separate populate method?
/*    dataAbsentReason = responseItem?.extension_?.dataAbsentReason; */
  }

  /// Is the response 'asked but declined'
  bool get isAskedButDeclined =>
      dataAbsentReason == dataAbsentReasonAskedButDeclinedCode;

  /// Changes the generation and notifies all listeners.
  ///
  /// Each generation is unique during a run of the application.
  void nextGeneration() {
    questionnaireResponseModel.nextGeneration();
    // This notifies aggregators on changes to individual items
    notifyListeners();

    // FIXME: Move output of data-absent-reason over to response aggregator
/*
    final filledAnswers = answers
        .where((answer) => answer != null)
        .map<QuestionnaireResponseAnswer>((answer) => answer!)
        .toList(growable: false);

    responseItem = (filledAnswers.isEmpty && dataAbsentReason == null)
        ? null
        : QuestionnaireResponseItem(
            linkId: questionnaireItemModel.linkId,
            text: questionnaireItemModel.questionnaireItem.text,
            extension_: (dataAbsentReason != null)
                ? [
                    FhirExtension(
                      url: dataAbsentReasonExtensionUrl,
                      valueCode: dataAbsentReason,
                    )
                  ]
                : null,
            // FHIR cannot have empty arrays.
            answer: filledAnswers.isEmpty ? null : filledAnswers,
          ); */
  }

  /// Is this response invalid?
  ///
  /// This is currently entirely based on the [dataAbsentReason].
  @override
  bool get isInvalid {
    _qrimLogger.trace('isInvalid $responseUid');
    return dataAbsentReason == dataAbsentReasonAsTextCode;
  }

  /// Returns a [Decimal] value which can be added to a score.
  ///
  /// Returns null if not applicable (either question unanswered, or wrong type)
  Decimal? get ordinalValue {
    // TODO: This is expensive and hacky. The codinganswermodel should have a property for its own current ordinalvalue.
    final answerModel = firstAnswerModel;

    if (answerModel.isAnswered && answerModel is CodingAnswerModel) {
      final answers = answerModel.filledCodingAnswers;
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

  // Ensures at least a single answer model exists.
  void _ensureAnswerModel() {
    _answerModel(0);
  }

  @override
  Iterable<QuestionnaireErrorFlag>? get isComplete {
    // Non-existent answer models can be incomplete, e.g. if minOccurs is not met.
    _ensureAnswerModel();

    final markers = <QuestionnaireErrorFlag>[];
    final rimMarkers = super.isComplete;
    if (rimMarkers != null) {
      markers.addAll(rimMarkers);
    }

    for (final am in _cachedAnswerModels.values) {
      final marker = am.isComplete;
      if (marker != null) {
        markers.add(marker);
      }
    }

    return (markers.isNotEmpty) ? markers : null;
  }

  @override
  bool get isAnswered {
    _qrimLogger.trace('isAnswered $responseUid');
    if (!isAnswerable) {
      return false;
    }

    return _cachedAnswerModels.values.any((am) => am.isAnswered);
  }

  @override
  bool get isUnanswered {
    _qrimLogger.trace('isUnanswered $responseUid');
    if (!isAnswerable) {
      return false;
    }

    return _cachedAnswerModels.values.every((am) => am.isUnanswered);
  }

  final Map<int, AnswerModel> _cachedAnswerModels = <int, AnswerModel>{};

  /// Add the next answer to this response.
  ///
  /// Returns the newly added [AnswerModel].
  AnswerModel addAnswerModel() {
    return _answerModel(_cachedAnswerModels.length);
  }

  /// Returns the [AnswerModel] which has been added last.
  AnswerModel get latestAnswerModel {
    _ensureAnswerModel();

    return _cachedAnswerModels.values.last;
  }

  /// Returns the [AnswerModel] which has been added first.
  AnswerModel get firstAnswerModel {
    _ensureAnswerModel();

    return _cachedAnswerModels.values.first;
  }

  /// Returns the [AnswerModel]s which have been answered.
  Iterable<AnswerModel> get answeredAnswerModels {
    return _cachedAnswerModels.values.where((am) => am.isAnswered);
  }

  /// Returns the [AnswerModel]s which have been answered,
  /// plus potentially one extra empty one.
  Iterable<AnswerModel> get fillableAnswerModels {
    _ensureAnswerModel();

    final latestAnswerModel = this.latestAnswerModel;
    return _cachedAnswerModels.values
        .where((am) => am.isAnswered || am == latestAnswerModel);
  }

  /// Returns an [AnswerModel] for the nth answer to an overall response.
  AnswerModel _answerModel(int answerIndex) {
    if (_cachedAnswerModels.containsKey(answerIndex)) {
      return _cachedAnswerModels[answerIndex]!;
    }

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

    _cachedAnswerModels[answerIndex] = answerModel;

    return answerModel;
  }

  void populateInitialValue() {
    _qrimLogger.debug('populateInitialValue: $responseUid');
    if (questionnaireItemModel.hasInitialExpression) {
      final initialEvaluationResult = evaluateInitialExpression();
      _answerModel(0).populateFromExpression(initialEvaluationResult);
    } else {
      // initial.value[x]
      // TODO: Implement
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
            ?.valueExpression
            ?.expression;

    if (fhirPathExpression == null) {
      return null;
    }

    final evaluationResult = evaluateFhirPathExpression(
      fhirPathExpression,
      requiresQuestionnaireResponse: false,
    );

    if (evaluationResult.isEmpty) {
      return null;
    }

    return evaluationResult.first;
  }

  void updateCalculatedExpression() {
    final fhirPathExpression = questionnaireItemModel.calculatedExpression;
    if (fhirPathExpression == null) {
      return;
    }

    final rawEvaluationResult = evaluateFhirPathExpression(
      fhirPathExpression,
    );

    final evaluationResult =
        (rawEvaluationResult.isNotEmpty) ? rawEvaluationResult.first : null;

    // TODO: should this be able to populate multiple answers?
    // Write the value back to the answer model
    _answerModel(0).populateFromExpression(evaluationResult);
  }
}
