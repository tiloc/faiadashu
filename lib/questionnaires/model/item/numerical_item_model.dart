import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4/resource_types/specialized/definitional_artifacts/definitional_artifacts.dart';
import 'package:intl/intl.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logger.dart';
import '../questionnaire_extensions.dart';
import '../questionnaire_location.dart';
import 'item_model.dart';

/// Models numerical answers.
class NumericalItemModel extends ItemModel<String> {
  static final _logger = Logger(NumericalItemModel);

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

  NumericalItemModel(QuestionnaireLocation location) : super(location) {
    _isSliding = location.questionnaireItem.isItemControl('slider');

    final minValueExtension = qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/minValue');
    final maxValueExtension = location.questionnaireItem.extension_
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
      'input format for ${location.linkId}: "$_numberPattern"',
    );

    _numberFormat = NumberFormat(_numberPattern,
        locale.toLanguageTag()); // TODO: toString or toLanguageTag?
  }

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
}
