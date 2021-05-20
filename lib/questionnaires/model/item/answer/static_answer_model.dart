import 'package:fhir/r4.dart';

import '../../questionnaire_item_model.dart';
import '../item.dart';

/// A pseudo-model for a static questionnaire item.
///
/// Used to represent items of types group, and display.
class StaticAnswerModel extends AnswerModel<Object, Object> {
  StaticAnswerModel(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation)
      : super(itemModel, answerLocation);

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
