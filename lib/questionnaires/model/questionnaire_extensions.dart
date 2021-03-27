import 'package:fhir/r4.dart';

import '../../fhir_types/fhir_types_extensions.dart';

extension SafeQuestionnaireAnswerOptionExtensions on QuestionnaireAnswerOption {
  /// A safeguarded way to get a display value
  String get safeDisplay {
    return valueString ?? valueCoding?.safeDisplay ?? toString();
  }

  /// The coded value for the option, taken from either valueString or valueCoding
  String get optionCode {
    return valueString ?? valueCoding!.code.toString();
  }
}

extension SafeQuestionnaireItemExtension on QuestionnaireItem {
  bool isItemControl(String itemControl) {
    return extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl')
            ?.valueCodeableConcept
            ?.containsCoding('http://hl7.org/fhir/questionnaire-item-control',
                itemControl) ??
        false;
  }
}
