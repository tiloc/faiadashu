import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/primitive_types/primitive_types.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Uploads a [QuestionnaireResponse] to a server.
Future<Id?> uploadQuestionnaireResponse(
    SmartClient smartClient, QuestionnaireResponse resource) async {
  final _logger = Logger.tag('server_uploader');

  try {
    // TODO: Should login be part of the upload? Or should the client already be logged in?
    if (!smartClient.isLoggedIn) await smartClient.login();
  } catch (e) {
    _logger.warn('Could not authenticate.', error: e);
    rethrow;
  }

  _logger.debug(
      '${resource.resourceTypeString()} to be uploaded:\n${resource.toJson()}');
  final request1 = FhirRequest.create(
    base: smartClient.fhirUrl.value!,
    resource: resource,
  );

  try {
    final response1 =
        await request1.request(headers: await smartClient.authHeaders);
    _logger.debug('Response from upload:\n${response1?.toJson()}');

    return response1?.id;
  } catch (e) {
    _logger.warn('Upload failed', error: e);
    rethrow;
  }
}
