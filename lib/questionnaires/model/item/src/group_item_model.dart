import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';

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
  QuestionnaireResponseItem? get responseItem => null;

  @override
  bool get isInvalid => false;
}
