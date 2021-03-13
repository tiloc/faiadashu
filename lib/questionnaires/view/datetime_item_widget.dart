import 'package:date_time_picker/date_time_picker.dart';
import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';
import 'questionnaire_item_filler.dart';

class DateTimeItemWidget extends QuestionnaireItemFiller {
  const DateTimeItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _DateTimeItemState();
}

class _DateTimeItemState
    extends QuestionnaireItemState<FhirDateTime, DateTimeItemWidget> {
  _DateTimeItemState() : super(null);

  @override
  Widget buildBodyReadOnly(BuildContext context) {
    return Text(value?.value.toString() ?? '-');
  }

  @override
  Widget buildBodyEditable(BuildContext context) {
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
        createResponse();
      },
    );
  }

  @override
  QuestionnaireResponseAnswer? createAnswer() =>
      QuestionnaireResponseAnswer(valueDateTime: value);
}
