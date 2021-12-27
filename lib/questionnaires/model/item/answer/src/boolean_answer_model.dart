import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

class BooleanAnswerModel extends AnswerModel<Boolean, Boolean> {
  BooleanAnswerModel(QuestionItemModel responseModel) : super(responseModel);

  @override
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  ) =>
      (value != null)
          ? QuestionnaireResponseAnswer(valueBoolean: value, item: items)
          : null;

  @override
  RenderingString get display => (value == null)
      ? RenderingString.nullText
      : RenderingString.fromText(
          (value == Boolean(true)) ? '[X]' : '[ ]',
          xhtmlText: (value == Boolean(true))
              ? '<b>[X]</b>'
              : '<span style="color:grey">[ ]</span>',
        );

  @override
  String? validateInput(Boolean? inValue) {
    return null;
  }

  @override
  String? validateValue(Boolean? inputValue) {
    return null;
  }

  @override
  bool get isEmpty => value == null;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    value = answer.valueBoolean;
  }
}
