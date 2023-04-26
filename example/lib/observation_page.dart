import 'package:faiadashu/observations/observations.dart';
import 'package:faiadashu_example/exhibit_page.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class ObservationPage extends ExhibitPage {
  ObservationPage({super.key});

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
          valueStyle: Theme.of(context).textTheme.headlineMedium,
          codeStyle: Theme.of(context).textTheme.titleSmall,
          dateTimeStyle: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 16,
        ),
        ObservationView(
          bpObservationWHR,
          valueStyle: Theme.of(context).textTheme.headlineMedium,
          codeStyle: Theme.of(context).textTheme.titleSmall,
          dateTimeStyle: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 16,
        ),
        ObservationView(
          bpObservationWHR,
          valueStyle: Theme.of(context).textTheme.headlineMedium,
          codeStyle: Theme.of(context).textTheme.titleSmall,
          dateTimeStyle: Theme.of(context).textTheme.bodySmall,
          locale:
              const Locale.fromSubtags(languageCode: 'ar', countryCode: 'BH'),
        ),
      ],
    );
  }

  @override
  String get title => 'Observations';
}
