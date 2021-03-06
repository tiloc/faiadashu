import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgets_on_fhir/observations/observation_widget.dart';
import 'package:widgets_on_fhir/primitive_types/date_time_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets on FHIR® Example',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('de', ''),
        Locale('es', ''),
        Locale('ar', ''),
      ],
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primitive Types'),
      ),
      body: Column(children: [
        FhirDateTimeWidget(FhirDateTime('2002-02-05')),
        FhirDateTimeWidget(FhirDateTime('2010-02-05 14:02')),
        FhirDateTimeWidget(FhirDateTime('2010-02')),
        ObservationWidget(observation),
      ]),
    );
  }
}
