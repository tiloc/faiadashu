import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// A [Text] widget built from a [FhirDateTime].
/// Takes the precision and locale into account.
class FhirDateTimeText extends StatelessWidget {
  final FhirDateTime? dateTime;
  final TextStyle? style;
  final String defaultText;
  final Locale? locale;
  const FhirDateTimeText(
    this.dateTime, {
    this.style,
    this.defaultText = '',
    this.locale,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime?.format(locale ?? Localizations.localeOf(context)) ??
          defaultText,
      style: style,
    );
  }
}
