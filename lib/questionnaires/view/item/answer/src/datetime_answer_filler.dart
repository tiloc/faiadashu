import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart' show FhirDate, FhirDateTime, FhirTime;
import 'package:flutter/material.dart';

class DateTimeAnswerFiller extends QuestionnaireAnswerFiller {
  DateTimeAnswerFiller(
    super.answerModel, {
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _DateTimeAnswerState();
}

class _DateTimeAnswerState extends QuestionnaireAnswerFillerState<FhirDateTime,
    DateTimeAnswerFiller, DateTimeAnswerModel> {
  _DateTimeAnswerState();

  @override
  // ignore: no-empty-block
  void postInitState() {
    // Intentionally do nothing.
  }

  @override
  Widget createInputControl() => _DateTimeInputControl(
        answerModel,
        focusNode: firstFocusNode,
      );
}

class _DateTimeInputControl extends AnswerInputControl<DateTimeAnswerModel> {
  const _DateTimeInputControl(
    super.answerModel, {
    super.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final itemType = qi.type;

    final initialDate = (itemType.value != 'time') ? answerModel.value : null;

    final pickerType = ArgumentError.checkNotNull(
      const {
        'date': FhirDate,
        'datetime': FhirDateTime,
        'time': FhirTime,
      }[itemType.value],
    );

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: FhirDateTimePicker(
        focusNode: focusNode,
        enabled: answerModel.isControlEnabled,
        locale: locale,
        initialDateTime: initialDate,
        // TODO: This can be specified through minValue / maxValue
        firstDate: DateTime(1860),
        lastDate: DateTime(2050),
        pickerType: pickerType,
        decoration: InputDecoration(
          errorText: answerModel.displayErrorText,
          errorStyle: (itemModel
                  .isCalculated) // Force display of error text on calculated item
              ? TextStyle(
                  color: Theme.of(context).colorScheme.error,
                )
              : null,
        ),
        onChanged: (fhirDatetime) => answerModel.value = fhirDatetime,
      ),
    );
  }
}
