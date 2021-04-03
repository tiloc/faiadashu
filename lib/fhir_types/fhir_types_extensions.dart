import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:intl/intl.dart';

import '../logging/logging.dart';

extension FDashDateTimeExtension on FhirDateTime {
  String format(Locale locale, {String defaultText = ''}) {
    final localeCode = locale.toString();
    if (precision != DateTimePrecision.INVALID) {
      final DateFormat dateFormat;
      switch (precision) {
        case DateTimePrecision.FULL:
        case DateTimePrecision.INVALID:
          dateFormat = DateFormat.yMd(localeCode).add_jms();
          break;
        case DateTimePrecision.YYYY:
          dateFormat = DateFormat.y(localeCode);
          break;
        case DateTimePrecision.YYYYMM:
          dateFormat = DateFormat.yM(localeCode);
          break;
        case DateTimePrecision.YYYYMMDD:
          dateFormat = DateFormat.yMd(localeCode);
          break;
      }
      return dateFormat.format(value!);
    } else {
      return defaultText;
    }
  }
}

extension FDashDecimalExtension on Decimal {
  static final logger = Logger(Decimal);

  String format(Locale locale) {
    if (!isValid) {
      return toString();
    }

    try {
      final decimalFormat = NumberFormat.decimalPattern(locale.toString());
      return decimalFormat.format(value);
    } catch (exception) {
      logger.log('Cannot format $this', level: LogLevel.warn, error: exception);
      rethrow;
    }
  }
}

extension FDashQuantityExtension on Quantity {
  String format(Locale locale,
      {String defaultText = '', String unknownValueText = '?'}) {
    if (value == null) {
      if (unit == null) {
        return defaultText;
      } else {
        return '$unknownValueText $unit';
      }
    } else {
      if (unit == null) {
        return value!.format(locale);
      } else {
        return '${value!.format(locale)} $unit';
      }
    }
  }
}

extension FDashCodingExtension on Coding {
  /// Localized access to display value
  String localizedDisplay(Locale locale) {
    // TODO: Carve this out to be used in other places (titles).
    final translationExtension = displayElement?.extension_?.firstWhereOrNull(
        (transExt) =>
            transExt.url ==
                FhirUri(
                    'http://hl7.org/fhir/StructureDefinition/translation') &&
            transExt.extension_?.firstWhereOrNull((ext) =>
                    (ext.url == FhirUri('lang')) &&
                    (ext.valueCode?.value == locale.languageCode)) !=
                null);

    if (translationExtension != null) {
      final contentString = translationExtension.extension_
          ?.extensionOrNull('content')
          ?.valueString;

      return ArgumentError.checkNotNull(contentString);
    }

    return display ?? code?.value ?? toString();
  }
}

extension FDashListCodingExtension on List<Coding> {
  /// Localized access to display value or empty string
  String localizedDisplay(Locale locale) {
    if (isEmpty) return '';
    return first.localizedDisplay(locale);
  }
}

extension FDashCodeableConceptExtension on CodeableConcept {
  /// Localized access to display value
  String localizedDisplay(Locale locale) {
    return coding?.firstOrNull?.display ??
        text ??
        coding?.firstOrNull?.code?.value ??
        toString();
  }

  bool containsCoding(String? system, String code) {
    return coding?.firstWhereOrNull((_coding) =>
            (_coding.code?.toString() == code) &&
            (_coding.system?.toString() == system)) !=
        null;
  }
}

extension FDashListFhirExtensionExtension on List<FhirExtension> {
  /// The extension with the given URI, or null
  FhirExtension? extensionOrNull(String uri) {
    return firstWhereOrNull((ext) {
      return ext.url == FhirUri(uri);
    });
  }
}

extension FDashListExtension<T> on List<T> {
  /// The first element of a list, or null if it is empty
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}
