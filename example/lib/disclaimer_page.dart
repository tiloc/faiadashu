import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class DisclaimerPage extends ExhibitPage {
  const DisclaimerPage({super.key});

  @override
  Widget buildExhibit(BuildContext context) {
    return const Text(
      '''
Flutter and the related logo are trademarks of Google LLC. We are not endorsed by or affiliated with Google LLC.

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health Level Seven International and their use does not constitute endorsement by HL7.

This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc.

This product includes all or a portion of the UCUM table, UCUM codes, and UCUM definitions or is derived from it, subject to a license from Regenstrief Institute, Inc. and The UCUM Organization. Your use of the UCUM table, UCUM codes, UCUM definitions also is subject to this license, a copy of which is available at http://unitsofmeasure.org. The current complete UCUM table, UCUM Specification are available for download at http://unitsofmeasure.org. The UCUM table and UCUM codes are copyright © 1995-2020, Regenstrief Institute, Inc. and the Unified Codes for Units of Measures (UCUM) Organization. All rights reserved. THE UCUM TABLE (IN ALL FORMATS), UCUM DEFINITIONS, AND SPECIFICATION ARE PROVIDED "AS IS". ANY EXPRESS OR IMPLIED WARRANTIES ARE DISCLAIMED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
    
This material contains the following artwork: 
"Sectional Anatomy of the Heart with Path of Blood Flow" - licensed from Blausen Medical Communications, Inc. under the Creative Commons Attribution 3.0 Unported license (https://creativecommons.org/licenses/by/3.0/deed.en)

"small-n-flat icon set" (https://www.iconfinder.com/iconsets/small-n-flat) - licensed from Paomedia under the Creative Commons Attribution 3.0 Unported license (https://creativecommons.org/licenses/by/3.0/deed.en) 

This material contains test cases which fall under the following licensing terms:
Licensing and Copyright Notice and Terms of Use

Owner Notice: This software (including any associated website-service or downloadable source (code) was developed by the Lister Hill National Center for Biomedical Communications (LHNCBC), a research and development division of the U.S. National Library of Medicine (NLM), with the permission and based on the copyrighted content of the Regenstrief Institute.
The following terms and conditions are based on the BSD open-source license.

If publishing research that used this software, please include a citation that acknowledges it.

Redistribution and use in source and binary forms, with or without modification, are permitted for commercial and non-commercial purposes and products alike, provided that the following conditions are met:

Redistributions of source code shall retain the above Owner Notice, this list of conditions and the following disclaimer, and display them prominently.
Redistributions in binary form shall prominently reproduce the above Owner Notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the names of the National Library of Medicine (NLM), the Lister Hill National Center for Biomedical Communications (LHNCBC), the National Institutes of Health (NIH), nor the names of any of the software contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE OWNER AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    ''',
    );
  }

  @override
  String get title => 'Faiadashu™ Disclaimers';
}
