import 'package:faiadashu/questionnaires/model/model.dart';

class GroupItemModel extends ResponseItemModel {
  GroupItemModel(
    ResponseNode? parentNode,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel itemModel,
  ) : super(
          parentNode,
          questionnaireResponseModel,
          itemModel,
        );

  @override
  bool get isInvalid {
    return questionnaireResponseModel
        .orderedResponseItemModelsWithParent(parent: this)
        .any((rim) => rim.isInvalid);
  }

  @override
  bool get isAnswered {
    return questionnaireResponseModel
        .orderedResponseItemModelsWithParent(parent: this)
        .any((rim) => rim.isAnswered);
  }

  @override
  bool get isUnanswered {
    return questionnaireResponseModel
        .orderedResponseItemModelsWithParent(parent: this)
        .every((rim) => rim.isUnanswered);
  }

  @override
  bool get isPopulated {
    return questionnaireResponseModel
        .orderedResponseItemModelsWithParent(parent: this)
        .any((rim) => rim.isPopulated);
  }
}
