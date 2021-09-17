import 'package:faiadashu/resource_provider/resource_provider.dart'
    show FhirResourceProvider;
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Provide resources from open or secured FHIR servers.
class RestfulResourceProvider extends FhirResourceProvider {
  late final Resource? resource;
  final String uri;
  final Uri fhirServer;
  final R4ResourceType resourceType;
  final Id id;
  FhirClient? client;

  RestfulResourceProvider.open(
    this.uri,
    this.resource,
    this.fhirServer,
    this.resourceType,
    this.id,
  );

  RestfulResourceProvider.secure(
    this.uri,
    this.resource,
    this.fhirServer,
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
    final request =
        FhirRequest.read(base: fhirServer, type: resourceType, id: id);
    resource = await request.request(
      headers: client == null
          ? {'Content-Type': 'application/fhir+json'}
          : await client!.authHeaders,
    );
    return;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    return (this.uri == uri) ? this : null;
  }
}
