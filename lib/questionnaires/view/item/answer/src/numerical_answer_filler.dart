import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Filler for answers of type [Integer], [Decimal], and [Quantity].
class NumericalAnswerFiller extends QuestionnaireAnswerFiller {
  NumericalAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);

  @override
  State<NumericalAnswerFiller> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState extends QuestionnaireAnswerFillerState<Quantity,
    NumericalAnswerFiller, NumericalAnswerModel> {
  late final TextInputFormatter _numberInputFormatter;
  final TextEditingController _editingController = TextEditingController();

  double _sliderValueDuringChange = 0.0;

  @override
  void postInitState() {
    _numberInputFormatter =
        NumericalTextInputFormatter(answerModel.numberFormat);

    final initialValue = (answerModel.value?.value != null)
        ? answerModel.value!.value!.format(locale)
        : '';

    _editingController.value = TextEditingValue(
      text: initialValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: initialValue.length),
      ),
    );

    const averageDivisor = 2.0;
    _sliderValueDuringChange = (answerModel.value != null)
        ? answerModel.value!.value!.value!
        : (answerModel.maxValue - answerModel.minValue) / averageDivisor;
  }

  Widget _buildDropDownFromUnits(BuildContext context) {
    const unitWidth = 96.0;

    return answerModel.hasSingleUnitChoice
        ? Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 8, top: 10),
            width: unitWidth,
            child: Text(
              answerModel.unitChoices.first.localizedDisplay(locale),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        : Container(
            padding: const EdgeInsets.only(left: 8),
            width: unitWidth,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: answerModel.keyOfUnit,
                hint: const NullDashText(),
                onChanged: (answerModel.isControlEnabled)
                    ? (String? newValue) {
                        answerModel.value = answerModel.copyWithUnit(newValue);
                      }
                    : null,
                items: [
                  const DropdownMenuItem<String>(child: NullDashText()),
                  ...answerModel.unitChoices
                      .map<DropdownMenuItem<String>>((Coding value) {
                    return DropdownMenuItem<String>(
                      value: answerModel.keyForUnitChoice(value),
                      child: Text(value.localizedDisplay(locale)),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
  }

  @override
  Widget buildInputControl(BuildContext context) {
    // Calculated items need an automated entry into the text field.
    if (itemModel.isCalculated) {
      final currentValue = (answerModel.value?.value != null)
          ? answerModel.value!.value!.format(locale)
          : '';

      _editingController.value = TextEditingValue(
        text: currentValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: currentValue.length),
        ),
      );
    }

    final lowerSliderLabel = answerModel.lowerSliderLabel;
    final upperSliderLabel = answerModel.upperSliderLabel;

    final hasSliderLabels =
        lowerSliderLabel != null || upperSliderLabel != null;

    return answerModel.isSliding
        ? Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      focusNode: firstFocusNode,
                      min: answerModel.minValue,
                      max: answerModel.maxValue,
                      divisions: answerModel.sliderDivisions,
                      value: _sliderValueDuringChange,
                      label: Decimal(_sliderValueDuringChange).format(locale),
                      // Changes are only propagated to the model at change-end time.
                      // onChange would cause very high-frequency storm of model updates
                      onChanged: answerModel.isControlEnabled
                          ? (sliderValue) {
                              setState(() {
                                _sliderValueDuringChange = sliderValue;
                              });
                            }
                          : null, // Method required, or it gets disabled. setState required for updates.
                      onChangeEnd: answerModel.isControlEnabled
                          ? (sliderValue) {
                              _sliderValueDuringChange = sliderValue;
                              answerModel.value = answerModel
                                  .copyWithValue(Decimal(sliderValue));
                            }
                          : null,
                      onChangeStart: (_) {
                        firstFocusNode.requestFocus();
                      },
                    ),
                  ),
                  if (answerModel.hasUnitChoices)
                    SizedBox(
                      height: 16,
                      child: _buildDropDownFromUnits(context),
                    ),
                ],
              ),
              if (hasSliderLabels)
                Row(
                  children: [
                    const SizedBox(width: 8.0),
                    if (lowerSliderLabel != null)
                      Xhtml.fromRenderingString(
                        context,
                        lowerSliderLabel,
                        defaultTextStyle: Theme.of(context).textTheme.button,
                      ),
                    const Expanded(child: SizedBox()),
                    if (upperSliderLabel != null)
                      Xhtml.fromRenderingString(
                        context,
                        upperSliderLabel,
                        defaultTextStyle: Theme.of(context).textTheme.button,
                      ),
                    const SizedBox(width: 8.0),
                  ],
                ),
              if (hasSliderLabels) const SizedBox(height: 8.0),
            ],
          )
        : Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: firstFocusNode,
                    enabled: answerModel.isControlEnabled,
                    controller: _editingController,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      errorText: answerModel.displayErrorText,
                      errorStyle: (itemModel
                              .isCalculated) // Force display of error text on calculated item
                          ? TextStyle(
                              color: Theme.of(context).errorColor,
                            )
                          : null,
                      hintText: answerModel.entryFormat,
                      prefixIcon: itemModel.isCalculated
                          ? Icon(
                              Icons.calculate,
                              color: (answerModel.displayErrorText != null)
                                  ? Theme.of(context).errorColor
                                  : null,
                            )
                          : null,
                      suffixIcon: (answerModel.hasUnitChoices)
                          ? SizedBox(
                              height: 16,
                              child: _buildDropDownFromUnits(context),
                            )
                          : null,
                    ),
                    inputFormatters: [_numberInputFormatter],
                    keyboardType: TextInputType.numberWithOptions(
                      signed: answerModel.minValue < 0,
                      decimal: answerModel.maxDecimal > 0,
                    ),
                    validator: (itemModel.isCalculated)
                        ? null
                        : (inputValue) {
                            return answerModel.validateInput(inputValue);
                          },
                    autovalidateMode: (itemModel.isCalculated)
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.always,
                    onChanged: (content) {
                      answerModel.value =
                          answerModel.copyWithTextInput(content);
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
