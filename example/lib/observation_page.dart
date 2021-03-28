import 'package:fhir/primitive_types/code.dart';
import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/primitive_types/fhir_date_time.dart';
import 'package:fhir/primitive_types/fhir_uri.dart';
import 'package:fhir/r4/general_types/general_types.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:fire_dash/observations/observation_widget.dart';
import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class ObservationPage extends ExhibitPage {
  ObservationPage({Key? key}) : super(key: key);

  final observation = Observation(
    effectiveDateTime: FhirDateTime(DateTime.now()),
    code: CodeableConcept(coding: [
      Coding(
          system: FhirUri('http://loinc.org'),
          code: Code('55284-4'),
          display: 'BP sys/dias')
    ]),
    component: [
      ObservationComponent(
          code: CodeableConcept(
            coding: [
              Coding(
                  system: FhirUri('http://loinc.org'),
                  code: Code('8480-6'),
                  display: 'BP sys')
            ],
          ),
          valueQuantity: Quantity(value: Decimal(140.0), unit: 'mmHg')),
      ObservationComponent(
          code: CodeableConcept(
            coding: [
              Coding(
                  system: FhirUri('http://loinc.org'),
                  code: Code('8462-4'),
                  display: 'BP dias')
            ],
          ),
          valueQuantity: Quantity(value: Decimal(87.0), unit: 'mmHg')),
    ],
  );

  @override
  Widget buildExhibit(BuildContext context) {
    return Column(children: [
      ObservationWidget(
        observation,
        valueStyle: Theme.of(context).textTheme.headline4,
        codeStyle: Theme.of(context).textTheme.subtitle2,
        dateTimeStyle: Theme.of(context).textTheme.caption,
      ),
    ]);
  }

  @override
  String get title => 'Observations';
}
