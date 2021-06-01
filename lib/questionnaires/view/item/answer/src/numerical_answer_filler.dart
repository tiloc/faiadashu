import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../../questionnaires.dart';
import 'numerical_input_formatter.dart';

/// Filler for answers of type [Integer], [Decimal], and [Quantity].
class NumericalAnswerFiller extends QuestionnaireAnswerFiller {
  NumericalAnswerFiller(
      QuestionnaireResponseFillerState responseFillerState, int answerIndex,
      {Key? key})
      : super(responseFillerState, answerIndex, key: key);

  @override
  State<NumericalAnswerFiller> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState extends QuestionnaireAnswerState<Quantity,
    NumericalAnswerFiller, NumericalAnswerModel> {
  late final TextInputFormatter _numberInputFormatter;

  @override
  void postInitState() {
    _numberInputFormatter =
        NumericalTextInputFormatter(answerModel.numberFormat);
  }

  Widget _buildDropDownFromUnits(BuildContext context) {
    if (answerModel.hasSingleUnitChoice) {
      return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8, top: 10),
          width: 96,
          child: Text(
            answerModel.unitChoices.first.localizedDisplay(locale),
            style: Theme.of(context).textTheme.subtitle1,
          ));
    } else {
      return Container(
        padding: const EdgeInsets.only(left: 8),
        width: 96,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: answerModel.keyOfUnit,
              hint: const NullDashText(),
              onChanged: (answerModel.isEnabled)
                  ? (String? newValue) {
                      value = answerModel.copyWithUnit(newValue);
                    }
                  : null,
              items: [
                const DropdownMenuItem<String>(
                  child: NullDashText(),
                ),
                ...answerModel.unitChoices
                    .map<DropdownMenuItem<String>>((Coding value) {
                  return DropdownMenuItem<String>(
                    value: answerModel.keyForUnitChoice(value),
                    child: Text(value.localizedDisplay(locale)),
                  );
                }).toList()
              ]),
        ),
      );
    }
  }

  @override
  Widget buildInputControl(BuildContext context) {
    return answerModel.isSliding
        ? Slider(
            focusNode: firstFocusNode,
            min: answerModel.minValue,
            max: answerModel.maxValue,
            divisions: answerModel.sliderDivisions,
            value: value!.value!.value!, // Yay, triple value!
            label: answerModel.display,
            onChanged: answerModel.isEnabled
                ? (sliderValue) {
                    value = answerModel.copyWithValue(Decimal(sliderValue));
                  }
                : null,
            onChangeStart: (_) {
              firstFocusNode.requestFocus();
            },
          )
        : Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: TextFormField(
                focusNode: firstFocusNode,
                enabled: answerModel.isEnabled,
                initialValue: (value?.value != null)
                    ? value!.value!.format(locale)
                    : null,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.end,
                decoration: questionnaireTheme.createDecoration().copyWith(
                      hintText: answerModel.entryFormat,
                      suffixIcon: (answerModel.hasUnitChoices)
                          ? SizedBox(
                              height: 16,
                              child: _buildDropDownFromUnits(context))
                          : null,
                    ),
                inputFormatters: [_numberInputFormatter],
                keyboardType: TextInputType.number,
                validator: (inputValue) {
                  return answerModel.validate(inputValue);
                },
                autovalidateMode: AutovalidateMode.always,
                onChanged: (content) {
                  value = answerModel.copyWithTextInput(content);
                },
              )),
            ]));
  }
}
