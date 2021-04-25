import 'package:fhir/r4.dart';

import '../../questionnaire_item_model.dart';
import '../item.dart';

class BooleanAnswerModel extends AnswerModel<Boolean, Boolean> {
  BooleanAnswerModel(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation)
      : super(itemModel, answerLocation) {
    value = answerLocation.answer?.valueBoolean;
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
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
}
