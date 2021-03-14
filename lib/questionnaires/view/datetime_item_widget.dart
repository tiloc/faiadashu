import 'package:date_time_picker/date_time_picker.dart';
import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';
import 'questionnaire_answer_filler.dart';

class DateTimeItemAnswer extends QuestionnaireAnswerFiller {
  const DateTimeItemAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _DateTimeItemState();
}

class _DateTimeItemState
    extends QuestionnaireAnswerState<FhirDateTime, DateTimeItemAnswer> {
  _DateTimeItemState();

  @override
  void initState() {
    super.initState();
    initialValue = widget.answerLocation.answer?.valueDateTime;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value?.value.toString() ?? '-');
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
