import 'dart:developer' as developer;

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../questionnaires.dart';

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
  late final TextInputFormatter _numberInputFormatter;
  late final NumberFormat _numberInputFormat;
  late final bool _isSlider;
  late final double _minValue;
  late final double _maxValue;
  late final int _maxDecimal;
  late final int? _divisions;
  late final String logTag;

  _NumericalAnswerState();

  @override
  void initState() {
    super.initState();
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';

    _isSlider = widget.location.questionnaireItem.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl')
            ?.valueCodeableConcept
            ?.coding
            ?.firstOrNull
            ?.code
            ?.value ==
        'slider';

    final minValueExtension = widget.location.questionnaireItem.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/minValue');
    final maxValueExtension = widget.location.questionnaireItem.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/maxValue');
    _minValue = minValueExtension?.valueDecimal?.value ??
        minValueExtension?.valueInteger?.value?.toDouble() ??
        0.0;
    _maxValue = maxValueExtension?.valueDecimal?.value ??
        maxValueExtension?.valueInteger?.value?.toDouble() ??
        (_isSlider ? 100.0 : double.maxFinite);

    if (_isSlider) {
      final sliderStepValue = widget.location.questionnaireItem.extension_
          ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue')
          ?.valueInteger
          ?.value;
      _divisions = (sliderStepValue != null)
          ? ((_maxValue - _minValue) / sliderStepValue).round()
          : null;
    }
    // TODO: Evaluate max length
    switch (widget.location.questionnaireItem.type) {
      case QuestionnaireItemType.integer:
        _maxDecimal = 0;
        break;
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.quantity:
        // TODO: Evaluate special extensions for quantities
        _maxDecimal = widget.location.questionnaireItem.extension_
                ?.extensionOrNull(
                    'http://hl7.org/fhir/StructureDefinition/maxDecimalPlaces')
                ?.valueInteger
                ?.value ??
            3; // this is just an assumption what makes sense to your average human...
        break;
      default:
        throw StateError(
            'item.type cannot be ${widget.location.questionnaireItem.type}');
    }

    // Build a number format based on item and SDC properties.
    final maxIntegerDigits = (_maxValue != double.maxFinite)
        ? '############'.substring(0, _maxValue.toInt().toString().length)
        : '############';
    final maxFractionDigits =
        (_maxDecimal != 0) ? '.0#####'.substring(0, _maxDecimal + 1) : '';
    _numberInputFormat = NumberFormat('$maxIntegerDigits$maxFractionDigits');

    developer.log(
        'input format for ${widget.location.linkId}: "$_numberInputFormat"',
        level: LogLevel.debug);

    // TODO: The format doesn't really restrict what can be entered.
    _numberInputFormatter =
        TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) {
        return newValue;
      }
      try {
        _numberInputFormat.parse(newValue.text);
        return newValue;
      } catch (_) {
        return oldValue;
      }
    });

    // TODO: look at initialValue extension
    Quantity? existingValue;
    final firstAnswer = widget.location.responseItem?.answer?.firstOrNull;
    if (firstAnswer != null) {
      existingValue = firstAnswer.valueQuantity ??
          ((firstAnswer.valueDecimal != null)
              ? Quantity(value: firstAnswer.valueDecimal)
              : null);
    }
    initialValue = (existingValue == null && _isSlider)
        ? Quantity(
            value: Decimal((_maxValue - _minValue) /
                2.0)) // Slider needs a guaranteed value
        : existingValue;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    // TODO: international number formatting
    return Text(value.toString());
  }

  @override
  Widget buildEditable(BuildContext context) {
    // TODO(tiloc): Do not hardcode . as separator
    return _isSlider
        ? Slider(
            min: _minValue,
            max: _maxValue,
            divisions: _divisions,
            value: value!.value!.value!, // Yay, triple value!
            onChanged: (sliderValue) {
              value = Quantity(value: Decimal(sliderValue));
            },
          )
        : Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [_numberInputFormatter],
              keyboardType: TextInputType.number,
              validator: (inputValue) {
                if (inputValue == null || inputValue.isEmpty) {
                  return null;
                }
                final number = double.tryParse(inputValue);
                if (number == null) {
                  return '$inputValue is not a valid number.';
                }
                if (number > _maxValue) {
                  return 'Enter a number up to $_maxValue.';
                }
                if (number < _minValue) {
                  return 'Enter a number $_minValue, or higher.';
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (content) {
                if (content.trim().isEmpty) {
                  value = null;
                } else {
                  value = Quantity(value: Decimal(content));
                }
              },
            ));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    developer.log('fillAnswer: $value', level: LogLevel.debug);
    if (value == null) {
      return null;
    }

    switch (widget.location.questionnaireItem.type) {
      case QuestionnaireItemType.decimal:
        return QuestionnaireResponseAnswer(valueDecimal: value!.value);
      case QuestionnaireItemType.quantity:
        return QuestionnaireResponseAnswer(valueQuantity: value);
      case QuestionnaireItemType.integer:
        return QuestionnaireResponseAnswer(
            valueInteger: Integer(value!.value!.value!.round()));
      default:
        throw StateError(
            'item.type cannot be ${widget.location.questionnaireItem.type}');
    }
  }
}
