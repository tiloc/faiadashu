import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Uploads a [QuestionnaireResponse] to a server.
Future<Id?> uploadQuestionnaireResponse(
  FhirClient fhirClient,
  QuestionnaireResponse resource,
) async {
  final _logger = Logger.tag('server_uploader');

  try {
    await fhirClient.initialize();
  } catch (e) {
    _logger.warn('Could not initialize.', error: e);
    rethrow;
  }

  _logger.debug(
    '${resource.resourceTypeString()} to be uploaded:\n${resource.toJson()}',
  );
  final request1 = FhirRequest.create(
    base: fhirClient.fhirUri!.value!,
    resource: resource,
    fhirClient: fhirClient,
  );

  try {
    final response1 = await request1.request();
    _logger.debug('Response from upload:\n${response1?.toJson()}');

    return response1?.id;
  } catch (e) {
    _logger.warn('Upload failed', error: e);
    rethrow;
  }
}
