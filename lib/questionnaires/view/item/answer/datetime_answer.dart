import 'package:date_time_picker/date_time_picker.dart';
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
        ((widget.location.questionnaireItem.extension_
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
    return FhirDateTimeWidget(
      value,
      defaultText: '-',
    );
  }

  @override
  Widget buildEditable(BuildContext context) {
    final itemType = widget.location.questionnaireItem.type;

    final initialDate =
        (itemType != QuestionnaireItemType.time) ? value?.value : null;

    final initialTime =
        (itemType != QuestionnaireItemType.date && value?.value != null)
            ? (value!.precision == DateTimePrecision.FULL)
                ? TimeOfDay.fromDateTime(value!.value!)
                : null
            : null;

    final locale = Localizations.localeOf(context);
    final _initialValue = value?.format(locale);

    final pickerType = ArgumentError.checkNotNull(const {
      QuestionnaireItemType.date: DateTimePickerType.date,
      QuestionnaireItemType.datetime: DateTimePickerType.dateTime,
      QuestionnaireItemType.time: DateTimePickerType.time,
    }[itemType]);

    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: DateTimePicker(
          initialDate: initialDate,
          initialTime: initialTime,
          initialValue: _initialValue,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          type: pickerType,
          locale: locale,
          firstDate: DateTime(1860),
          lastDate: DateTime(2050),
          onChanged: (content) {
            value = FhirDateTime(content);
          },
        ));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
      QuestionnaireResponseAnswer(valueDateTime: value);
}
