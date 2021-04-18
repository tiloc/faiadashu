import 'package:fhir/r4.dart';

import '../fhir_types/fhir_types_extensions.dart';

// ignore: avoid_classes_with_only_static_members
class DataAbsentReason {
  static final extensionUrl =
      FhirUri('http://hl7.org/fhir/StructureDefinition/data-absent-reason');

  static final systemUri =
      FhirUri('http://hl7.org/fhir/ValueSet/data-absent-reason');

  /// There is information on this item available but it has not been provided by the sender due to security, privacy or other reasons.
  static final masked =
      Coding(code: maskedCode, display: 'Masked', system: systemUri);

  static const maskedCode = Code.asConst('masked');

  /// This information has not been sought (e.g., patient was not asked)
  static final notAsked =
      Coding(code: notAskedCode, display: 'Not Asked', system: systemUri);

  static const notAskedCode = Code.asConst('not-asked');

  /// Information was sought but not found (e.g., patient was asked but didn't know)
  static final askedButUnknown = Coding(
      code: askedButUnknownCode,
      display: 'Asked But Unknown',
      system: systemUri);

  static const askedButUnknownCode = Code.asConst('asked-unknown');

  /// The source was asked but declined to answer.
  static final askedButDeclined = Coding(
      code: askedButDeclinedCode,
      display: 'Asked But Declined',
      system: systemUri);

  static const askedButDeclinedCode = Code.asConst('asked-declined');

  /// Information is not available at this time but it is expected that it will be available later.
  static final temporarilyUnknown = Coding(
      code: tempUnknownCode, display: 'Temporarily Unknown', system: systemUri);

  static const tempUnknownCode = Code.asConst('temp-unknown');

  static const asTextCode = Code.asConst('as-text');

  /// The content of the data is represented in the resource narrative.
  ///
  /// It may be linked by internal references (e.g. xml:id).
  /// This usually implies that the value could not be represented in the correct format -
  /// this may be due to system limitations, or this particular data value.
  static final asText =
      Coding(code: asTextCode, display: 'As Text', system: systemUri);
}

extension DataAbsentReasonExtension on List<FhirExtension> {
  Code? get dataAbsentReason {
    return extensionOrNull(DataAbsentReason.extensionUrl)?.valueCode;
  }
}
