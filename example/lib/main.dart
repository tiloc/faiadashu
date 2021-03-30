import 'dart:developer' as developer;
import 'dart:io';

import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/questionnaires/valueset/fhir_valueset_provider.dart';
import 'package:faiadashu/questionnaires/valueset/valueset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';

import 'disclaimer_page.dart';
import 'observation_page.dart';
import 'primitive_page.dart';

void main() {
  if (kDebugMode || kIsWeb) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      developer.log(rec.message,
          time: rec.time,
          sequenceNumber: rec.sequenceNumber,
          level: rec.level.value,
          name: rec.loggerName,
          zone: rec.zone,
          error: rec.error,
          stackTrace: rec.stackTrace);
    });
  } else {
    Logger.root.level = Level.ALL; // In real production this might be WARN.
    Logger.root.onRecord.listen((LogRecord rec) {
      stdout.writeln('${rec.level.name}: ${rec.message}');
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faiadashu™ [(ファイアダッシュ)] Gallery',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('de'),
//        Locale('jp'),  // TODO: Support for Japanese is semi-broken in Flutter
        Locale('es'),
        Locale('ar'),
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
  final valueSetProvider = NestedValueSetProvider([
    FhirValueSetProvider(),
    AssetValueSetProvider(<String, String>{
      'http://hl7.org/fhir/ValueSet/iso3166-1-2':
          'assets/valuesets/fhir_valueset_iso3166_1_2.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetYesNoUnk':
          'assets/valuesets/who_cr_valueset_yes_no_unknown.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetSexAtBirth':
          'assets/valuesets/who_cr_valueset_sex_at_birth.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetAgeUnits':
          'assets/valuesets/who_cr_valueset_age_units.json',
      'http://loinc.org/vs/LL715-4': 'assets/valuesets/loinc_ll715_4.json'
    })
  ]);

  @override
  Widget build(BuildContext context) {
    final fab = FloatingActionButton.extended(
      label: const Text('Complete'),
      icon: const Icon(Icons.thumb_up),
      onPressed: () {},
    );

    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) => RichText(
            text: TextSpan(
              text: 'Faiadashu™ [(ファイアダッシュ)] —\n',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                    text: 'Widgets for Digital Health',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Disclaimers'),
            subtitle: const Text('Legalese'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisclaimerPage()));
            },
          ),
          ListTile(
            title: const Text('Primitive Types'),
            subtitle: const Text(
                'Formatted, internationalized text output of FHIR primitive types.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrimitivePage()));
            },
          ),
          ListTile(
            title: const Text('Observation'),
            subtitle: const Text(
                'Formatted, internationalized text output of observations.'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ObservationPage()));
            },
          ),
          ListTile(
            title: const Text('SDC Demo Scroller'),
            subtitle: const Text('A gallery of SDC feature support.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/sdc_demo.json',
                          valueSetProvider: valueSetProvider,
                          floatingActionButton: fab)));
            },
          ),
          ListTile(
            title: const Text('SDC Profile Example Render'),
            subtitle: const Text(
                'The reference questionnaire for SDC render features.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/sdc-example-render.json',
                          valueSetProvider: valueSetProvider)));
            },
          ),
          ListTile(
            title: const Text('Argonaut Questionnaire Sampler'),
            subtitle: const Text(
                'Reference sample from the Argonaut Questionnaire Implementation Guide.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionnaireScrollerPage.fromAsset(
                      'assets/instruments/argonaut_sampler.json',
                      valueSetProvider: valueSetProvider,
                    ),
                  ));
            },
          ),
          ListTile(
            title: const Text('PHQ9 Questionnaire Scroller'),
            subtitle:
                const Text('Simple choice-based survey with a total score.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/phq9_instrument.json',
                          valueSetProvider: valueSetProvider)));
            },
          ),
          ListTile(
            title: const Text('PHQ9 Questionnaire Stepper'),
            subtitle:
                const Text('Simple choice-based survey with a total score.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const QuestionnaireStepperPage.fromAsset(
                              'assets/instruments/phq9_instrument.json')));
            },
          ),
          ListTile(
            title: const Text('HF Questionnaire Scroller'),
            subtitle: const Text('A heart failure survey with a total score.'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/hf_instrument.json',
                          valueSetProvider: valueSetProvider)));
            },
          ),
          ListTile(
            title: const Text('PRAPARE Questionnaire Scroller'),
            subtitle: const Text('Real-world, mixed-type survey from the US'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/prapare_instrument.json',
                          valueSetProvider: valueSetProvider)));
            },
          ),
          ListTile(
            title: const Text('Bluebook Questionnaire Scroller'),
            subtitle:
                const Text('Real-world, mixed-type survey from Australia'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/bluebook.json',
                          valueSetProvider: valueSetProvider)));
            },
          ),
          ListTile(
            title: const Text('WHO COVID19 Surveillance'),
            subtitle: const Text('BROKEN Real-world, mixed-type survey by WHO'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionnaireScrollerPage.fromAsset(
                          'assets/instruments/who_covid19.json',
                          valueSetProvider: valueSetProvider)));
            },
          ),
        ],
      ),
    );
  }
}
