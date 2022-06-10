import 'package:faiadashu/resource_provider/resource_provider.dart';

// Build up a registry of ValueSets and CodeSystems which are being referenced
// in the questionnaires.
//
// It is typically *NOT* possible to resolve value sets through their URI, as
// these do not point to real web-servers.
//
// This mechanism allows to add them from other sources.
final valueSetProvider = AssetResourceProvider.fromMap(<String, String>{
  'http://hl7.org/fhir/ValueSet/administrative-gender':
  'assets/valuesets/fhir_valueset_administrative_gender.json',
  'http://hl7.org/fhir/administrative-gender':
  'assets/codesystems/fhir_codesystem_administrative_gender.json',
  'http://hl7.org/fhir/ValueSet/ucum-bodyweight':
  'assets/valuesets/ucum_bodyweight.json',
  'http://hl7.org/fhir/ValueSet/iso3166-1-2':
  'assets/valuesets/fhir_valueset_iso3166_1_2.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetYesNoUnk':
  'assets/valuesets/who_cr_valueset_yes_no_unknown.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetSexAtBirth':
  'assets/valuesets/who_cr_valueset_sex_at_birth.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetAgeUnits':
  'assets/valuesets/who_cr_valueset_age_units.json',
  'http://loinc.org/vs/LL715-4': 'assets/valuesets/loinc_ll715_4.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetPregnancyTrimester':
  'assets/valuesets/who_cr_valueset_pregnancy_trimester.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetAdmin1':
  'assets/valuesets/who_cr_valueset_admin_1.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetPatientOutcome':
  'assets/valuesets/who_cr_valueset_patient_outcome.json',
  'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetTestResult':
  'assets/valuesets/who_cr_valueset_test_result.json',
  'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemPatientOutcome':
  'assets/codesystems/who_cr_codesystem_patient_outcome.json',
  'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemPregnancyTrimester':
  'assets/codesystems/who_cr_codesystem_pregnancy_trimester.json',
  'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemQuestionnaireChoice':
  'assets/codesystems/who_cr_codesystem_questionnaire_choice.json',
  'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemReasonForTesting':
  'assets/codesystems/who_cr_codesystem_reason_for_testing.json',
  'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemComorbidity':
  'assets/codesystems/who_cr_codesystem_comorbidity.json',
});
