import 'package:fhir/r4.dart';
import 'package:meta/meta.dart';

/// The standard context for Questionnaire at launch time
@immutable
class LaunchContext {
  final Patient? patient;
  final Location? location;
  final Encounter? encounter;
  final Resource? user;

  const LaunchContext({this.patient, this.location, this.encounter, this.user});
}
