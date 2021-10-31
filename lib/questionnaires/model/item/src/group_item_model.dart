import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';

import '../../../questionnaires.dart';

class GroupItemModel extends ResponseItemModel {
  GroupItemModel(
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel itemModel,
  ) : super(questionnaireResponseModel, itemModel);

  @override
  QuestionnaireResponseItem? get responseItem => null;

  @override
  bool get isInvalid => false;
}
