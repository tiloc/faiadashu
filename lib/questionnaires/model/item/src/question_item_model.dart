import 'dart:math';

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

  /// The individual FHIR domain answers to this questionnaire item.
  List<QuestionnaireResponseAnswer?> answers = [];

  /// The FHIR domain QuestionnaireResponseItem
  QuestionnaireResponseItem? _questionnaireResponseItem;

  /// Returns the associated [QuestionnaireResponseItem].
  @override
  QuestionnaireResponseItem? get responseItem => _questionnaireResponseItem;

  /// Sets the associated [QuestionnaireResponseItem].
  set responseItem(QuestionnaireResponseItem? questionnaireResponseItem) {
    _qrimLogger.debug('set responseItem $questionnaireResponseItem');
    if (questionnaireResponseItem != _questionnaireResponseItem) {
      _questionnaireResponseItem = questionnaireResponseItem;
      questionnaireResponseModel.nextGeneration();
      // This notifies aggregators on changes to individual items
      notifyListeners();
    }
  }

  /// Reason why this response is empty.
  ///
  /// see [DataAbsentReason]
  Code? dataAbsentReason;

  QuestionItemModel(
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel itemModel,
  ) : super(questionnaireResponseModel, itemModel) {
    final int answerCount = responseItem?.answer?.length ?? 0;
    if (answerCount > 0) {
      answers = responseItem!.answer!;
    } else {
      answers = [null];
    }

    dataAbsentReason = responseItem?.extension_?.dataAbsentReason;
  }

  /// Is the response 'asked but declined'
  bool get isAskedButDeclined =>
      dataAbsentReason == dataAbsentReasonAskedButDeclinedCode;

  /// Update the response with all the answers which are not null.
  ///
  /// Sets the response in the related [QuestionnaireItemModel].
  void updateResponse() {
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
          );
  }

  /// Is this response invalid?
  ///
  /// This is currently entirely based on the [dataAbsentReason].
  @override
  bool get isInvalid {
    _qrimLogger.trace('isInvalid $responseUid');
    return dataAbsentReason == dataAbsentReasonAsTextCode;
  }

  // Ensures at least a single answer model exists.
  void _ensureAnswerModel() {
    answerModel(0);
  }

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

  // FIXME: Clarify between this and response item model
  bool get isUnanswered {
    _ensureAnswerModel();

    return _cachedAnswerModels.values.any((am) => !am.isUnanswered);
  }

  final Map<int, AnswerModel> _cachedAnswerModels = <int, AnswerModel>{};

  /// Add the next answer to this response.
  ///
  /// Returns the newly added [AnswerModel].
  AnswerModel addAnswerModel() {
    return answerModel(numberOfAnswers);
  }

  /// Returns the number of answers in the response model.
  ///
  /// Includes unanswered answers, and thus the minimum value is 1.
  int get numberOfAnswers => max(answers.length, 1);

  /// Returns an [AnswerModel] for the nth answer to an overall response.
  AnswerModel answerModel(int answerIndex) {
    if (_cachedAnswerModels.containsKey(answerIndex)) {
      return _cachedAnswerModels[answerIndex]!;
    }

    // Prepare slots in the underlying FHIR domain model.
    if (answers.length <= answerIndex) {
      final List<QuestionnaireResponseAnswer?> additionalSlots =
          List.filled((answerIndex - answers.length) + 1, null);
      // + operator on List crashes due to incompatible types.
      answers = [...answers, ...additionalSlots];
    }

    final AnswerModel? answerModel;

    switch (questionnaireItemModel.questionnaireItem.type) {
      case QuestionnaireItemType.choice:
      case QuestionnaireItemType.open_choice:
        answerModel = CodingAnswerModel(this, answerIndex);
        break;
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        answerModel = NumericalAnswerModel(this, answerIndex);
        break;
      case QuestionnaireItemType.string:
      case QuestionnaireItemType.text:
      case QuestionnaireItemType.url:
        answerModel = StringAnswerModel(this, answerIndex);
        break;
      case QuestionnaireItemType.date:
      case QuestionnaireItemType.datetime:
      case QuestionnaireItemType.time:
        answerModel = DateTimeAnswerModel(this, answerIndex);
        break;
      case QuestionnaireItemType.boolean:
        answerModel = BooleanAnswerModel(this, answerIndex);
        break;
      case QuestionnaireItemType.display:
        throw UnsupportedError("Items of type 'display' do not have answers.");
      case QuestionnaireItemType.group:
        throw UnsupportedError("Items of type 'group' do not have answers.");
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
        // Throwing an exception here would lead to breakage of filler.
        answerModel = UnsupportedAnswerModel(this, answerIndex);
    }

    _cachedAnswerModels[answerIndex] = answerModel;

    return answerModel;
  }

  void populateInitialValue() {
    _qrimLogger.debug('populateInitialValue: $responseUid');
    if (questionnaireItemModel.hasInitialExpression) {
      final initialEvaluationResult = evaluateInitialExpression();
      answerModel(0).populateFromExpression(initialEvaluationResult);
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
    answerModel(0).populateFromExpression(evaluationResult);
    // ... and make sure the world will know about it
    updateResponse();
  }
}
