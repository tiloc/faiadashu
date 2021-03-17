import 'package:date_time_picker/date_time_picker.dart';
import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/fhir_types/date_time_widget.dart';

import '../../util/safe_access_extensions.dart';
import '../questionnaires.dart';
import 'questionnaire_answer_filler.dart';

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
    return DateTimePicker(
      type: ArgumentError.checkNotNull(const {
        QuestionnaireItemType.date: DateTimePickerType.date,
        QuestionnaireItemType.datetime: DateTimePickerType.dateTime,
        QuestionnaireItemType.time: DateTimePickerType.time,
      }[widget.location.questionnaireItem.type]),
      firstDate: DateTime(1860),
      lastDate: DateTime(2050),
      initialValue: value?.toString(),
      onChanged: (content) {
        value = FhirDateTime(content);
      },
    );
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
      QuestionnaireResponseAnswer(valueDateTime: value);
}
