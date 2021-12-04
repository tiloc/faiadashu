import 'package:fhir/r4.dart';

import '../../../model.dart';

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
  QuestionnaireErrorFlag? get isComplete => null;

  @override
  bool get isUnanswered => value == null;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    value = answer.valueBoolean;
  }
}
