import 'package:faiadashu/observations/observations.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class ObservationPage extends ExhibitPage {
  ObservationPage({Key? key}) : super(key: key);

  final bpObservation = Observation(
    effectiveDateTime: FhirDateTime(DateTime.now()),
    code: CodeableConcept(
      coding: [
        Coding(
          system: FhirUri('http://loinc.org'),
          code: Code('55284-4'),
          display: 'BP sys/dias',
        )
      ],
    ),
    component: [
      ObservationComponent(
        code: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://loinc.org'),
              code: Code('8480-6'),
              display: 'BP sys',
            )
          ],
        ),
        valueQuantity: Quantity(value: Decimal(140.0), unit: 'mmHg'),
      ),
      ObservationComponent(
        code: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://loinc.org'),
              code: Code('8462-4'),
              display: 'BP dias',
            )
          ],
        ),
        valueQuantity: Quantity(value: Decimal(87.0), unit: 'mmHg'),
      ),
    ],
  );

  final bpObservationWHR = Observation(
    effectiveDateTime: FhirDateTime(DateTime.now()),
    code: CodeableConcept(
      coding: [
        Coding(
          system: FhirUri('http://example.org'),
          code: Code('BPHR'),
          display: 'BP sys/dias + HR',
        )
      ],
    ),
    component: [
      ObservationComponent(
        code: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://loinc.org'),
              code: Code('8480-6'),
              display: 'BP sys',
            )
          ],
        ),
        valueQuantity: Quantity(value: Decimal(140.0), unit: 'mmHg'),
      ),
      ObservationComponent(
        code: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://loinc.org'),
              code: Code('8462-4'),
              display: 'BP dias',
            )
          ],
        ),
        valueQuantity: Quantity(value: Decimal(87.3), unit: 'mmHg'),
      ),
      ObservationComponent(
        code: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://loinc.org'),
              code: Code('8867-4'),
              display: 'Heart rate',
            )
          ],
        ),
        valueQuantity: Quantity(value: Decimal(68.0), unit: '/min'),
      ),
    ],
  );

  @override
  Widget buildExhibit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ObservationView(
          bpObservation,
          valueStyle: Theme.of(context).textTheme.headline4,
          codeStyle: Theme.of(context).textTheme.subtitle2,
          dateTimeStyle: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: 16,
        ),
        ObservationView(
          bpObservationWHR,
          valueStyle: Theme.of(context).textTheme.headline4,
          codeStyle: Theme.of(context).textTheme.subtitle2,
          dateTimeStyle: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: 16,
        ),
        ObservationView(
          bpObservationWHR,
          valueStyle: Theme.of(context).textTheme.headline4,
          codeStyle: Theme.of(context).textTheme.subtitle2,
          dateTimeStyle: Theme.of(context).textTheme.caption,
          locale: const Locale('ar', 'BH'),
        ),
      ],
    );
  }

  @override
  String get title => 'Observations';
}
