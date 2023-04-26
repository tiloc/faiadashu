import 'package:faiabench/exhibit_page.dart';
import 'package:flutter/material.dart';

class DisclaimerPage extends ExhibitPage {
  const DisclaimerPage({super.key});

  @override
  Widget buildExhibit(BuildContext context) {
    return const Text(
      '''
Flutter and the related logo are trademarks of Google LLC. We are not endorsed by or affiliated with Google LLC.

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health Level Seven International and their use does not constitute endorsement by HL7.
    ''',
    );
  }

  @override
  String get title => 'Faiadashu™ Faiabench Disclaimers';
}
