import 'package:fhir/r4.dart';

import '../../../coding/data_absent_reasons.dart';
import '../questionnaire_location.dart';

/// Model a response item, which might consist of multiple answers.
class ResponseModel {
  /// The individual answers to this questionnaire item.
  List<QuestionnaireResponseAnswer?> answers = [];

  /// Reason why this response is empty.
  ///
  /// see [DataAbsentReason]
  Code? dataAbsentReason;
  final QuestionnaireLocation location;

  QuestionnaireResponseItem? get responseItem => location.responseItem;
  set responseItem(QuestionnaireResponseItem? ri) => location.responseItem = ri;

  ResponseModel(this.location) {
    final int? answerCount = responseItem?.answer?.length;
    if (answerCount != null && answerCount > 0) {
      answers = responseItem!.answer!;
    } else {
      answers = [null];
    }

    dataAbsentReason = responseItem?.extension_?.dataAbsentReason;
  }

  /// Is the response 'asked but declined'
  bool get isAskedButDeclined =>
      dataAbsentReason == DataAbsentReason.askedButDeclinedCode;

  /// Fill the response with all the answers which are not null.
  void fillResponse() {
    final filledAnswers = answers
        .where((answer) => answer != null)
        .map<QuestionnaireResponseAnswer>((answer) => answer!)
        .toList(growable: false);

    if (filledAnswers.isEmpty && dataAbsentReason == null) {
      location.responseItem = null;
    }
    final result = QuestionnaireResponseItem(
        linkId: location.linkId,
        text: location.questionnaireItem.text,
        extension_: (dataAbsentReason != null)
            ? [
                FhirExtension(
                    url: DataAbsentReason.extensionUrl,
                    valueCode: dataAbsentReason)
              ]
            : null,
        // FHIR cannot have empty arrays.
        answer: filledAnswers.isEmpty ? null : filledAnswers);

    location.responseItem = result;
  }
}

typedef OnAnswered = void Function(
    List<QuestionnaireResponseAnswer?>? answers, int answerIndex);

/// Connects responses and individual answers.
class AnswerLocation {
  final List<QuestionnaireResponseAnswer?> _answers;
  final int _answerIndex;
  final OnAnswered _onAnswered;

  const AnswerLocation(List<QuestionnaireResponseAnswer?> answers,
      int answerIndex, OnAnswered onAnswered)
      : _answers = answers,
        _answerIndex = answerIndex,
        _onAnswered = onAnswered;

  void stashAnswer(QuestionnaireResponseAnswer? answer) {
    _onAnswered.call([answer], _answerIndex);
  }

  /// Special functionality to allow choice and open-choice items with "repeats".
  void stashCodingAnswers(List<QuestionnaireResponseAnswer?>? answers) {
    _onAnswered.call(answers, _answerIndex);
  }

  QuestionnaireResponseAnswer? get answer => _answers[_answerIndex];
}
