import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

/// A pseudo-model for a questionnaire item of an unsupported type.
class UnsupportedAnswerModel extends AnswerModel<Object, Object> {
  UnsupportedAnswerModel(QuestionItemModel responseModel)
      : super(responseModel);

  @override
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  ) {
    return null;
  }

  @override
  RenderingString get display => RenderingString.nullText;

  @override
  String? validateInput(Object? inValue) {
    return null;
  }

  @override
  String? get isComplete => null;

  @override
  bool get isUnanswered => false;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    throw UnsupportedError('Cannot populate item of unknown type.');
  }
}
