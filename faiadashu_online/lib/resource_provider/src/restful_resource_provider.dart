import 'package:faiadashu/resource_provider/resource_provider.dart'
    show FhirResourceProvider;
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Provide resources from open or secured FHIR servers.
class RestfulResourceProvider extends FhirResourceProvider {
  late final Resource? resource;
  final String uri;
  final R4ResourceType resourceType;
  final String id;
  FhirClient client;

  RestfulResourceProvider(
    this.uri,
    this.resource,
    this.resourceType,
    this.id,
    this.client,
  );

  @override
  Resource? getResource(String uri) {
    return (uri == this.uri) ? resource : null;
  }

  @override
  Future<void> init() async {
    final request = FhirRequest.read(
      base: client.fhirUri.value!,
      type: resourceType,
      id: id,
      client: client,
    );
    resource = await request.request();

    return;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    return (this.uri == uri) ? this : null;
  }
}
