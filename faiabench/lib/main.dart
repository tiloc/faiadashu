import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:faiabench/json_editor.dart';
import 'package:faiabench/json_tree.dart';
import 'package:faiabench/questionnaire_scroller_panel.dart';
import 'package:faiadashu/faiadashu.dart';
import 'package:faiadashu/logging/logging.dart' as fdashlog;
import 'package:fhir/primitive_types/date.dart';
import 'package:fhir/primitive_types/id.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart' as dartlog;
import 'package:multi_split_view/multi_split_view.dart';

import 'about_page.dart';
import 'disclaimer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode || kIsWeb) {
    dartlog.Logger.root.level = dartlog.Level.ALL;
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

  final initialQuestionnaireJson =
      await rootBundle.loadString('assets/initial/bluebook-questionnaire.json');

  final initialQuestionnaireResponseJson = await rootBundle
      .loadString('assets/initial/bluebook-questionnaire-response.json');

  final initialLaunchContextJson = 'TBD';
//      await rootBundle.loadString('assets/initial/launchContext.json');

  runApp(MyApp(initialQuestionnaireJson, initialQuestionnaireResponseJson,
      initialLaunchContextJson));
}

class MyApp extends StatelessWidget {
  final String initialQuestionnaireJson;
  final String initialQuestionnaireResponseJson;
  final String initialLaunchContextJson;

  const MyApp(this.initialQuestionnaireJson,
      this.initialQuestionnaireResponseJson, this.initialLaunchContextJson,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: 'Faiadashu™ Faiabench',
      localizationsDelegates: const [
        FDashLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FDashLocalizations.supportedLocales,
      home:
          HomePage(initialQuestionnaireJson, initialQuestionnaireResponseJson),
    );
  }
}

class HomePage extends StatefulWidget {
  final String initialQuestionnaireJson;
  final String initialQuestionnaireResponseJson;

  const HomePage(
      this.initialQuestionnaireJson, this.initialQuestionnaireResponseJson,
      {Key? key})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _logger = fdashlog.Logger(_HomePageState);

  late Questionnaire currentQuestionnaire;
  late String currentQuestionnaireJson;

  late QuestionnaireResponse currentQuestionnaireResponse;
  late String currentQuestionnaireResponseJson;

  late final JsonEditor _inputQuestionnaireEditor;
  late final JsonEditor _inputQuestionnaireResponseEditor;
  late final JsonEditor _inputLaunchContextEditor;

  late Widget _questionnaireScrollerPanel;

  final launchContext = LaunchContext(
    patient: Patient(
      id: Id('14603'),
      name: [
        HumanName(given: ['Emma'], family: 'Lee', use: HumanNameUse.official)
      ],
      birthDate: Date('1940-08-12'),
      gender: PatientGender.female,
    ),
  );

  MultiSplitViewController _inputPanelSplitController =
      MultiSplitViewController(weights: [0.2, 0.4, 0.4]);

  @override
  void initState() {
    super.initState();

    currentQuestionnaireJson = widget.initialQuestionnaireJson;
    currentQuestionnaireResponseJson = widget.initialQuestionnaireResponseJson;

    _inputQuestionnaireEditor = JsonEditor(
      'Questionnaire',
      currentQuestionnaireJson,
      _inputsUpdated,
    );

    _inputQuestionnaireResponseEditor = JsonEditor(
      'populate with QuestionnaireResponse',
      currentQuestionnaireResponseJson,
      _inputsUpdated,
    );

    _inputLaunchContextEditor = JsonEditor(
      'Launch Context',
      'Launch JSON',
      _inputsUpdated,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rebuildFiller();
  }

  void _rebuildFiller() {
    currentQuestionnaire =
        Questionnaire.fromJson(jsonDecode(currentQuestionnaireJson));

    currentQuestionnaireResponse = QuestionnaireResponse.fromJson(
        jsonDecode(currentQuestionnaireResponseJson));

    final hash =
        currentQuestionnaire.hashCode + currentQuestionnaireResponse.hashCode;

    _questionnaireScrollerPanel = QuestionnaireScrollerPanel(
      currentQuestionnaire,
      currentQuestionnaireResponse,
      launchContext,
      key: ValueKey<int>(hash),
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  void _inputsUpdated() {
    setState(() {
      currentQuestionnaireJson = _inputQuestionnaireEditor.getValue(context);
      _rebuildFiller();
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputsPanel = MultiSplitView(
        axis: Axis.vertical,
        controller: _inputPanelSplitController,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: _inputLaunchContextEditor,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: _inputQuestionnaireEditor,
          ),
          SizedBox.expand(
            child: Container(
              padding: EdgeInsets.all(8),
              child: _inputQuestionnaireResponseEditor,
            ),
          ),
        ]);

    MultiSplitViewTheme themedInputsPanel = MultiSplitViewTheme(
        child: inputsPanel,
        data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.grooved1(
                color: Colors.indigo[100]!,
                highlightedColor: Colors.indigo[900]!)));

    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) => RichText(
            text: TextSpan(
              text: 'Faiadashu™ Faiabench —\n',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(
                  text: 'make the fhiry sparks ignite...',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text('Faiabench Menu'),
            ),
            ListTile(
              title: const Text('About Faiabench'),
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
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: themedInputsPanel,
            ),
            Expanded(
              flex: 1,
              child: _questionnaireScrollerPanel,
            ),
            Expanded(
              flex: 1,
              child: JsonTree(currentQuestionnaire),
            ),
          ],
        ),
      ),
    );
  }
}
