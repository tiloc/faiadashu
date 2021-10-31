import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';

import '../../../questionnaires.dart';

class GroupResponseItemModel extends ResponseItemModel {
  GroupResponseItemModel(QuestionnaireResponseModel questionnaireResponseModel,
      QuestionnaireItemModel itemModel)
      : super(questionnaireResponseModel, itemModel);

  @override
  QuestionnaireResponseItem? get responseItem => null;

  @override
  bool get isInvalid => false;
}
