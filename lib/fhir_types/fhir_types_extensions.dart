import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:intl/intl.dart';

import '../logging/logging.dart';

extension FDashTimeExtension on Time {
  String format(Locale locale, {String defaultText = ''}) {
    final localeCode = locale.toString();
    if (!isValid) {
      return defaultText;
    }

    return DateFormat.Hm(localeCode)
        .format(DateTime.parse('19700101T${toString()}'));
  }
}

extension FDashDateExtension on Date {
  String format(Locale locale, {String defaultText = ''}) {
    final localeCode = locale.toString();
    final DateFormat dateFormat;
    switch (precision) {
      case DatePrecision.YYYY:
        dateFormat = DateFormat.y(localeCode);
        break;
      case DatePrecision.YYYYMM:
        dateFormat = DateFormat.yM(localeCode);
        break;
      case DatePrecision.YYYYMMDD:
        dateFormat = DateFormat.yMd(localeCode);
        break;
      default:
        return defaultText;
    }
    return dateFormat.format(value!);
  }
}

extension FDashDateTimeExtension on FhirDateTime {
  String format(Locale locale, {String defaultText = ''}) {
    final localeCode = locale.toString();
    final DateFormat dateFormat;
    switch (precision) {
      case DateTimePrecision.INVALID:
        return defaultText;
      case DateTimePrecision.FULL:
        dateFormat = DateFormat.yMd(localeCode).add_jm();
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
  /// Returns whether [Coding] and another [Coding] are a match.
  ///
  /// Returns false if [otherCoding] is null.
  ///
  /// Follows Postel's law regarding case-sensitivity.
  /// > CodeSystem.caseSensitive: If this value is missing, then it is not specified whether a code system is case sensitive or not. When the rule is not known, Postel's law should be followed: produce codes with the correct case, and accept codes in any case.
  bool match(Coding? otherCoding) {
    if (otherCoding == null) {
      return false;
    }

    if (system != otherCoding.system) {
      return false;
    }

    if (code?.value == otherCoding.code?.value) {
      return true;
    }

    return code?.value != null &&
        otherCoding.code?.value != null &&
        code!.value!.toUpperCase() == otherCoding.code!.value!.toUpperCase();
  }

  /// Localized access to display value.
  /// TODO: Currently only matches by language.
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
  String localizedDisplay(Locale locale, {String defaultText = ''}) {
    if (isEmpty) return defaultText;
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

/// Access to [FhirExtension]s from a List.
///
/// Mimics a [Map] with String?/FhirUri as the key and FhirExtension as value.
/// Extensions are treated similar to a [Set]: Only one of each type can exist
/// and their order is not retained.
///
/// Unfortunately, since the [List] is already claiming the operators they
/// cannot be overridden here.
extension FDashListFhirExtensionExtension on List<FhirExtension> {
  FhirExtension? removeExtension(Object? key) {
    if (key == null) {
      return null;
    }

    if (key is FhirExtension) {
      final index = indexWhere((ext) {
        return ext == key;
      });
      return (index != -1) ? removeAt(index) : null;
    } else if (key is String) {
      final index = indexWhere((ext) {
        return ext.url == FhirUri(key);
      });
      return (index != -1) ? removeAt(index) : null;
    } else if (key is FhirUri) {
      final index = indexWhere((ext) {
        return ext.url == key;
      });
      return (index != -1) ? removeAt(index) : null;
    } else {
      throw ArgumentError.value(key, 'key',
          'Only FhirExtension, String and FhirUri are supported as key.');
    }
  }

  /// Sets the extension.
  ///
  /// Overwrites the existing one, if it exists.
  /// Adds it as a new one, if it did not exist.
  ///
  /// Does nothing if [extension] is null.
  void setExtension(FhirExtension? extension) {
    if (extension == null) {
      return;
    }

    removeExtension(extension);
    add(extension);
  }

  /// Returns the extension with the given URI, or null
  FhirExtension? extensionOrNull(Object? key) {
    if (key == null) {
      return null;
    }

    if (key is String) {
      return firstWhereOrNull((ext) {
        return ext.url == FhirUri(key);
      });
    } else if (key is FhirUri) {
      return firstWhereOrNull((ext) {
        return ext.url == key;
      });
    } else {
      throw ArgumentError.value(
          key, 'key', 'Only String and FhirUri are supported as key.');
    }
  }
}

extension FDashListExtension<T> on List<T> {
  /// The first element of a list, or null if it is empty
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}
