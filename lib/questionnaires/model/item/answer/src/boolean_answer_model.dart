import 'package:fhir/r4.dart';

import '../../../model.dart';

class BooleanAnswerModel extends AnswerModel<Boolean, Boolean> {
  BooleanAnswerModel(ResponseModel responseModel, int answerIndex)
      : super(responseModel, answerIndex) {
    value = answer?.valueBoolean;
  }

  @override
  QuestionnaireResponseAnswer? get filledAnswer =>
      (value != null) ? QuestionnaireResponseAnswer(valueBoolean: value) : null;

  @override
  String get display => (value == null)
      ? AnswerModel.nullText
      : (value == Boolean(true))
          ? '[X]'
          : '[ ]';

  @override
  String? validate(Boolean? inValue) {
    return null;
  }

  @override
  QuestionnaireMarker? get isComplete => null;
}
