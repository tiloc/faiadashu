import 'package:fhir/r4.dart';

import '../../../../coding/coding.dart';
import '../../../questionnaires.dart';

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
                        url: dataAbsentReasonExtensionUrl,
                        valueCode: dataAbsentReason)
                  ]
                : null,
            // FHIR cannot have empty arrays.
            answer: filledAnswers.isEmpty ? null : filledAnswers);
  }

  /// Is this response invalid?
  ///
  /// This is currently entirely based on the [dataAbsentReason].
  bool get isInvalid {
    return dataAbsentReason == dataAbsentReasonAsTextCode;
  }

  Iterable<QuestionnaireErrorFlag>? get isComplete {
    if (_cachedAnswerModels.isEmpty) {
      return null;
    }

    final markers = <QuestionnaireErrorFlag>[];
    for (final am in _cachedAnswerModels.values) {
      final marker = am.isComplete;
      if (marker != null) {
        markers.add(marker);
      }
    }

    return (markers.isNotEmpty) ? markers : null;
  }

  bool get isUnanswered {
    if (_cachedAnswerModels.isEmpty) {
      return true;
    }

    return _cachedAnswerModels.values.any((am) => !am.isUnanswered);
  }

  final _cachedAnswerModels = <int, AnswerModel>{};

  /// Returns an [AnswerModel] for the nth answer to an overall response.
  ///
  /// Only [answerIndex] == 0 is currently supported.
  AnswerModel answerModel(int answerIndex) {
    if (_cachedAnswerModels.containsKey(answerIndex)) {
      return _cachedAnswerModels[answerIndex]!;
    }

    final AnswerModel? answerModel;

    switch (itemModel.questionnaireItem.type!) {
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
      case QuestionnaireItemType.group:
        answerModel = StaticAnswerModel(this, answerIndex);
        break;
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
        throw QuestionnaireFormatException(
            'Unsupported item type: ${itemModel.questionnaireItem.type!}');
    }

    _cachedAnswerModels[answerIndex] = answerModel;

    return answerModel;
  }
}
