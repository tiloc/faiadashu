import 'package:fhir/r4.dart';

/// The standard context for Questionnaire at launch time
class LaunchContext {
  final Patient? patient;
  final Location? location;
  final Encounter? encounter;
  final Resource? user;

  const LaunchContext({this.patient, this.location, this.encounter, this.user});
}
