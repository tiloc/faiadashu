import 'package:fhir/primitive_types/boolean.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';

import '../../view/item/questionnaire_response_filler.dart';
import '../questionnaire_location.dart';
import 'item.dart';

class BooleanItemModel extends ItemModel<Boolean, Boolean> {
  BooleanItemModel(
      QuestionnaireLocation location, AnswerLocation answerLocation)
      : super(location, answerLocation) {
    value = answerLocation.answer?.valueBoolean;
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
      (value != null) ? QuestionnaireResponseAnswer(valueBoolean: value) : null;

  @override
  String? validate(Boolean? inValue) {
    return null;
  }
}
