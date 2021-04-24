import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../model/item/numerical_item_model.dart';
import '../../../questionnaires.dart';
import 'null_dash_text.dart';
import 'numerical_input.dart';

class NumericalAnswer extends QuestionnaireAnswerFiller {
  const NumericalAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);

  @override
  State<NumericalAnswer> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState extends QuestionnaireAnswerState<Quantity,
    NumericalAnswer, NumericalItemModel> {
  late final int? _divisions;
  late final TextInputFormatter _numberInputFormatter;

  _NumericalAnswerState();

  @override
  void initState() {
    super.initState();

    if (itemModel.isSliding) {
      final sliderStepValueExtension = qi.extension_?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue');
      final sliderStepValue = sliderStepValueExtension?.valueDecimal?.value ??
          sliderStepValueExtension?.valueInteger?.value?.toDouble();
      _divisions = (sliderStepValue != null)
          ? ((itemModel.maxValue - itemModel.minValue) / sliderStepValue)
              .round()
          : null;
    }

    _numberInputFormatter = NumericalTextInputFormatter(itemModel.numberFormat);
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value?.format(locale) ?? '');
  }

  Widget _buildDropDownFromUnits(BuildContext context) {
    if (itemModel.units.length == 1) {
      return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8, top: 16),
          width: 96,
          child: Text(
            itemModel.units.values.first.localizedDisplay(locale),
            style: Theme.of(context).textTheme.subtitle1,
          ));
    }

    return Container(
        padding: const EdgeInsets.only(left: 8),
        width: 96,
        child: DropdownButton<String>(
            value: (itemModel.hasUnit(value))
                ? itemModel.keyStringFromCoding(Coding(
                    system: value?.system,
                    code: value?.code,
                    display: value?.unit))
                : null,
            hint: const NullDashText(),
            onChanged: (String? newValue) {
              final unitCoding =
                  (newValue != null) ? itemModel.units[newValue]! : null;
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
              ...itemModel.units.values
                  .map<DropdownMenuItem<String>>((Coding value) {
                return DropdownMenuItem<String>(
                  value: itemModel.keyStringFromCoding(value),
                  child: Text(value.localizedDisplay(locale)),
                );
              }).toList()
            ]));
  }

  @override
  Widget buildEditable(BuildContext context) {
    return itemModel.isSliding
        ? Slider(
            min: itemModel.minValue,
            max: itemModel.maxValue,
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
                  hintText: itemModel.entryFormat,
                ),
                inputFormatters: [_numberInputFormatter],
                keyboardType: TextInputType.number,
                validator: (inputValue) {
                  return itemModel.validate(inputValue);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (content) {
                  final valid = itemModel.validate(content) == null;
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
                          value: Decimal(itemModel.numberFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    } else {
                      value = value!.copyWith(
                          value: Decimal(itemModel.numberFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    }
                  }
                },
              )),
              if (itemModel.units.isNotEmpty) _buildDropDownFromUnits(context)
            ]));
  }
}
