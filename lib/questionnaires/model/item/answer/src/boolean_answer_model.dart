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

  bool get isTriState => questionnaireResponseModel
      .questionnaireModel.questionnaireModelDefaults.booleanTriState;

  @override
  void populateFromExpression(dynamic evaluationResult) {
    if (evaluationResult == null) {
      value = null;

      return;
    }

    if (evaluationResult is Boolean) {
      value = evaluationResult;
    } else if (evaluationResult is bool) {
      value = Boolean(evaluationResult);
    } else {
      // Non-empty, non-booleans are true
      value = Boolean(true);
    }
  }

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    value = answer.valueBoolean;
  }
}
