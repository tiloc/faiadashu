import '../../../questionnaires.dart';

class DisplayItemModel extends FillerItemModel {
  DisplayItemModel(
    ResponseNode? parentNode,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel questionnaireItemModel,
  ) : super(
          parentNode,
          questionnaireResponseModel,
          questionnaireItemModel,
        );
}
