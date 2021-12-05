import 'package:faiadashu/resource_provider/resource_provider.dart'
    show FhirResourceProvider;
import 'package:fhir/r4.dart';
import 'package:fhir_auth/r4.dart';

/// Provide resources from open or secured FHIR servers.
class RestfulResourceProvider extends FhirResourceProvider {
  late final Resource? resource;
  final String uri;
  final R4ResourceType resourceType;
  final Id id;
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
    await client.initialize(); // Is .initialize() idempotent???

    final request = FhirRequest.read(
      base: client.fhirUri!.value!,
      type: resourceType,
      id: id,
      fhirClient: client,
    );
    resource = await request.request();

    return;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    return (this.uri == uri) ? this : null;
  }
}
