import 'dart:convert';

import 'package:fhir/r4.dart';

const emptyFhirResource = FhirResource(null, '');

class FhirResource {
  final Resource? _resource;
  final String _jsonString;

  final String? errorMessage;

  String get jsonString => _jsonString;
  Resource? get resource => _resource;
  bool get hasError => errorMessage != null;

  const FhirResource(Resource? resource, String jsonString, {this.errorMessage})
      : _resource = resource,
        _jsonString = jsonString;

  factory FhirResource.fromResource(Resource resource) {
    return FhirResource(
      resource,
      const JsonEncoder.withIndent('    ').convert(resource.toJson()),
    );
  }

  factory FhirResource.fromJsonString(String jsonString) {
    try {
      final resource = Resource.fromJson(jsonDecode(jsonString));

      return FhirResource(
        resource,
        jsonString,
      );
    } catch (ex) {
      return FhirResource(null, jsonString, errorMessage: ex.toString());
    }
  }
}
