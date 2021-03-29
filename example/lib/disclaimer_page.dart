import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class DisclaimerPage extends ExhibitPage {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return const Text(
        '''Flutter and the related logo are trademarks of Google LLC. We are not endorsed by or affiliated with Google LLC.

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health Level Seven International and their use does not constitute endorsement by HL7.

This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc.

This product includes all or a portion of the UCUM table, UCUM codes, and UCUM definitions or is derived from it, subject to a license from Regenstrief Institute, Inc. and The UCUM Organization. Your use of the UCUM table, UCUM codes, UCUM definitions also is subject to this license, a copy of which is available at http://unitsofmeasure.org. The current complete UCUM table, UCUM Specification are available for download at http://unitsofmeasure.org. The UCUM table and UCUM codes are copyright © 1995-2020, Regenstrief Institute, Inc. and the Unified Codes for Units of Measures (UCUM) Organization. All rights reserved. THE UCUM TABLE (IN ALL FORMATS), UCUM DEFINITIONS, AND SPECIFICATION ARE PROVIDED "AS IS". ANY EXPRESS OR IMPLIED WARRANTIES ARE DISCLAIMED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
    
This material contains the following artwork: 
"Sectional Anatomy of the Heart with Path of Blood Flow" - licensed from Blausen Medical Communications, Inc. under the Creative Commons Attribution 3.0 Unported license (https://creativecommons.org/licenses/by/3.0/deed.en)
    ''');
  }

  @override
  String get title => 'Faiadashu™ Disclaimers';
}
