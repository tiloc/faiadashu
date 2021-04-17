import 'dart:developer' as developer;
import 'dart:io';

import 'package:faiadashu/questionnaires/view/questionnaire_stepper_page.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:faiadashu_example/questionnaire_launch_tile.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';

import 'about_page.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: 'Faiadashu™ FHIRDash Gallery',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('de'),
//        Locale('jp'),  // TODO: Support for Japanese is semi-broken in Flutter
        Locale('es'),
        Locale('ar'),
      ],
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _listScrollController = ScrollController();

  final Map<String, QuestionnaireResponse?> _savedResponses = {};

  void _saveResponse(String id, QuestionnaireResponse? response) {
    if (response == null) {
      return;
    }

    _savedResponses[id] = response;
  }

  QuestionnaireResponse? _restoreResponse(String id) {
    if (_savedResponses.containsKey(id)) {
      return _savedResponses[id];
    } else {
      return null;
    }
  }

  // Build up a registry of ValueSets and CodeSystems which are being referenced
  // in the questionnaires.
  //
  // It is typically *NOT* possible to resolve value sets through their URI, as
  // these do not point to real web-servers.
  //
  // This mechanism allows to add them from other sources.
  final valueSetProvider = RegistryFhirResourceProvider([
    FhirValueSetProvider(),
    AssetResourceProvider.fromMap(<String, String>{
      'http://hl7.org/fhir/ValueSet/ucum-bodyweight':
          'assets/valuesets/ucum_bodyweight.json',
      'http://hl7.org/fhir/ValueSet/iso3166-1-2':
          'assets/valuesets/fhir_valueset_iso3166_1_2.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetYesNoUnk':
          'assets/valuesets/who_cr_valueset_yes_no_unknown.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetSexAtBirth':
          'assets/valuesets/who_cr_valueset_sex_at_birth.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetAgeUnits':
          'assets/valuesets/who_cr_valueset_age_units.json',
      'http://loinc.org/vs/LL715-4': 'assets/valuesets/loinc_ll715_4.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetPregnancyTrimester':
          'assets/valuesets/who_cr_valueset_pregnancy_trimester.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetAdmin1':
          'assets/valuesets/who_cr_valueset_admin_1.json',
      'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetPatientOutcome':
          'assets/valuesets/who_cr_valueset_patient_outcome.json',
      'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemPatientOutcome':
          'assets/codesystems/who_cr_codesystem_patient_outcome.json',
      'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemPregnancyTrimester':
          'assets/codesystems/who_cr_codesystem_pregnancy_trimester.json',
      'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemQuestionnaireChoice':
          'assets/codesystems/who_cr_codesystem_questionnaire_choice.json',
      'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemReasonForTesting':
          'assets/codesystems/who_cr_codesystem_reason_for_testing.json',
      'http://openhie.github.io/covid-19/CodeSystem/WhoCrCodeSystemComorbidity':
          'assets/codesystems/who_cr_codesystem_comorbidity.json',
    })
  ]);

  late final FhirResourceProvider resourceBundleProvider;

  @override
  void initState() {
    super.initState();
    resourceBundleProvider = RegistryFhirResourceProvider([
      InMemoryResourceProvider.inMemory(
          subjectResourceUri,
          Patient(id: Id('example123'), name: [
            HumanName(given: ['Emma'], family: 'Lee')
          ])),
      valueSetProvider
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) => RichText(
            text: TextSpan(
              text: 'Faiadashu™  FHIRDash —\n',
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
      body: Scrollbar(
        isAlwaysShown: true,
        controller: _listScrollController,
        child: ListView(
          controller: _listScrollController,
          children: [
            ListTile(
              title: const Text('About Faiadashu™ FHIRDash'),
              subtitle: const Text(
                '[(ファイアダッシュ)]',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
            ),
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
            QuestionnaireLaunchTile(
              title: 'SDC Demo Scroller',
              subtitle: 'A gallery of SDC feature support.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/sdc_demo.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'FHIR Hot Beverage IG',
              subtitle: 'WIP Beverage Questionnaire',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/beverage_ig.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'SDC Profile Example Render',
              subtitle: 'The reference questionnaire for SDC render features.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/sdc-example-render.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'Argonaut Questionnaire Sampler',
              subtitle:
                  'Reference sample from the Argonaut Questionnaire Implementation Guide.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/argonaut_sampler.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              locale: const Locale('de', 'DE'),
              title: 'Der Argonaut-Fragebogen',
              subtitle: 'Ein deutsches Beispiel für einen Fragebogen.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/argonaut_sampler.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              locale: const Locale('ar', 'BH'),
              title: 'استبيان "أرجونوت"',
              subtitle: 'مثال على استبيان عربي.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/argonaut_sampler.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'PHQ9 Questionnaire Scroller',
              subtitle: 'Simple choice-based survey with a total score.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/phq9_instrument.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'PHQ9 Questionnaire Scroller',
              subtitle: 'Simple choice-based survey with a total score.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/phq9_instrument.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            ListTile(
              title: const Text('PHQ9 Questionnaire Stepper'),
              subtitle:
                  const Text('Simple choice-based survey with a total score.'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuestionnaireStepperPage(
                            fhirResourceProvider: AssetResourceProvider.singleton(
                                questionnaireResourceUri,
                                'assets/instruments/phq9_instrument.json'))));
              },
            ),
            QuestionnaireLaunchTile(
              title: 'HF Questionnaire Scroller',
              subtitle: 'A heart failure survey with a total score.',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/hf_instrument.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'PRAPARE Questionnaire Scroller',
              subtitle: 'Real-world, mixed-type survey from the US',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/prapare_instrument.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'Bluebook Questionnaire Scroller',
              subtitle: 'Real-world, mixed-type survey from Australia',
              // Provide a hard-coded response for initial population
              fhirResourceProvider: RegistryFhirResourceProvider([
                AssetResourceProvider.singleton(
                    questionnaireResponseResourceUri,
                    'assets/responses/bluebook_response.json'),
                resourceBundleProvider
              ]),
              questionnairePath: 'assets/instruments/bluebook.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
            QuestionnaireLaunchTile(
              title: 'WHO COVID19 Surveillance',
              subtitle:
                  'Real-world example with very long ValueSets and enableWhen',
              fhirResourceProvider: resourceBundleProvider,
              questionnairePath: 'assets/instruments/who_covid19.json',
              saveResponseFunction: _saveResponse,
              restoreResponseFunction: _restoreResponse,
            ),
          ],
        ),
      ),
    );
  }
}
