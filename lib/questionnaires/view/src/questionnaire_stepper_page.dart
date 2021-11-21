import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';
import '../view.dart';

class QuestionnaireStepperPage extends QuestionnaireStepper {
  const QuestionnaireStepperPage({
    Locale? locale,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
    QuestionnaireTheme questionnaireTheme = const QuestionnaireTheme(),
    Key? key,
  }) : super(
          locale: locale,
          scaffoldBuilder: const DefaultQuestionnairePageScaffoldBuilder(),
          fhirResourceProvider: fhirResourceProvider,
          launchContext: launchContext,
          questionnaireTheme: questionnaireTheme,
          key: key,
        );

  @override
  State<StatefulWidget> createState() => QuestionnaireStepperState();
}
