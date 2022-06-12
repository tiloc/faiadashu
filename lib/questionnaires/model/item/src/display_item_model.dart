import 'package:faiadashu/questionnaires/model/model.dart';

class DisplayItemModel extends FillerItemModel {
  DisplayItemModel(
    super.parentNode,
    super.questionnaireResponseModel,
    super.questionnaireItemModel,
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
