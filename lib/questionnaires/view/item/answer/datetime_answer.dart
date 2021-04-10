import 'package:faiadashu/fhir_types/date_time_picker.dart';
import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../questionnaires.dart';
import '../questionnaire_answer_filler.dart';

class DateTimeAnswer extends QuestionnaireAnswerFiller {
  const DateTimeAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _DateTimeAnswerState();
}

class _DateTimeAnswerState
    extends QuestionnaireAnswerState<FhirDateTime, DateTimeAnswer> {
  _DateTimeAnswerState();

  @override
  void initState() {
    super.initState();
    initialValue = widget.answerLocation.answer?.valueDateTime ??
        ((widget.answerLocation.answer?.valueDate != null)
            ? FhirDateTime(widget.answerLocation.answer?.valueDate
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
  Widget buildReadOnly(BuildContext context) {
    return FhirDateTimeText(
      value,
      locale: locale,
      defaultText: '-',
    );
  }

  @override
  Widget buildEditable(BuildContext context) {
    final itemType = qi.type;

    final initialDate = (itemType != QuestionnaireItemType.time) ? value : null;

    final pickerType = ArgumentError.checkNotNull(const {
      QuestionnaireItemType.date: Date,
      QuestionnaireItemType.datetime: FhirDateTime,
      QuestionnaireItemType.time: Time,
    }[itemType]);

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: FhirDateTimePicker(
        locale: locale,
        initialDateTime: initialDate,
        firstDate: DateTime(1860),
        lastDate: DateTime(2050),
        pickerType: pickerType,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (fhirDatetime) => value = fhirDatetime,
      ),
    );
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
}
