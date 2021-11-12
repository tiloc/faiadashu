import '../../../questionnaires.dart';

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
  bool get isInvalid => false;

  @override
  bool get isAnswered => false;

  @override
  bool get isUnanswered => false;
}
