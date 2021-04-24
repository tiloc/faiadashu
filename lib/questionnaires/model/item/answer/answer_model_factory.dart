import '../../../view/item/item.dart';
import '../../questionnaire_location.dart';
import '../item.dart';

class AnswerModelFactory {
  // TODO: AnswerLocation is in view. Move to model or eliminate.
  static AnswerModel createModel<T>(
      QuestionnaireLocation location, AnswerLocation answerLocation) {
    switch (T) {
      case NumericalAnswerModel:
        return NumericalAnswerModel(location, answerLocation);
      case CodingAnswerModel:
        return CodingAnswerModel(location, answerLocation);
      case StringAnswerModel:
        return StringAnswerModel(location, answerLocation);
      case DateTimeAnswerModel:
        return DateTimeAnswerModel(location, answerLocation);
      case BooleanAnswerModel:
        return BooleanAnswerModel(location, answerLocation);
      default:
        throw StateError('Cannot create a model for $location');
    }
  }
}
