import 'package:faiadashu/coding/coding.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

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
  static final logger = Logger(_NumericalAnswerState);

  late final String _numberFormat;
  late final bool _isSlider;
  late final double _minValue;
  late final double _maxValue;
  late final int _maxDecimal;
  late final int? _divisions;

  _NumericalAnswerState();

  @override
  void initState() {
    super.initState();
    _isSlider = widget.location.questionnaireItem.isItemControl('slider');

    // TODO: Enhancement: This could all be moved into a model.
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
      final sliderStepValueExtension =
          widget.location.questionnaireItem.extension_?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue');
      final sliderStepValue = sliderStepValueExtension?.valueDecimal?.value ??
          sliderStepValueExtension?.valueInteger?.value?.toDouble();
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

    _numberFormat = '$maxIntegerDigits$maxFractionDigits';

    logger.log('input format for ${widget.location.linkId}: "$_numberFormat"',
        level: LogLevel.debug);

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
    return Text(
        (value != null) ? value!.format(Localizations.localeOf(context)) : '');
  }

  Widget _buildDropDownFromUnits(BuildContext context, List<Coding> units) {
    if (units.length == 1) {
      return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 8, top: 16),
          width: 96,
          child: Text(
            units.first.localizedDisplay(Localizations.localeOf(context)),
            style: Theme.of(context).textTheme.subtitle1,
          ));
    }

    return Container(
        padding: const EdgeInsets.only(left: 8),
        width: 96,
        child: DropdownButton<String>(
          value: value?.unit,
          onChanged: (String? newValue) {
            value = (value != null)
                ? value!.copyWith(unit: newValue)
                : Quantity(unit: newValue);
          },
          items: units.map<DropdownMenuItem<String>>((Coding value) {
            return DropdownMenuItem<String>(
              value: value.code!.value,
              child:
                  Text(value.localizedDisplay(Localizations.localeOf(context))),
            );
          }).toList(),
        ));
  }

  String? _validate(
      String? inputValue, NumberFormat numberInputFormat, Locale locale) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }
    num number = double.nan;
    try {
      number = numberInputFormat.parse(inputValue);
    } catch (_) {
      // Ignore FormatException, number remains nan.
    }
    if (number == double.nan) {
      return '$inputValue is not a valid number.';
    }
    if (number > _maxValue) {
      return 'Enter a number up to ${Decimal(_maxValue).format(locale)}.';
    }
    if (number < _minValue) {
      return 'Enter a number ${Decimal(_minValue).format(locale)}, or higher.';
    }
  }

  @override
  Widget buildEditable(BuildContext context) {
    final numberInputFormat = NumberFormat(
        _numberFormat,
        Localizations.localeOf(context)
            .toLanguageTag()); // TODO: toString or toLanguageTag?

    final numberInputFormatter =
        _NumericalTextInputFormatter(numberInputFormat);

    final qi = widget.location.questionnaireItem;
    final locale = Localizations.localeOf(context);
    final unit = qi.unit;
    final units = <Coding>[];
    final unitsUri = qi.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-unitValueSet')
        ?.valueCanonical
        .toString();
    if (unitsUri != null) {
      widget.location.top.visitValueSet(unitsUri, (coding) {
        units.add(coding);
      }, context: qi.linkId);
    } else if (unit != null) {
      units.add(Coding(code: Code(unit)));
    }

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
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: TextFormField(
                initialValue: (value?.value != null)
                    ? value!.value!.format(Localizations.localeOf(context))
                    : null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: entryFormat,
                ),
                inputFormatters: [numberInputFormatter],
                keyboardType: TextInputType.number,
                validator: (inputValue) {
                  return _validate(inputValue, numberInputFormat, locale);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (content) {
                  final valid =
                      _validate(content, numberInputFormat, locale) == null;
                  final dataAbsentReasonExtension = !valid
                      ? [
                          FhirExtension(
                              url: DataAbsentReason.extensionUrl,
                              valueCoding: DataAbsentReason.invalid)
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
                          value: Decimal(numberInputFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    } else {
                      value = value!.copyWith(
                          value: Decimal(numberInputFormat.parse(content)),
                          extension_: dataAbsentReasonExtension);
                    }
                  }
                },
              )),
              if (units.isNotEmpty) _buildDropDownFromUnits(context, units)
            ]));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    logger.log('fillAnswer: $value', level: LogLevel.debug);
    if (value == null) {
      return null;
    }

    switch (widget.location.questionnaireItem.type) {
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
        throw StateError(
            'item.type cannot be ${widget.location.questionnaireItem.type}');
    }
  }
}

/// An input formatter for internationalized input of numbers.
class _NumericalTextInputFormatter extends TextInputFormatter {
  static final logger = Logger(_NumericalTextInputFormatter);
  final NumberFormat numberFormat;
  _NumericalTextInputFormatter(this.numberFormat);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    // Group separator is causing lots of trouble. Suppress.
    if (newValue.text.contains(numberFormat.symbols.GROUP_SEP)) {
      return oldValue;
    }

    // NumberFormat.parse is not preventing decimal points on integers.
    if (newValue.text.contains(numberFormat.symbols.DECIMAL_SEP) &&
        numberFormat.maximumFractionDigits == 0) {
      return oldValue;
    }

    try {
      final parsed = numberFormat.parse(newValue.text);
      logger.trace('parsed: ${newValue.text} -> $parsed');
      return newValue;
    } catch (_) {
      return oldValue;
    }
  }
}
