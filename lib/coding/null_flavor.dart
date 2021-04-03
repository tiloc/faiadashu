import 'package:fhir/r4.dart';

// ignore: avoid_classes_with_only_static_members
class NullFlavor {
  static final system =
      FhirUri('http://terminology.hl7.org/CodeSystem/v3-NullFlavor');

  /// There is information on this item available but it has not been provided by the sender due to security, privacy or other reasons.
  static final masked = Coding(
      code: const Code.asConst('MSK'), display: 'masked', system: system);

  /// This information has not been sought (e.g., patient was not asked)
  static final notAsked = Coding(
      code: const Code.asConst('NASK'), display: 'not asked', system: system);

  /// Information was sought but not found (e.g., patient was asked but didn't know)
  static final askedButUnknown = Coding(
      code: const Code.asConst('ASKU'),
      display: 'asked but unknown',
      system: system);

  /// Information is not available at this time but it is expected that it will be available later.
  static final temporarilyUnavailable = Coding(
      code: const Code.asConst('NAV'),
      display: 'temporarily unavailable',
      system: system);

  /// Description:The value as represented in the instance is not a member of the set of permitted data values in the constrained value domain of a variable.
  static final invalid = Coding(
      code: const Code.asConst('INV'), display: 'invalid', system: system);

  /// Description: The actual value has not yet been encoded within the approved value domain.
  static final unencoded = Coding(
      code: const Code.asConst('UNC'), display: 'un-encoded', system: system);

  /// Description:The actual value is not a member of the set of permitted data values in the constrained value domain of a variable. (e.g., concept not provided by required code system).
  static final other =
      Coding(code: const Code.asConst('OTH'), display: 'other', system: system);
}
