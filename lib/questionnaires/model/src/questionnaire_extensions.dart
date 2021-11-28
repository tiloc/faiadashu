import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4.dart';

import '../../../fhir_types/fhir_types.dart';

extension FDashQuestionnaireItemExtension on QuestionnaireItem {
  bool get isNoItemControl {
    return extension_?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl',
        ) ==
        null;
  }

  bool isItemControl(String itemControl) {
    return extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl',
            )
            ?.valueCodeableConcept
            ?.containsCoding(
              'http://hl7.org/fhir/questionnaire-item-control',
              itemControl,
            ) ??
        false;
  }

  /// Unit from SDC 'questionnaire-unit' extension.
  Coding? get unit {
    return extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-unit',
        )
        ?.valueCoding;
  }
}
