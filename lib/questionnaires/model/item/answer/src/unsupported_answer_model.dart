import 'package:fhir/r4.dart';

import '../../../model.dart';

/// A pseudo-model for a questionnaire item of an unsupported type.
class UnsupportedAnswerModel extends AnswerModel<Object, Object> {
  UnsupportedAnswerModel(QuestionResponseItemModel responseModel, int answerIndex)
      : super(responseModel, answerIndex);

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    throw UnimplementedError('UnsupportedAnswerModel cannot fill an answer.');
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
