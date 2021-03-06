import 'package:fhir/r4.dart';

extension SafeDisplayQuestionnaireAnswerOptionExtensions
    on QuestionnaireAnswerOption {
  String get safeDisplay {
    return valueCoding?.safeDisplay ?? toString();
  }
}

extension SafeDisplayCodingExtensions on Coding {
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

extension SafeDisplayCodeableConceptExtension on CodeableConcept {
  String get safeDisplay {
    return coding?.firstOrNull?.display ??
        text ??
        coding?.firstOrNull?.code?.value ??
        toString();
  }
}

extension FirstOrNullExtension<T> on List<T> {
  /// The first element of a list, or null if it is empty
  T? get firstOrNull {
    return isEmpty ? null : first;
  }
}
