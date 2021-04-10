import 'dart:ui';

import 'package:fhir/r4.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../questionnaire_location.dart';

/// Validates a [QuestionnaireResponseItem].
abstract class ItemModel<T> {
  final QuestionnaireLocation location;
  final Locale locale;

  QuestionnaireItem get qi => location.questionnaireItem;

  /// Returns the human-readable entry format.
  ///
  /// See: http://hl7.org/fhir/R4/extension-entryformat.html
  String? get entryFormat {
    return qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/entryFormat')
        ?.valueString;
  }

  ItemModel(this.location) : locale = location.top.locale;

  /// Returns null when [inValue] is valid, or a localized message when it is not.
  String? validate(T? inValue);
}
