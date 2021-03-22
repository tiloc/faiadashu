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
  late final NumberFormat _numberFormat;
  late final bool _isSlider;
  late final double _minValue;
  late final double _maxValue;
  late final int? _divisions;

  _NumericalAnswerState();

  @override
  void initState() {
    super.initState();

    _isSlider = widget.location.questionnaireItem.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl')
            ?.valueCodeableConcept
            ?.coding
            ?.firstOrNull
            ?.code
            ?.value ==
        'slider';

    if (_isSlider) {
      _minValue = 0.0;
      _maxValue = 100.0;
      final sliderStepValue = widget.location.questionnaireItem.extension_
          ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue')
          ?.valueInteger
          ?.value;
      _divisions = (sliderStepValue != null)
          ? ((_maxValue - _minValue) / sliderStepValue).round()
          : null;
    } else {
      _minValue = 0.0;
      _maxValue = double.maxFinite;
    }
    // TODO: Build a number format based on item and SDC properties.
    _numberFormat = NumberFormat('############.0##');

    _numberInputFormatter =
        TextInputFormatter.withFunction((oldValue, newValue) {
      try {
        _numberFormat.parse(newValue.text);
        return newValue;
      } catch (_) {
        return oldValue;
      }
    });

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
        : TextFormField(
            decoration: InputDecoration(
                labelText: widget.location.questionnaireItem.text),
            inputFormatters: [_numberInputFormatter],
            keyboardType: TextInputType.number,
            onChanged: (content) {
              if (content.trim().isEmpty) {
                value = null;
              } else {
                value = Quantity(value: Decimal(content));
              }
            },
          );
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
