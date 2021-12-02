import 'package:faiabench/fhir_resource.dart';

class FillerInputs {
  final FhirResource questionnaire;
  final FhirResource? questionnaireResponse;
  final FhirResource launchContext;

  const FillerInputs(
      this.questionnaire, this.questionnaireResponse, this.launchContext);
}
