import 'package:fhir/r4.dart'
    show Date, FhirDateTime, QuestionnaireItemType, Time;
import 'package:flutter/material.dart';

import '../../../../fhir_types/date_time_picker.dart';
import '../../../model/item/answer/datetime_answer_model.dart';
import '../../../questionnaires.dart';
import '../questionnaire_answer_filler.dart';

class DateTimeAnswerFiller extends QuestionnaireAnswerFiller {
  const DateTimeAnswerFiller(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation,
      {Key? key})
      : super(itemModel, answerLocation, key: key);
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
}
