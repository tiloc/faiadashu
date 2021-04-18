import 'dart:collection';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../logging/logging.dart';
import '../../../model/item/numerical_item_model.dart';
import '../../../questionnaires.dart';
import 'numerical_input.dart';

class NumericalAnswer extends QuestionnaireAnswerFiller {
  const NumericalAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);

  @override
  State<NumericalAnswer> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState
    extends QuestionnaireAnswerState<Quantity, NumericalAnswer> {
  static final _logger = Logger(_NumericalAnswerState);

  late final NumericalItemModel _itemModel;
  late final int? _divisions;
  late final TextInputFormatter _numberInputFormatter;
  late final LinkedHashMap<String, Coding> _units;

  _NumericalAnswerState();

  String _keyStringFromCoding(Coding coding) {
    final choiceString =
        (coding.code != null) ? coding.code?.value : coding.display;

    if (choiceString == null) {
      throw QuestionnaireFormatException(
          'Insufficient info for key string in $coding', coding);
    } else {
      return choiceString;
    }
  }

  @override
  void initState() {
    super.initState();
    _itemModel = NumericalItemModel(location);

    if (_itemModel.isSliding) {
      final sliderStepValueExtension = qi.extension_?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue');
      final sliderStepValue = sliderStepValueExtension?.valueDecimal?.value ??
          sliderStepValueExtension?.valueInteger?.value?.toDouble();
      _divisions = (sliderStepValue != null)
          ? ((_itemModel.maxValue - _itemModel.minValue) / sliderStepValue)
              .round()
          : null;
    }

    _numberInputFormatter =
        NumericalTextInputFormatter(_itemModel.numberFormat);

    final unit = qi.unit;
    // ignore: prefer_collection_literals
    _units = LinkedHashMap<String, Coding>();
    final unitsUri = qi.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-unitValueSet')
        ?.valueCanonical
        .toString();
    if (unitsUri != null) {
      top.visitValueSet(unitsUri, (coding) {
        _units[_keyStringFromCoding(coding)] = coding;
      }, context: qi.linkId);
    } else if (unit != null) {
      _units[_keyStringFromCoding(unit)] = unit;
    }

    // TODO: look at initialValue extension
    Quantity? existingValue;
    final firstAnswer = location.responseItem?.answer?.firstOrNull;
    if (firstAnswer != null) {
      existingValue = firstAnswer.valueQuantity ??
          ((firstAnswer.valueDecimal != null)
              ? Quantity(value: firstAnswer.valueDecimal)
              : null);
    }
    initialValue = (existingValue == null && _itemModel.isSliding)
        ? Quantity(
            value: Decimal((_itemModel.maxValue - _itemModel.minValue) /
                2.0)) // Slider needs a guaranteed value
        : existingValue;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value?.format(locale) ?? '');
  }

  Widget _buildDropDownFromUnits(BuildContext context) {
    if (_units.length == 1) {
      return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8, top: 16),
          width: 96,
          child: Text(
            _units.values.first.localizedDisplay(locale),
            style: Theme.of(context).textTheme.subtitle1,
          ));
    }

    return Container(
        padding: const EdgeInsets.only(left: 8),
        width: 96,
        child: DropdownButton<String>(
          value: (value != null)
              ? _keyStringFromCoding(Coding(
                  system: value?.system,
                  code: value?.code,
                  display: value?.unit))
              : null,
          onChanged: (String? newValue) {
            final unitCoding = _units[newValue]!;
            value = (value != null)
                ? value!.copyWith(
                    unit: unitCoding.localizedDisplay(locale),
                    system: unitCoding.system,
                    code: unitCoding.code)
                : Quantity(
                    unit: unitCoding.localizedDisplay(locale),
                    system: unitCoding.system,
                    code: unitCoding.code);
          },
          items: _units.values.map<DropdownMenuItem<String>>((Coding value) {
            return DropdownMenuItem<String>(
              value: _keyStringFromCoding(value),
              child: Text(value.localizedDisplay(locale)),
            );
          }).toList(),
        ));
  }

  @override
  Widget buildEditable(BuildContext context) {
    return _itemModel.isSliding
        ? Slider(
            min: _itemModel.minValue,
            max: _itemModel.maxValue,
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
                  hintText: _itemModel.entryFormat,
                ),
                inputFormatters: [_numberInputFormatter],
                keyboardType: TextInputType.number,
                validator: (inputValue) {
                  return _itemModel.validate(inputValue);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (content) {
                  final valid = _itemModel.validate(content) == null;
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
                              Decimal(_itemModel.numberFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    } else {
                      value = value!.copyWith(
                          value:
                              Decimal(_itemModel.numberFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    }
                  }
                },
              )),
              if (_units.isNotEmpty) _buildDropDownFromUnits(context)
            ]));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    _logger.debug('fillAnswer: $value');
    if (value == null) {
      return null;
    }

    switch (qi.type) {
      case QuestionnaireItemType.decimal:
        return (value!.value != null)
            ? QuestionnaireResponseAnswer(
                valueDecimal: value!.value, extension_: value!.extension_)
            : null;
      case QuestionnaireItemType.quantity:
        return QuestionnaireResponseAnswer(
            valueQuantity: value, extension_: value!.extension_);
      case QuestionnaireItemType.integer:
        return (value!.value != null)
            ? QuestionnaireResponseAnswer(
                valueInteger: Integer(value!.value!.value!.round()),
                extension_: value!.extension_)
            : null;
      default:
        throw StateError('item.type cannot be ${qi.type}');
    }
  }
}
