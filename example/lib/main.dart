import 'package:fire_dash/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'disclaimer_page.dart';
import 'observation_page.dart';
import 'primitive_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faiadasshu [(ファイアダッシュ)] Gallery',
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
              text: 'Faiadasshu [(ファイアダッシュ)] —\n',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                    text: 'Widgets for Digital Health™',
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
                      builder: (context) =>
                          const QuestionnaireScrollerPage.fromAsset(
                              'assets/instruments/sdc-example-render.json')));
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
                      builder: (context) =>
                          const QuestionnaireScrollerPage.fromAsset(
                              'assets/instruments/argonaut_sampler.json')));
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
                      builder: (context) =>
                          const QuestionnaireScrollerPage.fromAsset(
                              'assets/instruments/phq9_instrument.json')));
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
                      builder: (context) =>
                          const QuestionnaireScrollerPage.fromAsset(
                              'assets/instruments/hf_instrument.json')));
            },
          ),
          ListTile(
            title: const Text('PRAPARE Questionnaire Scroller'),
            subtitle: const Text('Real-world, mixed-type survey from the US'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const QuestionnaireScrollerPage.fromAsset(
                              'assets/instruments/prapare_instrument.json')));
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
                      builder: (context) =>
                          const QuestionnaireScrollerPage.fromAsset(
                              'assets/instruments/bluebook.json')));
            },
          ),
        ],
      ),
    );
  }
}
