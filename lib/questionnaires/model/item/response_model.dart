import 'package:fhir/r4.dart';

import '../../../coding/data_absent_reasons.dart';
import '../../questionnaires.dart';

/// Model a response item, which might consist of multiple answers.
class ResponseModel {
  /// The individual answers to this questionnaire item.
  List<QuestionnaireResponseAnswer?> answers = [];

  /// Reason why this response is empty.
  ///
  /// see [DataAbsentReason]
  Code? dataAbsentReason;
  final QuestionnaireItemModel itemModel;

  QuestionnaireResponseItem? get responseItem => itemModel.responseItem;
  set responseItem(QuestionnaireResponseItem? ri) =>
      itemModel.responseItem = ri;

  ResponseModel(this.itemModel) {
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
      dataAbsentReason == dataAbsentReasonAskedButDeclinedCode;

  /// Update the response with all the answers which are not null.
  ///
  /// Sets the response in the related [QuestionnaireItemModel].
  void updateResponse() {
    final filledAnswers = answers
        .where((answer) => answer != null)
        .map<QuestionnaireResponseAnswer>((answer) => answer!)
        .toList(growable: false);

    itemModel.responseItem = (filledAnswers.isEmpty && dataAbsentReason == null)
        ? null
        : QuestionnaireResponseItem(
            linkId: itemModel.linkId,
            text: itemModel.questionnaireItem.text,
            extension_: (dataAbsentReason != null)
                ? [
                    FhirExtension(
                        url: dataAbsentReasonExtension,
                        valueCode: dataAbsentReason)
                  ]
                : null,
            // FHIR cannot have empty arrays.
            answer: filledAnswers.isEmpty ? null : filledAnswers);
  }

  /// Returns an [AnswerModel] for the nth answer to an overall response.
  ///
  /// Only [answerIndex] == 0 is currently supported.
  AnswerModel answerModel(int answerIndex) {
    switch (itemModel.questionnaireItem.type!) {
      case QuestionnaireItemType.choice:
      case QuestionnaireItemType.open_choice:
        return CodingAnswerModel(this, answerIndex);
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        return NumericalAnswerModel(this, answerIndex);
      case QuestionnaireItemType.string:
      case QuestionnaireItemType.text:
      case QuestionnaireItemType.url:
        return StringAnswerModel(this, answerIndex);
      case QuestionnaireItemType.date:
      case QuestionnaireItemType.datetime:
      case QuestionnaireItemType.time:
        return DateTimeAnswerModel(this, answerIndex);
      case QuestionnaireItemType.boolean:
        return BooleanAnswerModel(this, answerIndex);
      case QuestionnaireItemType.display:
      case QuestionnaireItemType.group:
        return StaticAnswerModel(this, answerIndex);
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
        throw QuestionnaireFormatException(
            'Unsupported item type: ${itemModel.questionnaireItem.type!}');
    }
  }
}
