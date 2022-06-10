import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';


/// Creates or updates a [QuestionnaireResponse] on the server.
///
/// Returns the [QuestionnaireResponse] with the server-side [Id].
Future<QuestionnaireResponse> createOrUpdateQuestionnaireResponse(
  FhirClient client,
  QuestionnaireResponse questionnaireResponse,
) async {
  final _logger = Logger.tag('server_uploader');

  final baseUri = ArgumentError.checkNotNull(client.fhirUri.value);

  _logger.debug(
    '${questionnaireResponse.resourceTypeString} to be uploaded:\n${questionnaireResponse.toJson()}',
  );

  // Select whether update or create scenario applies
  final serverRequest = questionnaireResponse.id == null ? FhirRequest.create(
    base: baseUri,
    resource: questionnaireResponse,
    client: client,
  ) : FhirRequest.update(
    base: baseUri,
    resource: questionnaireResponse,
    client: client,
  );

  try {
    final serverResponse = await serverRequest.request();
    _logger.debug('Response from server:\n${serverResponse.toJson()}');

    if (serverResponse is QuestionnaireResponse) {
      return serverResponse;
    } else if (serverResponse is OperationOutcome) {
      throw serverResponse;
    } else {
      throw Exception('Unexpected response from server:\n${serverResponse.toJson()}');
    }
  } catch (e) {
    _logger.warn('Upload failed', error: e);
    rethrow;
  }
}
