import 'package:fhir/r4.dart'
    show
        Date,
        DateTimePrecision,
        FhirDateTime,
        QuestionnaireItemType,
        QuestionnaireResponseAnswer,
        Time;

import '../../../fhir_types/fhir_types_extensions.dart';
import '../../view/item/questionnaire_response_filler.dart';
import '../questionnaire_location.dart';
import 'item_model.dart';

class DateTimeItemModel extends ItemModel<FhirDateTime, FhirDateTime> {
  DateTimeItemModel(
      QuestionnaireLocation location, AnswerLocation answerLocation)
      : super(location, answerLocation) {
    value = answerLocation.answer?.valueDateTime ??
        ((answerLocation.answer?.valueDate != null)
            ? FhirDateTime(answerLocation.answer?.valueDate
                .toString()) // TODO: File a PR to allow construction of FhirDateTime directly from Date.
            : null) ??
        ((qi.extension_
                    ?.extensionOrNull(
                        'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression')
                    ?.valueExpression
                    ?.expression ==
                'today()')
            ? FhirDateTime.fromDateTime(
                DateTime.now(), DateTimePrecision.YYYYMMDD)
            : null);
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    final itemType = qi.type;

    if (value?.value == null) {
      return null;
    }

    if (itemType == QuestionnaireItemType.date) {
      return QuestionnaireResponseAnswer(valueDate: Date(value!.value));
    } else if (itemType == QuestionnaireItemType.datetime) {
      return QuestionnaireResponseAnswer(valueDateTime: value);
    } else if (itemType == QuestionnaireItemType.time) {
      return QuestionnaireResponseAnswer(
          valueTime: Time(
              value!.value!.toIso8601String().substring('yyyy-MM-ddT'.length)));
    } else {
      throw StateError('Unexpected itemType: $itemType');
    }
  }

  @override
  String? validate(FhirDateTime? inValue) {
    // TODO: The view is currently making it impossible to select invalid date/time.
    // But that is making assumptions about the view.
    return null;
  }
}
