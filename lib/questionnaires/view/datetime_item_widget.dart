import 'package:date_time_picker/date_time_picker.dart';
import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';
import 'questionnaire_answer_filler.dart';

class DateTimeItemAnswer extends QuestionnaireAnswerFiller {
  const DateTimeItemAnswer(QuestionnaireLocation location,
      QuestionnaireResponseState responseState, int answerIndex,
      {Key? key})
      : super(location, responseState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _DateTimeItemState();
}

class _DateTimeItemState
    extends QuestionnaireAnswerState<FhirDateTime, DateTimeItemAnswer> {
  _DateTimeItemState() : super(null);

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
      initialDate: value?.value,
      onChanged: (content) {
        value = FhirDateTime(content);
      },
    );
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
      QuestionnaireResponseAnswer(valueDateTime: value);
}
