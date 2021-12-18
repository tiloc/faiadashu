import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/r4.dart';
import 'package:intl/intl.dart';

extension FDashTimeExtension on Time {
  String format(Locale locale, {String defaultText = ''}) {
    final localeCode = locale.toString();
    if (!isValid) {
      return defaultText;
    }

    return DateFormat.jm(localeCode)
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
    final japanese = locale.languageCode == 'ja';
    switch (precision) {
      case DateTimePrecision.INVALID:
        return defaultText;
      case DateTimePrecision.FULL:
        dateFormat = (!japanese)
            ? DateFormat.yMd(localeCode).add_jm()
            : DateFormat('y年M月d日', localeCode).add_jm();
        break;
      case DateTimePrecision.YYYY:
        dateFormat = (!japanese)
            ? DateFormat.y(localeCode)
            : DateFormat('y年', localeCode);
        break;
      case DateTimePrecision.YYYYMM:
        dateFormat = (!japanese)
            ? DateFormat.yM(localeCode)
            : DateFormat('y年M月', localeCode);
        break;
      case DateTimePrecision.YYYYMMDD:
        dateFormat = (!japanese)
            ? DateFormat.yMd(localeCode)
            : DateFormat('y年M月d日', localeCode);
        break;
    }

    return dateFormat.format(value!);
  }
}

extension FDashDecimalExtension on Decimal {
  static final _logger = Logger(Decimal);

  String format(Locale locale) {
    if (!isValid) {
      return toString();
    }

    try {
      final decimalFormat = NumberFormat.decimalPattern(locale.toString());

      return decimalFormat.format(value);
    } catch (exception) {
      _logger.warn('Cannot format $this', error: exception);
      rethrow;
    }
  }
}

extension FDashQuantityExtension on Quantity {
  String format(
    Locale locale, {
    String defaultText = '',
    String unknownValueText = '?',
  }) {
    final value = this.value;
    final unit = this.unit;

    return value == null
        ? unit == null
            ? defaultText
            : '$unknownValueText $unit'
        : unit == null
            ? value.format(locale)
            : '${value.format(locale)} $unit';
  }

  // Returns whether this [Quantity] has a specified unit.
  bool get hasUnit {
    return code != null && unit != null;
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
    final codeValue = code?.value;
    final otherCodeValue = otherCoding.code?.value;

    if (system != otherCoding.system) {
      return false;
    }

    if (codeValue == otherCodeValue) {
      return true;
    }

    return codeValue != null &&
        otherCodeValue != null &&
        codeValue.toUpperCase() == otherCodeValue.toUpperCase();
  }

  /// Localized access to display value.
  /// TODO: Currently only matches by language.
  String localizedDisplay(Locale locale) {
    // TODO: Carve this out to be used in other places (titles).
    final translationExtension = displayElement?.extension_?.firstWhereOrNull(
      (transExt) =>
          transExt.url ==
              FhirUri('http://hl7.org/fhir/StructureDefinition/translation') &&
          transExt.extension_?.firstWhereOrNull(
                (ext) =>
                    (ext.url == FhirUri('lang')) &&
                    (ext.valueCode?.value == locale.languageCode),
              ) !=
              null,
    );

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
    return coding?.firstWhereOrNull(
          (_coding) =>
              (_coding.code?.toString() == code) &&
              (_coding.system?.toString() == system),
        ) !=
        null;
  }
}

extension FDashPatientExtension on Patient {
  /// Returns a [Reference] to the [Patient].
  ///
  /// Only returns a reference when id is present.
  Reference? get reference {
    if (id == null) {
      return null;
    }

    return Reference(type: FhirUri('Patient'), reference: 'Patient/$id');
  }
}

/// Access to [FhirExtension]s from a List.
///
/// Mimics a [Map] with String?/FhirUri as the key and FhirExtension as value.
/// Extensions are treated similar to a [Set]: Only one of each type can exist  TODO: Should it be like that???
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
      throw ArgumentError.value(
        key,
        'key',
        'Only FhirExtension, String and FhirUri are supported as key.',
      );
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
        key,
        'key',
        'Only String and FhirUri are supported as key.',
      );
    }
  }
}

extension FDashListExtension<T> on List<T> {
  /// The first element of a list, or null if it is empty
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}
