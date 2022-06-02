import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Uploads a [QuestionnaireResponse] to a server.
Future<Id?> uploadQuestionnaireResponse(
  FhirClient client,
  QuestionnaireResponse resource,
) async {
  final _logger = Logger.tag('server_uploader');

  _logger.debug(
    '${resource.resourceTypeString} to be uploaded:\n${resource.toJson()}',
  );
  final request1 = FhirRequest.create(
    base: client.fhirUri.value!,
    resource: resource,
    client: client,
  );

  try {
    final response1 = await request1.request();
    _logger.debug('Response from upload:\n${response1.toJson()}');

    return response1.id;
  } catch (e) {
    _logger.warn('Upload failed', error: e);
    rethrow;
  }
}
