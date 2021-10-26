import 'package:fhir/r4.dart';

import '../../../model.dart';

/// A pseudo-model for a group questionnaire item.
class GroupAnswerModel extends AnswerModel<Object, Object> {
  GroupAnswerModel(ResponseModel responseModel, int answerIndex)
      : super(responseModel, answerIndex);

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    throw UnimplementedError('GroupAnswerModel cannot fill an answer.');
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
