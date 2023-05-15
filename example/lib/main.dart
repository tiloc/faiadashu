import 'dart:developer' as developer;
import 'dart:io';

import 'package:faiadashu/faiadashu.dart';
import 'package:faiadashu/logging/logging.dart' as fdashlog;
import 'package:faiadashu_example/about_page.dart';
import 'package:faiadashu_example/cherry_blossom_theme.dart';
import 'package:faiadashu_example/disclaimer_page.dart';
import 'package:faiadashu_example/observation_page.dart';
import 'package:faiadashu_example/primitive_page.dart';
import 'package:faiadashu_example/questionnaire_launch_tile.dart';
import 'package:faiadashu_example/questionnaire_response_storage.dart';
import 'package:faiadashu_example/value_set_provider.dart';
import 'package:faiadashu_online/restful/restful.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
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
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _logger = fdashlog.Logger(_HomePageState);

  final ScrollController _listScrollController = ScrollController();

  late final QuestionnaireResponseStorage questionnaireResponseStorage;

  late final FhirResourceProvider resourceBundleProvider;

  // Patient ID matches a patient on Meld Sandbox server.
  final sandboxPatient = Patient(
    id: 'smart-880378',
    name: [
      HumanName(
        given: ['Amy', 'R'],
        family: 'Lee',
        use: HumanNameUse.official,
      )
    ],
    birthDate: Date('1999-12-08'),
    gender: Code('female'),
  );

  late final LaunchContext launchContext;

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

    launchContext = LaunchContext(
      patient: sandboxPatient,
    );

    questionnaireResponseStorage = QuestionnaireResponseStorage(
      fhirUri: FhirUri('https://gw.interop.community/FaiadashuGallery/data'),
      clientId: '4564f6f7-335f-43d3-8867-a0f4e6f901d6',
      redirectUri: FhirUri('com.legentix.faiagallery://callback'),
    );
  }

  @override
  void dispose() {
    questionnaireResponseStorage.dispose();
    super.dispose();
  }

  /// Schedules repaint after login / logout.
  void _onLoginChanged() {
    _logger.debug(
      '_onLoginChanged: ${questionnaireResponseStorage.smartClient.isLoggedIn()}',
    );
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
      saveResponseFunction: questionnaireResponseStorage.saveToMemory,
      restoreResponseFunction: questionnaireResponseStorage.restoreFromMemory,
      uploadResponseFunction: questionnaireResponseStorage.uploadToServer,
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
                  .titleLarge
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
        questionnaireResponseStorage.uploadToServer;

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
          SmartLoginButton(
            questionnaireResponseStorage.smartClient,
            onLoginChanged: _onLoginChanged,
          )
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
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
                saveResponseFunction: questionnaireResponseStorage.saveToMemory,
                restoreResponseFunction:
                    questionnaireResponseStorage.restoreFromMemory,
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
                        scaffoldBuilder: const CherryBlossomScaffoldBuilder(),
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
                'assets/instruments/framingham-hcdc.json',
              ),
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
                saveResponseFunction: questionnaireResponseStorage.saveToMemory,
                restoreResponseFunction:
                    questionnaireResponseStorage.restoreFromMemory,
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
                locale: const Locale.fromSubtags(
                  languageCode: 'de',
                  countryCode: 'DE',
                ),
                title: 'Der Argonaut-Fragebogen',
                subtitle: 'Ein deutsches Beispiel für einen Fragebogen.',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/argonaut_sampler.json',
                saveResponseFunction: questionnaireResponseStorage.saveToMemory,
                restoreResponseFunction:
                    questionnaireResponseStorage.restoreFromMemory,
                uploadResponseFunction: uploadResponseFunction,
              ),
              QuestionnaireLaunchTile(
                locale: const Locale.fromSubtags(
                  languageCode: 'ar',
                  countryCode: 'BH',
                ),
                title: 'استبيان "أرجونوت"',
                subtitle: 'مثال على استبيان عربي.',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/argonaut_sampler.json',
                saveResponseFunction: questionnaireResponseStorage.saveToMemory,
                restoreResponseFunction:
                    questionnaireResponseStorage.restoreFromMemory,
                uploadResponseFunction: uploadResponseFunction,
              ),
              QuestionnaireLaunchTile(
                locale: const Locale.fromSubtags(
                  languageCode: 'ja',
                  countryCode: 'JP',
                ),
                title: 'アルゴノート」のアンケートです。',
                subtitle: '日本でのアンケートの例です。',
                fhirResourceProvider: resourceBundleProvider,
                launchContext: launchContext,
                questionnairePath: 'assets/instruments/argonaut_sampler.json',
                saveResponseFunction: questionnaireResponseStorage.saveToMemory,
                restoreResponseFunction:
                    questionnaireResponseStorage.restoreFromMemory,
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
