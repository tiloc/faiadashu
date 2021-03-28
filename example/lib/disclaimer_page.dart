import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class DisclaimerPage extends ExhibitPage {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return const Text('''
          Flutter and the related logo are trademarks of Google LLC. We are not endorsed by or affiliated with Google LLC.

      HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health Level Seven International and their use does not constitute endorsement by HL7.

    This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc.
    
    This material contains the following artwork: 
    "Sectional Anatomy of the Heart with Path of Blood Flow" - licensed from Blausen Medical Communications, Inc. under the Creative Commons Attribution 3.0 Unported license (https://creativecommons.org/licenses/by/3.0/deed.en)
    ''');
  }

  @override
  String get title => 'Fire Dash Disclaimers';
}
