import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import 'fhir_types_extensions.dart';

/// A [Text] widget built from a FhirDateTime.
/// Takes the precision and locale into account.
class FhirDateTimeWidget extends StatelessWidget {
  final FhirDateTime? dateTime;
  final TextStyle? style;
  final String defaultText;
  const FhirDateTimeWidget(this.dateTime,
      {this.style, this.defaultText = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        dateTime?.format(Localizations.localeOf(context)) ?? defaultText,
        style: style);
  }
}
