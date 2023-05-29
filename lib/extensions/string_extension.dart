import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:fhir/primitive_types/fhir_uri.dart';
import 'package:fhir/r4/basic_types/fhir_extension.dart';

extension StringExtension on String {
  String translate(List<FhirExtension>? extensions, Locale? locale) {
    final translationExtension = extensions?.firstWhereOrNull(
      (transExt) =>
          transExt.url ==
              FhirUri('http://hl7.org/fhir/StructureDefinition/translation') &&
          transExt.extension_?.firstWhereOrNull(
                (ext) =>
                    (ext.url == FhirUri('lang')) &&
                    (ext.valueCode?.value == locale?.languageCode),
              ) !=
              null,
    );
    return translationExtension?.extension_
            ?.extensionOrNull('content')
            ?.valueString ??
        this;
  }
}
