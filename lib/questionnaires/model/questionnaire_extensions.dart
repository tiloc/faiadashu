import 'dart:ui';

import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4.dart';

import '../../fhir_types/fhir_types_extensions.dart';

extension FDashQuestionnaireAnswerOptionExtensions
    on QuestionnaireAnswerOption {
  /// Returns localized display value.
  String localizedDisplay(Locale locale) {
    return valueString ?? valueCoding?.localizedDisplay(locale) ?? toString();
  }

  /// The coded value for the option, taken from either valueString or valueCoding
  String get optionCode {
    if (valueString == null && valueCoding == null) {
      throw QuestionnaireFormatException(
          'QuestionnaireAnswerOption requires either a valueString or a valueCoding.',
          this);
    }
    return valueString ?? valueCoding!.code.toString();
  }

  static QuestionnaireAnswerOption fromCoding(Coding coding,
      {List<FhirExtension>? Function(Coding)? extensionBuilder,
      List<FhirExtension>? Function(Coding)? codingExtensionBuilder,
      bool userSelected = true}) {
    return QuestionnaireAnswerOption(
        extension_: extensionBuilder?.call(coding),
        valueCoding: coding.copyWith(
            // TODO: swap out display for a localized display?
            userSelected: Boolean(userSelected),
            extension_: codingExtensionBuilder?.call(coding)));
  }
}

extension FDashQuestionnaireItemExtension on QuestionnaireItem {
  bool isItemControl(String itemControl) {
    return extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl')
            ?.valueCodeableConcept
            ?.containsCoding('http://hl7.org/fhir/questionnaire-item-control',
                itemControl) ??
        false;
  }

  /// Unit from SDC 'questionnaire-unit' extension.
  Coding? get unit {
    return extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-unit')
        ?.valueCoding;
  }
}
