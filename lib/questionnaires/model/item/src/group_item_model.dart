import '../../../questionnaires.dart';

class GroupItemModel extends ResponseItemModel {
  GroupItemModel(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel itemModel,
  ) : super(
          parentItem,
          parentAnswerIndex,
          questionnaireResponseModel,
          itemModel,
        );

  @override
  bool get isInvalid => false;

  @override
  bool get isAnswered => false;

  @override
  bool get isUnanswered => false;
}
