import 'package:fhir/r4.dart';

import '../../../faiadashu.dart';
import '../../../fhir_types/fhir_types.dart';

extension FDashQuestionnaireItemExtension on QuestionnaireItem {
  FhirExtension? get itemControl {
    return extension_?.extensionOrNull(
      'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl',
    );
  }

  bool get isNoItemControl {
    return itemControl == null;
  }

  bool isItemControl(String itemControlCode) {
    return itemControl?.valueCodeableConcept?.containsCoding(
          'http://hl7.org/fhir/questionnaire-item-control',
          itemControlCode,
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
