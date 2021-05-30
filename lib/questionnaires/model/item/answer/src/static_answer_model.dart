import 'package:fhir/r4.dart';

import '../../item.dart';

/// A pseudo-model for a static questionnaire item.
///
/// Used to represent items of types group, and display.
class StaticAnswerModel extends AnswerModel<Object, Object> {
  StaticAnswerModel(ResponseModel responseModel, int answerIndex)
      : super(responseModel, answerIndex);

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    throw UnimplementedError('StaticAnswerModel cannot fill an answer.');
  }

  @override
  String get display => AnswerModel.nullText;

  @override
  String? validate(Object? inValue) {
    return null;
  }
}
