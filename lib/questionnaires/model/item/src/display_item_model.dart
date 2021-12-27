import 'package:faiadashu/questionnaires/model/model.dart';

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

  @override
  bool get isAnswered => false;

  @override
  bool get isUnanswered => false;

  @override
  bool get isInvalid => false;

  @override
  bool get isPopulated => false;
}
