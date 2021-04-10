import 'dart:ui';

import 'package:fhir/r4.dart';

import '../questionnaire_location.dart';

/// Validates a [QuestionnaireResponseItem].
abstract class Validator<T> {
  final QuestionnaireLocation location;
  final Locale locale;

  QuestionnaireItem get qi => location.questionnaireItem;

  Validator(this.location) : locale = location.top.locale;

  /// Returns null when [inValue] is valid, or a localized message when it is not.
  String? validate(T? inValue);
}
