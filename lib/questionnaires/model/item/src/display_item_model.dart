import '../../../questionnaires.dart';

class DisplayItemModel extends FillerItemModel {
  DisplayItemModel(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel questionnaireItemModel,
  ) : super(
          parentItem,
          parentAnswerIndex,
          questionnaireResponseModel,
          questionnaireItemModel,
        );
}
