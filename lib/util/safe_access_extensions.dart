import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';

extension SafeDisplayQuestionnaireAnswerOptionExtensions
    on QuestionnaireAnswerOption {
  /// A safeguarded way to get a display value
  String get safeDisplay {
    return valueString ?? valueCoding?.safeDisplay ?? toString();
  }

  /// The coded value for the option, take from either valueString or valueCoding
  String get optionCode {
    return valueString ?? valueCoding!.code.toString();
  }
}

extension SafeDisplayCodingExtensions on Coding {
  /// A safeguarded way to get a display value
  String get safeDisplay {
    return display ?? code?.value ?? toString();
  }
}

extension SafeDisplayListCodingExtensions on List<Coding> {
  /// A safeguarded way to get a display value or empty string
  String get safeDisplay {
    if (isEmpty) return '';
    return first.safeDisplay;
  }
}

extension SafeCodeableConceptExtension on CodeableConcept {
  /// A safeguarded way to get a display value
  String get safeDisplay {
    return coding?.firstOrNull?.display ??
        text ??
        coding?.firstOrNull?.code?.value ??
        toString();
  }

  String get firstCode {
    return ArgumentError.checkNotNull(coding?.firstOrNull?.code?.value);
  }
}

extension ExtensionOrNullExtension on List<FhirExtension> {
  /// The extension with the given URI, or null
  FhirExtension? extensionOrNull(String uri) {
    return firstWhereOrNull((ext) {
      return ext.url == FhirUri(uri);
    });
  }
}

extension FirstOrNullExtension<T> on List<T> {
  /// The first element of a list, or null if it is empty
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}
