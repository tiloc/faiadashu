import 'package:fhir/r4.dart';

import '../fhir_types/fhir_types_extensions.dart';

final dataAbsentReasonExtension =
    FhirUri('http://hl7.org/fhir/StructureDefinition/data-absent-reason');

final dataAbsentReasonSystem =
    FhirUri('http://hl7.org/fhir/ValueSet/data-absent-reason');

/// There is information on this item available but it has not been provided by the sender due to security, privacy or other reasons.
final dataAbsentReasonMasked = Coding(
    code: dataAbsentReasonMaskedCode,
    display: 'Masked',
    system: dataAbsentReasonSystem);

const dataAbsentReasonMaskedCode = Code.asConst('masked');

/// This information has not been sought (e.g., patient was not asked)
final dataAbsentReasonNotAsked = Coding(
    code: dataAbsentReasonNotAskedCode,
    display: 'Not Asked',
    system: dataAbsentReasonSystem);

const dataAbsentReasonNotAskedCode = Code.asConst('not-asked');

/// Information was sought but not found (e.g., patient was asked but didn't know)
final dataAbsentReasonAskedButUnknown = Coding(
    code: dataAbsentReasonAskedButUnknownCode,
    display: 'Asked But Unknown',
    system: dataAbsentReasonSystem);

const dataAbsentReasonAskedButUnknownCode = Code.asConst('asked-unknown');

/// The source was asked but declined to answer.
final dataAbsentReasonAskedButDeclined = Coding(
    code: dataAbsentReasonAskedButDeclinedCode,
    display: 'Asked But Declined',
    system: dataAbsentReasonSystem);

const dataAbsentReasonAskedButDeclinedCode = Code.asConst('asked-declined');

/// Information is not available at this time but it is expected that it will be available later.
final dataAbsentReasonTemporarilyUnknown = Coding(
    code: dataAbsentReasonTempUnknownCode,
    display: 'Temporarily Unknown',
    system: dataAbsentReasonSystem);

const dataAbsentReasonTempUnknownCode = Code.asConst('temp-unknown');

const dataAbsentReasonAsTextCode = Code.asConst('as-text');

/// The content of the data is represented in the resource narrative.
///
/// It may be linked by internal references (e.g. xml:id).
/// This usually implies that the value could not be represented in the correct format -
/// this may be due to system limitations, or this particular data value.
final dataAbsentReasonAsText = Coding(
    code: dataAbsentReasonAsTextCode,
    display: 'As Text',
    system: dataAbsentReasonSystem);

extension DataAbsentReasonExtension on List<FhirExtension> {
  Code? get dataAbsentReason {
    return extensionOrNull(dataAbsentReasonExtension)?.valueCode;
  }
}
