import '../../view/item/item.dart';
import '../questionnaire_location.dart';
import 'item.dart';

class ItemModelFactory {
  // TODO: AnswerLocation is in view. Move to model or eliminate.
  static ItemModel createModel<T>(
      QuestionnaireLocation location, AnswerLocation answerLocation) {
    switch (T) {
      case NumericalItemModel:
        return NumericalItemModel(location, answerLocation);
      case CodingItemModel:
        return CodingItemModel(location, answerLocation);
      case StringItemModel:
        return StringItemModel(location, answerLocation);
      case DateTimeItemModel:
        return DateTimeItemModel(location, answerLocation);
      case BooleanItemModel:
        return BooleanItemModel(location, answerLocation);
      default:
        throw StateError('Cannot create a model for $location');
    }
  }
}
