import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';


/// Creates or updates a [QuestionnaireResponse] on the server.
///
/// Returns the [QuestionnaireResponse] with the server-side [Id].
Future<QuestionnaireResponse> createOrUpdateQuestionnaireResponse(
  FhirClient client,
  QuestionnaireResponse resource,
) async {
  // TODO: Implement update path
  final _logger = Logger.tag('server_uploader');

  _logger.debug(
    '${resource.resourceTypeString} to be uploaded:\n${resource.toJson()}',
  );
  final createRequest = FhirRequest.create(
    base: client.fhirUri.value!,
    resource: resource,
    client: client,
  );

  try {
    final createResponse = await createRequest.request();
    _logger.debug('Response from upload:\n${createResponse.toJson()}');

    return createResponse as QuestionnaireResponse;
  } catch (e) {
    _logger.warn('Upload failed', error: e);
    rethrow;
  }
}
