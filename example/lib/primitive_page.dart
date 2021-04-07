import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:fhir/primitive_types/fhir_date_time.dart';
import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class PrimitivePage extends ExhibitPage {
  const PrimitivePage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return Column(children: [
      FhirDateTimeText(FhirDateTime('2002-02-05')),
      FhirDateTimeText(FhirDateTime('2010-02-05 14:02')),
      FhirDateTimeText(FhirDateTime('2010-02')),
    ]);
  }

  @override
  String get title => 'Primitives';
}
