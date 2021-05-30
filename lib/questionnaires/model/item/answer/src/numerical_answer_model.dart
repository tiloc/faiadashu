import 'dart:collection';

import 'package:fhir/r4.dart';
import 'package:intl/intl.dart';

import '../../../../../coding/coding.dart';
import '../../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../../logging/logging.dart';
import '../../../../questionnaires.dart';

/// Models numerical answers.
class NumericalAnswerModel extends AnswerModel<String, Quantity> {
  static final _logger = Logger(NumericalAnswerModel);

  late final String _numberPattern;
  late final bool _isSliding;
  late final double _minValue;
  late final double _maxValue;
  late final int _maxDecimal;
  late final NumberFormat _numberFormat;
  late final double? _sliderStepValue;
  late final int? _sliderDivisions;

  int? get sliderDivisions => _sliderDivisions;
  double? get sliderStepValue => _sliderStepValue;

  String get numberPattern => _numberPattern;
  bool get isSliding => _isSliding;
  double get minValue => _minValue;
  double get maxValue => _maxValue;
  int get maxDecimal => _maxDecimal;
  NumberFormat get numberFormat => _numberFormat;

  late final LinkedHashMap<String, Coding> _units;

  bool get hasUnit => value?.hasUnit ?? false;

  bool get hasUnitChoices => _units.isNotEmpty;

  bool get hasSingleUnitChoice => _units.length == 1;

  Iterable<Coding> get unitChoices => _units.values;

  Coding? unitChoiceByKey(String? key) {
    return (key != null) ? _units[key] : null;
  }

  String keyForUnitChoice(Coding coding) {
    final choiceString =
        (coding.code != null) ? coding.code?.value : coding.display;

    if (choiceString == null) {
      throw QuestionnaireFormatException(
          'Insufficient info for key string in $coding', coding);
    } else {
      return choiceString;
    }
  }

  /// Returns a unique slug for the current unit.
  String? get keyOfUnit {
    if (!(value?.hasUnit ?? false)) {
      return null;
    }

    final coding =
        Coding(system: value?.system, code: value?.code, display: value?.unit);

    return keyForUnitChoice(coding);
  }

  NumericalAnswerModel(ResponseModel responseModel, int answerIndex)
      : super(responseModel, answerIndex) {
    _isSliding = itemModel.questionnaireItem.isItemControl('slider');

    final minValueExtension = qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/minValue');
    final maxValueExtension = itemModel.questionnaireItem.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/maxValue');
    _minValue = minValueExtension?.valueDecimal?.value ??
        minValueExtension?.valueInteger?.value?.toDouble() ??
        0.0;
    _maxValue = maxValueExtension?.valueDecimal?.value ??
        maxValueExtension?.valueInteger?.value?.toDouble() ??
        (_isSliding ? 100.0 : double.maxFinite);

    if (_isSliding) {
      final sliderStepValueExtension = qi.extension_?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-sliderStepValue');
      _sliderStepValue = sliderStepValueExtension?.valueDecimal?.value ??
          sliderStepValueExtension?.valueInteger?.value?.toDouble();
      _sliderDivisions = (_sliderStepValue != null)
          ? ((_maxValue - _minValue) / _sliderStepValue!).round()
          : null;
    }

    // TODO: Evaluate max length
    switch (qi.type) {
      case QuestionnaireItemType.integer:
        _maxDecimal = 0;
        break;
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.quantity:
        // TODO: Evaluate special extensions for quantities
        _maxDecimal = qi.extension_
                ?.extensionOrNull(
                    'http://hl7.org/fhir/StructureDefinition/maxDecimalPlaces')
                ?.valueInteger
                ?.value ??
            3; // this is just an assumption what makes sense to your average human...
        break;
      default:
        throw StateError('item.type cannot be ${qi.type}');
    }

    // Build a number format based on item and SDC properties.
    final maxIntegerDigits = (_maxValue != double.maxFinite)
        ? '############'.substring(0, _maxValue.toInt().toString().length)
        : '############';
    final maxFractionDigits =
        (_maxDecimal != 0) ? '.0#####'.substring(0, _maxDecimal + 1) : '';

    _numberPattern = '$maxIntegerDigits$maxFractionDigits';

    _logger.debug(
      'input format for ${itemModel.linkId}: "$_numberPattern"',
    );

    _numberFormat = NumberFormat(_numberPattern,
        locale.toLanguageTag()); // TODO: toString or toLanguageTag?

    final unit = qi.unit;
    // ignore: prefer_collection_literals
    _units = LinkedHashMap<String, Coding>();
    final unitsUri = qi.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-unitValueSet')
        ?.valueCanonical
        .toString();
    if (unitsUri != null) {
      itemModel.questionnaireModel.forEachInValueSet(unitsUri, (coding) {
        _units[keyForUnitChoice(coding)] = coding;
      }, context: qi.linkId);
    } else if (unit != null) {
      _units[keyForUnitChoice(unit)] = unit;
    }

    // TODO: Evaluate initialValue extension
    Quantity? existingValue;
    final firstAnswer = itemModel.responseItem?.answer?.firstOrNull;
    if (firstAnswer != null) {
      existingValue = firstAnswer.valueQuantity ??
          ((firstAnswer.valueDecimal != null &&
                  firstAnswer.valueDecimal!.isValid)
              ? Quantity(value: firstAnswer.valueDecimal)
              : (firstAnswer.valueInteger != null &&
                      firstAnswer.valueInteger!.isValid)
                  ? Quantity(
                      value:
                          Decimal(firstAnswer.valueInteger!.value!.toDouble()))
                  : null);
    }
    value = (existingValue == null && isSliding)
        ? Quantity(
            value: Decimal(
                (maxValue - minValue) / 2.0)) // Slider needs a guaranteed value
        : existingValue;
  }

  @override
  String get display => value?.format(locale) ?? AnswerModel.nullText;

  @override
  String? validate(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }
    num number = double.nan;
    try {
      number = numberFormat.parse(inputValue);
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

  /// Returns a modified copy of the current [value].
  ///
  /// * Keeps the numerical value
  /// * Updates the unit based on a key as returned by [keyForUnitChoice]
  Quantity? copyWithUnit(String? unitChoiceKey) {
    final unitCoding = unitChoiceByKey(unitChoiceKey);

    return (value != null)
        ? value!.copyWith(
            unit: unitCoding?.localizedDisplay(locale),
            system: unitCoding?.system,
            code: unitCoding?.code)
        : Quantity(
            unit: unitCoding?.localizedDisplay(locale),
            system: unitCoding?.system,
            code: unitCoding?.code);
  }

  /// Returns a modified copy of the current [value].
  ///
  /// * Updates the numerical value based on a [Decimal]
  /// * Keeps the unit
  Quantity? copyWithValue(Decimal? newValue) {
    return (value != null)
        ? value!.copyWith(value: newValue)
        : Quantity(value: newValue);
  }

  /// Returns a modified copy of the current [value].
  ///
  /// * Updates the numerical value based on text input
  /// * Keeps the unit
  Quantity? copyWithTextInput(String textInput) {
    final valid = validate(textInput) == null;
    final dataAbsentReasonExtension = !valid
        ? [
            FhirExtension(
                url: dataAbsentReasonExtensionUrl,
                valueCode: dataAbsentReasonAsTextCode)
          ]
        : null;

    Quantity? returnValue;

    if (textInput.trim().isEmpty) {
      returnValue = value?.copyWith(value: null);
    } else {
      if (value == null) {
        returnValue = Quantity(
            value: Decimal(numberFormat.parse(textInput)),
            extension_: dataAbsentReasonExtension);
      } else {
        returnValue = value!.copyWith(
            value: Decimal(numberFormat.parse(textInput)),
            extension_: dataAbsentReasonExtension);
      }
    }

    return returnValue;
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
