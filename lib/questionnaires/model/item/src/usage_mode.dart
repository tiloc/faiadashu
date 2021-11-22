import 'package:fhir/r4.dart';

import '../../../../fhir_types/fhir_types.dart';

final usageModeExtensionUrl =
    FhirUri('http://hl7.org/fhir/StructureDefinition/questionnaire-usageMode');

final usageModeSystem =
    FhirUri('http://hl7.org/fhir/ValueSet/questionnaire-usage-mode');

/// Render the item regardless of usage mode.
final usageModeCaptureDisplay = Coding(
  code: usageModeCaptureDisplayCode,
  display: 'Capture & Display',
  system: usageModeSystem,
);

const usageModeCaptureDisplayCode = Code.asConst('capture-display');

/// Render the item only when capturing data.
final usageModeCapture = Coding(
  code: usageModeCaptureCode,
  display: 'Capture Only',
  system: usageModeSystem,
);

const usageModeCaptureCode = Code.asConst('capture');

/// Render the item only when displaying data.
final usageModeDisplay = Coding(
  code: usageModeDisplayCode,
  display: 'Display Only',
  system: usageModeSystem,
);

const usageModeDisplayCode = Code.asConst('display');

/// Render the item only when displaying a completed form and the item has been answered (or has child items that have been answered).
final usageModeDisplayNonEmpty = Coding(
  code: usageModeDisplayNonEmptyCode,
  display: 'Display when Answered',
  system: usageModeSystem,
);

const usageModeDisplayNonEmptyCode = Code.asConst('display-non-empty');

/// Render the item when capturing data or when displaying a completed form and the item has been answered (or has child items that have been answered).
final usageModeCaptureDisplayNonEmpty = Coding(
  code: usageModeCaptureDisplayNonEmptyCode,
  display: 'Capture or, if answered, Display',
  system: usageModeSystem,
);

const usageModeCaptureDisplayNonEmptyCode =
    Code.asConst('capture-display-non-empty');

extension UsageModeExtension on List<FhirExtension> {
  Code? get usageMode {
    return extensionOrNull(usageModeExtensionUrl)?.valueCode;
  }
}
