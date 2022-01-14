import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:faiadashu/faiadashu.dart';
import 'package:faiadashu/logging/logging.dart' as fdashlog;
import 'package:faiadashu_example/about_page.dart';
import 'package:faiadashu_example/disclaimer_page.dart';
import 'package:faiadashu_example/observation_page.dart';
import 'package:faiadashu_example/primitive_page.dart';
import 'package:faiadashu_example/questionnaire_launch_tile.dart';
import 'package:faiadashu_online/restful/restful.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_auth/r4/scopes/clinical_scope.dart';
import 'package:fhir_auth/r4/scopes/scopes.dart';
import 'package:fhir_auth/r4/smart_client/smart_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart' as dartlog;

void main() {
  if (kDebugMode || kIsWeb) {
    dartlog.Logger.root.level = dartlog.Level.FINE;
    dartlog.Logger.root.onRecord.listen((dartlog.LogRecord rec) {
      developer.log(
        rec.message,
        time: rec.time,
        sequenceNumber: rec.sequenceNumber,
        level: rec.level.value,
        name: rec.loggerName,
        zone: rec.zone,
        error: rec.error,
        stackTrace: rec.stackTrace,
      );
    });
  } else {
    dartlog.Logger.root.level = dartlog.Level.WARNING;
    dartlog.Logger.root.onRecord.listen((dartlog.LogRecord rec) {
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
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              filled: true,
            ),
      ),
      darkTheme: ThemeData.dark(),
      title: 'Faiadashu™ FHIRDash Gallery',
      localizationsDelegates: const [
        FDashLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FDashLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _logger = fdashlog.Logger(_HomePageState);

  final ScrollController _listScrollController = ScrollController();

  final Map<String, QuestionnaireResponse?> _savedResponses = {};

  // Quick-and-dirty in-memory storage for QuestionnaireResponses
  // Not suitable for production use.
  void _saveResponse(String id, QuestionnaireResponse? response) {
    if (response == null) {
      return;
    }

    _savedResponses[id] = response;
  }

  // Quick-and-dirty in-memory storage for QuestionnaireResponses
  // Not suitable for production use.
  QuestionnaireResponse? _restoreResponse(String id) {
    if (_savedResponses.containsKey(id)) {
      return _savedResponses[id];
    } else {
      return null;
    }
  }

  // Quick-and-dirty upload of QuestionnaireResponse to server
  // Not suitable for production use (no error-handling)
  Future<void> _uploadResponse(
    String id,
    QuestionnaireResponse? response,
  ) async {
    if (response == null) {
      return;
    }
    // Upload will also save locally.
    _savedResponses[id] = response;
    await uploadQuestionnaireResponse(smartClient, response);
  }

  // Build up a registry of ValueSets and CodeSystems which are being referenced
  // in the questionnaires.
  //
  // It is typically *NOT* possible to resolve value sets through their URI, as
  // these do not point to real web-servers.
  //
  // This mechanism allows to add them from other sources.
  final valueSetProvider = AssetResourceProvider.fromMap(<String, String>{
    'http://hl7.org/fhir/ValueSet/administrative-gender':
        'assets/valuesets/fhir_valueset_administrative_gender.json',
    'http://hl7.org/fhir/administrative-gender':
        'assets/codesystems/fhir_codesystem_administrative_gender.json',
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
    'http://openhie.github.io/covid-19/ValueSet/WhoCrValueSetTestResult':
        'assets/valuesets/who_cr_valueset_test_result.json',
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
  });

  late final FhirResourceProvider resourceBundleProvider;

  late final SmartClient smartClient;

  // Patient ID matches a patient on Meld Sandbox server.
  final launchContext = LaunchContext(
    patient: Patient(
      id: Id('smart-880378'),
      name: [
        HumanName(
          given: ['Amy', 'R'],
          family: 'Lee',
          use: HumanNameUse.official,
        )
      ],
      birthDate: Date('1999-12-08'),
      gender: PatientGender.female,
    ),
  );

  @override
  void initState() {
    super.initState();
    resourceBundleProvider = RegistryFhirResourceProvider([
      AssetImageAttachmentProvider(
        'http://example.org/images',
        'assets/images',
      ),
      valueSetProvider
    ]);

    // Setup a client for access to a Meld sandbox.
    smartClient = SmartClient.getSmartClient(
      fhirUri: FhirUri('https://gw.interop.community/FaiadashuGallery/data'),
      clientId: '4564f6f7-335f-43d3-8867-a0f4e6f901d6',
      redirectUri: FhirUri('com.legentix.faiagallery://callback'),
      scopes: Scopes(
        clinicalScopes: [
          ClinicalScope(
            Role.patient,
            R4ResourceType.Patient,
            Interaction.any,
          ),
          ClinicalScope(
            Role.patient,
            R4ResourceType.QuestionnaireResponse,
            Interaction.any,
          ),
        ],
        openid: true,
        offlineAccess: true,
      ).scopesList(),
    );
  }

  @override
  void dispose() {
    try {
      unawaited(smartClient.logout());
    } catch (e) {
      _logger.warn('Could not log out', error: e);
    }
    super.dispose();
  }

  /// Schedules repaint after login / logout.
  void _onLoginChanged() {
    _logger.debug('_onLoginChanged: ${smartClient.isLoggedIn()}');
    setState(() {
      // Rebuild
    });
  }

  Widget _launchQuestionnaire(
    String title,
    String subtitle,
    String questionnairePath,
  ) {
    return QuestionnaireLaunchTile(
      title: title,
      subtitle: subtitle,
      fhirResourceProvider: resourceBundleProvider,
      launchContext: launchContext,
      questionnairePath: questionnairePath,
      saveResponseFunction: _saveResponse,
      restoreResponseFunction: _restoreResponse,
      uploadResponseFunction: _uploadResponse,
    );
  }

  Widget _headline(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(subtitle)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: What is the best way here? Always offering upload may result
    // in implicit login, which is OK?
    final uploadResponseFunction =
//    smartClient.isLoggedIn() ? _uploadResponse : null;
        _uploadResponse;

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
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        actions: [
          SmartLoginButton(smartClient, onLoginChanged: _onLoginChanged)
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _listScrollController,
          child: ListView(
            controller: _listScrollController,
            children: [
              _headline(context, 'Specialties', 'The fancy stuff'),
              QuestionnaireLaunchTile(
                title: 'FHIR Hot Beverage IG',
                subtitle:
                    'Beverage Questionnaire - illustrates itemMedia, upper/lower, generated prefix',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/beverage_ig.json',
                saveResponseFunction: _saveResponse,
                restoreResponseFunction: _restoreResponse,
                uploadResponseFunction: uploadResponseFunction,
                questionnaireModelDefaults: QuestionnaireModelDefaults(
                  prefixBuilder: (fim) {
                    return (fim is GroupItemModel)
                        ? RenderingString.fromText(
                            'You want the Donut but all that you get is the hole…',
                            xhtmlText: '🍩',
                          )
                        : (fim is QuestionItemModel)
                            ? RenderingString.fromText(
                                'Venti',
                                xhtmlText: '☕',
                              )
                            : null;
                  },
                ),
              ),
              ListTile(
                title: const Text('🌸 Cherry blossom Filler 🌸'),
                subtitle: const Text(
                  'Theming and a bespoke Scaffold',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionnaireScroller(
                        scaffoldBuilder: const _CherryBlossomScaffoldBuilder(),
                        fhirResourceProvider: RegistryFhirResourceProvider([
                          resourceBundleProvider,
                          AssetResourceProvider.singleton(
                            questionnaireResourceUri,
                            'assets/instruments/sdc_demo.json',
                          )
                        ]),
                        launchContext: launchContext,
                        questionnaireModelDefaults:
                            const QuestionnaireModelDefaults(
                          prefixBuilder: QuestionnaireModelDefaults
                              .questionNumeralPrefixBuilder,
                          implicitNullOption: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
              _headline(
                context,
                'SDC Features',
                'SDC IG support – Advanced Rendering and Behavior',
              ),
              _launchQuestionnaire(
                'SDC Demo Scroller',
                'A gallery of SDC feature support.',
                'assets/instruments/sdc_demo.json',
              ),
              _launchQuestionnaire(
                'SDC Profile Example Render - official version',
                'The reference questionnaire version hl7.fhir.uv.sdc#3.0.0 based on FHIR 4.0.1',
                'assets/instruments/questionnaire-sdc-profile-example-render.json',
              ),
              _launchQuestionnaire(
                'SDC Profile Example Render - modified version',
                'The reference questionnaire for SDC render features, with a few additions.',
                'assets/instruments/sdc-example-render.json',
              ),
              _launchQuestionnaire(
                'SDC LOINC AHRQ Example',
                'WIP: Extensive use of ValueSets and a repeating group.',
                'assets/instruments/sdc-loinc-ahrq.json',
              ),
              _launchQuestionnaire(
                'Weight/Height Tracking',
                'Example for BMI calculation with FHIRPath',
                'assets/instruments/weight-height-tracking.json',
              ),
              _headline(
                context,
                'Real-World',
                '🩺 Real surveys from real use-cases. 🩺',
              ),
              _launchQuestionnaire(
                'PHQ9 Questionnaire Scroller',
                'Simple choice-based survey with a total score.',
                'assets/instruments/phq9_instrument.json',
              ),
              ListTile(
                title: const Text('PHQ9 Questionnaire Stepper'),
                subtitle: const Text(
                  'Simple choice-based survey with a total score.',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionnaireTheme(
                        data: const QuestionnaireThemeData(
                          // It is better for a wizard to overtly present all choices on each screen.
                          codingControlPreference:
                              CodingControlPreference.expanded,
                        ),
                        child: QuestionnaireStepperPage(
                          fhirResourceProvider: AssetResourceProvider.singleton(
                            questionnaireResourceUri,
                            'assets/instruments/phq9_instrument.json',
                          ),
                          launchContext: launchContext,
                        ),
                      ),
                    ),
                  );
                },
              ),
              _launchQuestionnaire(
                'Heart Failure Survey',
                'A heart failure survey with a total score.',
                'assets/instruments/hf_instrument.json',
              ),
              _launchQuestionnaire(
                  'Framingham HCDC',
                  'Real-world cardiac risk scoring. Very heavy use of FHIRPath.',
                  'assets/instruments/framingham-hcdc.json'),
              _launchQuestionnaire(
                'PRAPARE Survey',
                'Real-world, mixed-type survey from the US',
                'assets/instruments/prapare_instrument.json',
              ),
              QuestionnaireLaunchTile(
                title: 'Bluebook Survey',
                subtitle: 'Real-world, mixed-type survey from Australia',
                // Provide a hard-coded response for initial population
                fhirResourceProvider: RegistryFhirResourceProvider([
                  AssetResourceProvider.singleton(
                    questionnaireResponseResourceUri,
                    'assets/responses/bluebook_response.json',
                  ),
                  resourceBundleProvider
                ]),
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/bluebook.json',
                saveResponseFunction: _saveResponse,
                restoreResponseFunction: _restoreResponse,
                uploadResponseFunction: uploadResponseFunction,
              ),
              _launchQuestionnaire(
                'WHO COVID19 Surveillance',
                'Real-world example with very long ValueSets and enableWhen',
                'assets/instruments/who_covid19.json',
              ),
              _headline(
                context,
                'Internationalization',
                '🌎 Have stethoscope, will travel… 🌎',
              ),
              _launchQuestionnaire(
                'Argonaut Questionnaire Sampler',
                'US English reference sample from the Argonaut Questionnaire Implementation Guide.',
                'assets/instruments/argonaut_sampler.json',
              ),
              QuestionnaireLaunchTile(
                locale: const Locale('de', 'DE'),
                title: 'Der Argonaut-Fragebogen',
                subtitle: 'Ein deutsches Beispiel für einen Fragebogen.',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/argonaut_sampler.json',
                saveResponseFunction: _saveResponse,
                restoreResponseFunction: _restoreResponse,
                uploadResponseFunction: uploadResponseFunction,
              ),
              QuestionnaireLaunchTile(
                locale: const Locale('ar', 'BH'),
                title: 'استبيان "أرجونوت"',
                subtitle: 'مثال على استبيان عربي.',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/argonaut_sampler.json',
                saveResponseFunction: _saveResponse,
                restoreResponseFunction: _restoreResponse,
                uploadResponseFunction: uploadResponseFunction,
              ),
              QuestionnaireLaunchTile(
                locale: const Locale('ja', 'JP'),
                title: 'アルゴノート」のアンケートです。',
                subtitle: '日本でのアンケートの例です。',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/argonaut_sampler.json',
                saveResponseFunction: _saveResponse,
                restoreResponseFunction: _restoreResponse,
                uploadResponseFunction: uploadResponseFunction,
              ),
              _headline(
                context,
                'Unit Tests',
                'Bland exercises for SDC features.',
              ),
              _launchQuestionnaire(
                'Group under Question',
                'Nesting a question underneath a group.',
                'assets/instruments/group-under-question.R4.json',
              ),
              _launchQuestionnaire(
                'Question under Question',
                'Nesting a question underneath another question.',
                'assets/instruments/question-under-question.R4.json',
              ),
              _launchQuestionnaire(
                'Variable Scope Test',
                'Tests the visibility of questionnaire-level and item-level variables.',
                'assets/instruments/variable_scope_test.json',
              ),
              _launchQuestionnaire(
                'enableWhenExpression Test',
                'Tests the correct implementation of enableWhenExpression.',
                'assets/instruments/enable_when_expression_test.json',
              ),
              _launchQuestionnaire(
                'enableWhen Test',
                'Tests the implementation of enableWhen - incomplete, and enableWhenExpression is far more capable.',
                'assets/instruments/questionnaire-sdc-test-enable_when.json',
              ),
              _launchQuestionnaire(
                'initial.value[x] Test',
                'Tests the correct implementation of initial.value[x] on various data types.',
                'assets/instruments/questionnaire-initialx.json',
              ),
              _launchQuestionnaire(
                'answerExpression Test - currently unsupported',
                'Tests support for answerExpression from a terminology server.',
                'assets/instruments/rxterms.R4.json',
              ),
              _headline(
                context,
                'Generic FHIR examples',
                'Examples not related to FHIR SDC IG / Questionnaires.',
              ),
              ListTile(
                title: const Text('Primitive Types'),
                subtitle: const Text(
                  'Formatted, internationalized text output of FHIR primitive types.',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrimitivePage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Observation'),
                subtitle: const Text(
                  'Formatted, internationalized text output of observations.',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ObservationPage(),
                    ),
                  );
                },
              ),
              _headline(
                context,
                'Info',
                '📰 Extra! Extra! Read all about it! 📰',
              ),
              ListTile(
                title: const Text('About Faiadashu™ FHIRDash'),
                subtitle: const Text(
                  '[(ファイアダッシュ)]',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Disclaimers'),
                subtitle: const Text('Legalese'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DisclaimerPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Demonstrate the creation of a scrolling questionnaire with no Scaffold.
class _CherryBlossomScaffoldBuilder extends QuestionnairePageScaffoldBuilder {
  const _CherryBlossomScaffoldBuilder();

  @override
  Widget build(
    BuildContext context, {
    required void Function(void Function() p1) setStateCallback,
    required Widget child,
  }) {
    return Theme(
      data: ThemeData.light().copyWith(
        scrollbarTheme: ThemeData.light().scrollbarTheme.copyWith(
              isAlwaysShown: true,
              thumbColor: MaterialStateProperty.all(
                const Color(0xFF5C1349),
              ),
            ),
        textTheme: GoogleFonts.ralewayTextTheme(),
        iconTheme: ThemeData.light().iconTheme.copyWith(
              color: const Color(0xFF5C1349),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              GoogleFonts.raleway(fontWeight: FontWeight.w600),
            ),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFF5C1349),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
        checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
              fillColor: MaterialStateProperty.all(
                const Color(0xFFE30425),
              ),
            ),
        radioTheme: ThemeData.light().radioTheme.copyWith(
              fillColor: MaterialStateProperty.all(
                const Color(0xFFE30425),
              ),
            ),
        sliderTheme: ThemeData.light().sliderTheme.copyWith(
              thumbColor: const Color(0xFFE30425),
              activeTrackColor: const Color(0xFFE30425),
              inactiveTrackColor: const Color(0x60E30425),
            ),
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.0),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: ThemeData.light().errorColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: ThemeData.light().errorColor.withOpacity(0.12),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Color.fromRGBO(0, 0, 0, 0.54),
                ),
              ),
            ),
      ), // Make it always light
      // We have to take care of SafeArea ourselves
      child: SafeArea(
        // This surround Card provides the Material parent that is required by
        // the QuestionnaireFiller. Other potential Material parents would be
        // Scaffolds.
        child: Card(
          // This column surrounds the scroller with whimsical add-ons
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '🦄🌸🦄🌸🦄🌸🦄',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Expanded(
                child: child,
              ), // This child is the actual scroller
              const Divider(),
              // We're putting our own exit button in here
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('桜の園からの帰り道'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
