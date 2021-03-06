import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir_example/exhibit_page.dart';

class DisclaimerPage extends ExhibitPage {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return const Text('''
          Flutter and the related logo are trademarks of Google LLC. We are not endorsed by or affiliated with Google LLC.

      HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health Level Seven International and their use does not constitute endorsement by HL7.

    This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc.
    ''');
  }

  @override
  String get title => 'Widgets on FHIR® Disclaimers';
}
