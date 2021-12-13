import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class CodeableConceptText extends StatelessWidget {
  final CodeableConcept codeableConcept;
  final TextStyle? style;
  final Locale? locale;

  const CodeableConceptText(
    this.codeableConcept, {
    this.style,
    this.locale,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      codeableConcept
          .localizedDisplay(locale ?? Localizations.localeOf(context)),
      style: style,
    );
  }
}
