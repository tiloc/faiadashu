import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

class BooleanAnswerModel extends AnswerModel<FhirBoolean, FhirBoolean> {
  BooleanAnswerModel(super.responseModel);

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
          (value == FhirBoolean(true)) ? '[X]' : '[ ]',
          xhtmlText: (value == FhirBoolean(true))
              ? '<b>[X]</b>'
              : '<span style="color:grey">[ ]</span>',
        );

  @override
  String? validateInput(FhirBoolean? inValue) {
    return null;
  }

  @override
  String? validateValue(FhirBoolean? inputValue) {
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

    if (evaluationResult is FhirBoolean) {
      value = evaluationResult;
    } else if (evaluationResult is bool) {
      value = FhirBoolean(evaluationResult);
    } else {
      // Non-empty, non-booleans are true
      value = FhirBoolean(true);
    }
  }

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    value = answer.valueBoolean;
  }
}
