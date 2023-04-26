import 'dart:developer' as developer;
import 'dart:io';

import 'package:faiabench/fhir_resource_editor.dart';
import 'package:faiabench/questionnaire_scroller_panel.dart';
import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart' as dartlog;
import 'package:multi_split_view/multi_split_view.dart';

import 'about_page.dart';
import 'disclaimer_page.dart';
import 'fhir_resource.dart';
import 'fhir_resource_notifier.dart';
import 'filler_inputs.dart';

final questionnaireProvider =
    StateNotifierProvider<FhirResourceNotifier, AsyncValue<FhirResource>>(
        (ref) {
  return FhirResourceNotifier('assets/initial/bluebook-questionnaire.json');
});

final populateQuestionnaireResponseProvider =
    StateNotifierProvider<FhirResourceNotifier, AsyncValue<FhirResource>>(
        (ref) {
  return FhirResourceNotifier(
    'assets/initial/bluebook-questionnaire-response.json',
  );
});

final launchContextProvider =
    StateNotifierProvider<FhirResourceNotifier, AsyncValue<FhirResource>>(
        (ref) {
  return FhirResourceNotifier('assets/initial/launch-context.json');
});

final fillerInputsProvider = Provider<FillerInputs?>((ref) {
  final questionnaire = ref.watch(questionnaireProvider).value;
  final questionnaireResponse =
      ref.watch(populateQuestionnaireResponseProvider).value;
  final launchContext = ref.watch(launchContextProvider).value;

  // null = loading. non-null means valid data. error would throw.
  if (questionnaire != null && launchContext != null) {
    // Only output valid inputs. Recipient can rely on validity.
    if (questionnaire.hasError ||
        (questionnaireResponse?.hasError ?? false) ||
        launchContext.hasError) {
      return null;
    }

    return FillerInputs(
      questionnaire,
      questionnaireResponse,
      launchContext,
    );
  } else {
    return null;
  }
});

final fillerOutputProvider =
    StateNotifierProvider<FhirResourceNotifier, AsyncValue<FhirResource>>(
        (ref) {
  return FhirResourceNotifier(null);
});

void main() {
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

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final splitViewThemeData = MultiSplitViewThemeData(
  dividerPainter: DividerPainters.grooved1(
    color: Colors.indigo[100]!,
    highlightedColor: Colors.indigo[900],
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _overallSplitController = MultiSplitViewController(
    areas: Area.weights([0.3, 0.35, 0.35]),
  );

  final _inputPanelSplitController = MultiSplitViewController(
    areas: Area.weights([0.2, 0.4, 0.4]),
  );

  @override
  Widget build(BuildContext context) {
    final fillerInputs = ref.watch(fillerInputsProvider);

    final questionnairePanel = (fillerInputs != null)
        ? QuestionnaireScrollerPanel(
            fillerInputs.questionnaire.resource! as Questionnaire,
            fillerInputs.questionnaireResponse?.resource
                as QuestionnaireResponse?,
            LaunchContext(
              patient: fillerInputs.launchContext.resource! as Patient,
            ),
            fillerOutputProvider,
            key: ValueKey<String>(fillerInputs.hashCode.toString()),
          )
        : const CircularProgressIndicator();

    final inputsPanel = MultiSplitView(
      axis: Axis.vertical,
      controller: _inputPanelSplitController,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: FhirResourceEditor(
            'Launch Context',
            launchContextProvider,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: FhirResourceEditor(
            'Questionnaire',
            questionnaireProvider,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: FhirResourceEditor(
            'populate with QuestionnaireResponse',
            populateQuestionnaireResponseProvider,
          ),
        ),
      ],
    );

    final themedInputsPanel = MultiSplitViewTheme(
      data: splitViewThemeData,
      child: inputsPanel,
    );

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
        child: MultiSplitViewTheme(
          data: splitViewThemeData,
          child: MultiSplitView(
            controller: _overallSplitController,
            children: [
              themedInputsPanel,
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: questionnairePanel,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: FhirResourceEditor(
                  'Output QuestionnaireResponse',
                  fillerOutputProvider,
                  showSubmitButton: false,
                  fhirPathOutputMinLines: 15,
                  fhirPathOutputMaxLines: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
