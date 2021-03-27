import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:intl/intl.dart';

extension WoFDateTimeExtension on FhirDateTime {
  String format(Locale locale, {String defaultText = ''}) {
    final languageCode = locale.languageCode;
    if (precision != DateTimePrecision.INVALID) {
      final DateFormat dateFormat;
      switch (precision) {
        case DateTimePrecision.FULL:
        case DateTimePrecision.INVALID:
          dateFormat = DateFormat.yMd(languageCode).add_jms();
          break;
        case DateTimePrecision.YYYY:
          dateFormat = DateFormat.y(languageCode);
          break;
        case DateTimePrecision.YYYYMM:
          dateFormat = DateFormat.yM(languageCode);
          break;
        case DateTimePrecision.YYYYMMDD:
          dateFormat = DateFormat.yMd(languageCode);
          break;
      }
      return dateFormat.format(value!);
    } else {
      return defaultText;
    }
  }
}

extension WoFCodingExtension on Coding {
  /// A safeguarded way to get a display value
  String get safeDisplay {
    return display ?? code?.value ?? toString();
  }
}

extension WoFListCodingExtension on List<Coding> {
  /// A safeguarded way to get a display value or empty string
  String get safeDisplay {
    if (isEmpty) return '';
    return first.safeDisplay;
  }
}

extension WoFCodeableConceptExtension on CodeableConcept {
  /// A safeguarded way to get a display value
  String get safeDisplay {
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

extension WoFListFhirExtensionExtension on List<FhirExtension> {
  /// The extension with the given URI, or null
  FhirExtension? extensionOrNull(String uri) {
    return firstWhereOrNull((ext) {
      return ext.url == FhirUri(uri);
    });
  }
}

extension WoFListExtension<T> on List<T> {
  /// The first element of a list, or null if it is empty
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}
