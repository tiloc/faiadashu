import 'package:fhir/r4.dart';

import '../../../model.dart';

/// A pseudo-model for a display questionnaire item.
class DisplayAnswerModel extends AnswerModel<Object, Object> {
  DisplayAnswerModel(ResponseModel responseModel, int answerIndex)
      : super(responseModel, answerIndex);

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    throw UnimplementedError('DisplayAnswerModel cannot fill an answer.');
  }

  @override
  String get display => AnswerModel.nullText;

  @override
  String? validateInput(Object? inValue) {
    return null;
  }

  @override
  QuestionnaireErrorFlag? get isComplete => null;

  @override
  bool get isUnanswered => false;
}
