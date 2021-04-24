import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../model/item/answer/numerical_answer_model.dart';
import '../../../questionnaires.dart';
import 'null_dash_text.dart';
import 'numerical_input.dart';

class NumericalAnswerFiller extends QuestionnaireAnswerFiller {
  const NumericalAnswerFiller(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);

  @override
  State<NumericalAnswerFiller> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState extends QuestionnaireAnswerState<Quantity,
    NumericalAnswerFiller, NumericalAnswerModel> {
  late final int? _divisions;
  late final TextInputFormatter _numberInputFormatter;

  _NumericalAnswerState();

  @override
  void postInitState() {
    if (answerModel.isSliding) {
      final sliderStepValueExtension = qi.extension_?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue');
      final sliderStepValue = sliderStepValueExtension?.valueDecimal?.value ??
          sliderStepValueExtension?.valueInteger?.value?.toDouble();
      _divisions = (sliderStepValue != null)
          ? ((answerModel.maxValue - answerModel.minValue) / sliderStepValue)
              .round()
          : null;
    }

    _numberInputFormatter =
        NumericalTextInputFormatter(answerModel.numberFormat);
  }

  Widget _buildDropDownFromUnits(BuildContext context) {
    if (answerModel.units.length == 1) {
      return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8, top: 16),
          width: 96,
          child: Text(
            answerModel.units.values.first.localizedDisplay(locale),
            style: Theme.of(context).textTheme.subtitle1,
          ));
    }

    return Container(
        padding: const EdgeInsets.only(left: 8),
        width: 96,
        child: DropdownButton<String>(
            value: (answerModel.hasUnit(value))
                ? answerModel.keyStringFromCoding(Coding(
                    system: value?.system,
                    code: value?.code,
                    display: value?.unit))
                : null,
            hint: const NullDashText(),
            onChanged: (String? newValue) {
              final unitCoding =
                  (newValue != null) ? answerModel.units[newValue]! : null;
              value = (value != null)
                  ? value!.copyWith(
                      unit: unitCoding?.localizedDisplay(locale),
                      system: unitCoding?.system,
                      code: unitCoding?.code)
                  : Quantity(
                      unit: unitCoding?.localizedDisplay(locale),
                      system: unitCoding?.system,
                      code: unitCoding?.code);
            },
            items: [
              const DropdownMenuItem<String>(
                child: NullDashText(),
              ),
              ...answerModel.units.values
                  .map<DropdownMenuItem<String>>((Coding value) {
                return DropdownMenuItem<String>(
                  value: answerModel.keyStringFromCoding(value),
                  child: Text(value.localizedDisplay(locale)),
                );
              }).toList()
            ]));
  }

  @override
  Widget buildEditable(BuildContext context) {
    return answerModel.isSliding
        ? Slider(
            min: answerModel.minValue,
            max: answerModel.maxValue,
            divisions: _divisions,
            value: value!.value!.value!, // Yay, triple value!
            onChanged: (sliderValue) {
              value = Quantity(value: Decimal(sliderValue));
            },
          )
        : Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: TextFormField(
                initialValue: (value?.value != null)
                    ? value!.value!.format(locale)
                    : null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: answerModel.entryFormat,
                ),
                inputFormatters: [_numberInputFormatter],
                keyboardType: TextInputType.number,
                validator: (inputValue) {
                  return answerModel.validate(inputValue);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (content) {
                  final valid = answerModel.validate(content) == null;
                  final dataAbsentReasonExtension = !valid
                      ? [
                          FhirExtension(
                              url: DataAbsentReason.extensionUrl,
                              valueCode: DataAbsentReason.asTextCode)
                        ]
                      : null;

                  if (content.trim().isEmpty) {
                    // TODO: Will copyWith value: null leave the value untouched or kill it?
                    if (value == null) {
                      value = null;
                    } else {
                      value = value!.copyWith(value: null);
                    }
                  } else {
                    if (value == null) {
                      value = Quantity(
                          value:
                              Decimal(answerModel.numberFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    } else {
                      value = value!.copyWith(
                          value:
                              Decimal(answerModel.numberFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    }
                  }
                },
              )),
              if (answerModel.units.isNotEmpty) _buildDropDownFromUnits(context)
            ]));
  }
}
