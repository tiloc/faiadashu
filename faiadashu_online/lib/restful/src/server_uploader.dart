import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/primitive_types/primitive_types.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Uploads a [QuestionnaireResponse] to a server.
Future<void> uploadQuestionnaireResponse(QuestionnaireResponse resource) async {
  // TODO: Should this return the ID, rather than void?
  final _logger = Logger.tag('server_uploader');

  // TODO: Move hard-coded server info to API and example.
  final client = SmartClient(
    fhirUrl: FhirUri('https://api.logicahealth.org/faiadashu/data'),
    clientId: '9f03822a-e4ca-4ea6-aaa3-107661bd86a4',
    redirectUri: FhirUri('com.example.example://callback'),
    scopes: Scopes(
      clinicalScopes: [
        ClinicalScope(
          Role.patient,
          R4ResourceType.Patient,
          Interaction.any,
        ),
        ClinicalScope(
          Role.patient,
          R4ResourceType.QuestionnaireResponse,
          Interaction.any,
        ),
      ],
      openid: true,
      offlineAccess: true,
    ),
  );

  try {
    await client.login();
  } catch (e) {
    _logger.warn('Could not authenticate.', error: e);
    rethrow;
  }

  _logger.debug(
      '${resource.resourceTypeString()} to be uploaded:\n${resource.toJson()}');
  final request1 = FhirRequest.create(
    base: client.fhirUrl.value!,
    resource: resource,
  );

  try {
    final response1 = await request1.request(headers: await client.authHeaders);
    _logger.debug('Response from upload:\n${response1?.toJson()}');
  } catch (e) {
    _logger.warn('Upload failed', error: e);
    rethrow;
  }
}
