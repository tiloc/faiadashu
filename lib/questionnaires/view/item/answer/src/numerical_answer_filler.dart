import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Filler for answers of type [Integer], [Decimal], and [Quantity].
class NumericalAnswerFiller extends QuestionnaireAnswerFiller {
  NumericalAnswerFiller(
    super.answerModel, {
    super.key,
  });

  @override
  State<NumericalAnswerFiller> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState extends QuestionnaireAnswerFillerState<Quantity,
    NumericalAnswerFiller, NumericalAnswerModel> {
  final TextEditingController _editingController = TextEditingController();

  // This is being used like a controller
  final ValueNotifier<double> _sliderValueDuringChange = ValueNotifier(0.0);

  @override
  void postInitState() {
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
    _sliderValueDuringChange.value = (answerModel.value != null)
        ? answerModel.value!.value!.value!
        : (answerModel.maxValue - answerModel.minValue) / averageDivisor;

    _sliderValueDuringChange.addListener(() {
      // ignore: no-empty-block
      setState(() {
        // Repaint this parent widget when the slider changes.
      });
    });
  }

  @override
  Widget createInputControl() => answerModel.isSliding
      ? _SliderInputControl(
          answerModel,
          focusNode: firstFocusNode,
          sliderValueDuringChange: _sliderValueDuringChange,
        )
      : _NumberFieldInputControl(
          answerModel,
          focusNode: firstFocusNode,
          editingController: _editingController,
        );
}

class _SliderInputControl extends AnswerInputControl<NumericalAnswerModel> {
  final ValueNotifier<double> sliderValueDuringChange;

  const _SliderInputControl(
    NumericalAnswerModel answerModel, {
    required this.sliderValueDuringChange,
    FocusNode? focusNode,
    Key? key,
  }) : super(
          answerModel,
          focusNode: focusNode,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final answerModel = this.answerModel;
    final lowerSliderLabel = answerModel.lowerSliderLabel;
    final upperSliderLabel = answerModel.upperSliderLabel;

    final hasSliderLabels =
        lowerSliderLabel != null || upperSliderLabel != null;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Slider(
                focusNode: focusNode,
                min: answerModel.minValue,
                max: answerModel.maxValue,
                divisions: answerModel.sliderDivisions,
                value: sliderValueDuringChange.value,
                label: Decimal(sliderValueDuringChange.value).format(locale),
                // Changes are only propagated to the model at change-end time.
                // onChange would cause very high-frequency storm of model updates
                onChanged: answerModel.isControlEnabled
                    ? (sliderValue) {
                        sliderValueDuringChange.value = sliderValue;
                      }
                    : null, // Method required, or it gets disabled. setState required for updates.
                onChangeEnd: answerModel.isControlEnabled
                    ? (sliderValue) {
                        sliderValueDuringChange.value = sliderValue;
                        answerModel.value =
                            answerModel.copyWithValue(Decimal(sliderValue));
                      }
                    : null,
                onChangeStart: (_) {
                  focusNode?.requestFocus();
                },
              ),
            ),
            if (answerModel.hasUnitChoices)
              SizedBox(
                height: 16,
                child: _UnitDropDown(
                  answerModel,
                ),
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
                  defaultTextStyle: Theme.of(context).textTheme.labelLarge,
                ),
              const Expanded(child: SizedBox()),
              if (upperSliderLabel != null)
                Xhtml.fromRenderingString(
                  context,
                  upperSliderLabel,
                  defaultTextStyle: Theme.of(context).textTheme.labelLarge,
                ),
              const SizedBox(width: 8.0),
            ],
          ),
        if (hasSliderLabels) const SizedBox(height: 8.0),
      ],
    );
  }
}

class _NumberFieldInputControl
    extends AnswerInputControl<NumericalAnswerModel> {
  final TextEditingController editingController;
  final TextInputFormatter numberInputFormatter;

  _NumberFieldInputControl(
    NumericalAnswerModel answerModel, {
    required this.editingController,
    FocusNode? focusNode,
    Key? key,
  })  : numberInputFormatter =
            NumericalTextInputFormatter(answerModel.numberFormat),
        super(
          answerModel,
          focusNode: focusNode,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    // FIXME: What should be the repaint mechanism for calculated items?
    // (it is getting repainted currently, but further optimization might break that)

    // Calculated items need an automated entry into the text field.
    if (itemModel.isCalculated) {
      final currentValue = (answerModel.value?.value != null)
          ? answerModel.value!.value!.format(locale)
          : '';

      editingController.value = TextEditingValue(
        text: currentValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: currentValue.length),
        ),
      );
    }

    final theme = QuestionnaireTheme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        height: theme.textFieldHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                enabled: answerModel.isControlEnabled,
                controller: editingController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  errorText: answerModel.displayErrorText,
                  errorStyle: (itemModel
                          .isCalculated) // Force display of error text on calculated item
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.error,
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
                          child: _UnitDropDown(
                            answerModel,
                          ),
                        )
                      : null,
                ),
                inputFormatters: [numberInputFormatter],
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
                  answerModel.value = answerModel.copyWithTextInput(content);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitDropDown extends AnswerInputControl<NumericalAnswerModel> {
  const _UnitDropDown(
    NumericalAnswerModel answerModel,
  ) : super(answerModel);

  @override
  Widget build(BuildContext context) {
    const unitWidth = 96.0;

    return answerModel.hasSingleUnitChoice
        ? Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 8, top: 10),
            width: unitWidth,
            child: Text(
              answerModel.unitChoices.first.localizedDisplay(locale),
              style: Theme.of(context).textTheme.bodyMedium,
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
}
