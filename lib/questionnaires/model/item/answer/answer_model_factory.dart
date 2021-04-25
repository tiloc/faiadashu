import '../../questionnaire_item_model.dart';
import '../item.dart';

class AnswerModelFactory {
  static AnswerModel createModel<T>(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation) {
    switch (T) {
      case NumericalAnswerModel:
        return NumericalAnswerModel(itemModel, answerLocation);
      case CodingAnswerModel:
        return CodingAnswerModel(itemModel, answerLocation);
      case StringAnswerModel:
        return StringAnswerModel(itemModel, answerLocation);
      case DateTimeAnswerModel:
        return DateTimeAnswerModel(itemModel, answerLocation);
      case BooleanAnswerModel:
        return BooleanAnswerModel(itemModel, answerLocation);
      default:
        throw StateError('Cannot create a model for $itemModel');
    }
  }
}
