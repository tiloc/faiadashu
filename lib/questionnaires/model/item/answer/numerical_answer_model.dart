import 'dart:collection';

import 'package:fhir/r4.dart';
import 'package:intl/intl.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../logging/logger.dart';
import '../../../questionnaires.dart';

/// Models numerical answers.
class NumericalAnswerModel extends AnswerModel<String, Quantity> {
  static final _logger = Logger(NumericalAnswerModel);

  late final String _numberPattern;
  late final bool _isSliding;
  late final double _minValue;
  late final double _maxValue;
  late final int _maxDecimal;
  late final NumberFormat _numberFormat;

  String get numberPattern => _numberPattern;
  bool get isSliding => _isSliding;
  double get minValue => _minValue;
  double get maxValue => _maxValue;
  int get maxDecimal => _maxDecimal;
  NumberFormat get numberFormat => _numberFormat;

  late final LinkedHashMap<String, Coding> units;

  bool hasUnit(Quantity? quantity) {
    if (quantity == null) {
      return false;
    }
    if (quantity.code == null && quantity.unit == null) {
      return false;
    }

    return true;
  }

  String keyStringFromCoding(Coding coding) {
    final choiceString =
        (coding.code != null) ? coding.code?.value : coding.display;

    if (choiceString == null) {
      throw QuestionnaireFormatException(
          'Insufficient info for key string in $coding', coding);
    } else {
      return choiceString;
    }
  }

  NumericalAnswerModel(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation)
      : super(itemModel, answerLocation) {
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
    units = LinkedHashMap<String, Coding>();
    final unitsUri = qi.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-unitValueSet')
        ?.valueCanonical
        .toString();
    if (unitsUri != null) {
      itemModel.questionnaireModel.forEachInValueSet(unitsUri, (coding) {
        units[keyStringFromCoding(coding)] = coding;
      }, context: qi.linkId);
    } else if (unit != null) {
      units[keyStringFromCoding(unit)] = unit;
    }

    // TODO: look at initialValue extension
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
