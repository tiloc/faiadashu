import 'package:fhir/r4.dart'
    show Date, FhirDateTime, QuestionnaireItemType, Time;
import 'package:flutter/material.dart';

import '../../../../../fhir_types/date_time_picker.dart';
import '../../../../questionnaires.dart';

class DateTimeAnswerFiller extends QuestionnaireAnswerFiller {
  DateTimeAnswerFiller(
      QuestionnaireResponseFillerState responseFillerState, int answerIndex,
      {Key? key})
      : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _DateTimeAnswerState();
}

class _DateTimeAnswerState extends QuestionnaireAnswerState<FhirDateTime,
    DateTimeAnswerFiller, DateTimeAnswerModel> {
  _DateTimeAnswerState();

  @override
  void postInitState() {
    // Intentionally do nothing.
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
        focusNode: firstFocusNode,
        locale: locale,
        initialDateTime: initialDate,
        // TODO: This can be specified through minValue / maxValue
        firstDate: DateTime(1860),
        lastDate: DateTime(2050),
        pickerType: pickerType,
        decoration: viewFactory.createDecoration(),
        onChanged: (fhirDatetime) => value = fhirDatetime,
      ),
    );
  }
}
