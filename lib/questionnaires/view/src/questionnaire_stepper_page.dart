import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:flutter/material.dart';

/// A page, incl. a [Scaffold], that presents a questionnaire in the style of a wizard.
///
/// see [QuestionnaireStepper]
/// see [QuestionnaireScrollerPage]
class QuestionnaireStepperPage extends QuestionnaireStepper {
  const QuestionnaireStepperPage({
    Locale? locale,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
    QuestionnaireModelDefaults questionnaireModelDefaults =
        const QuestionnaireModelDefaults(),
    Key? key,
  }) : super(
          locale: locale,
          scaffoldBuilder: const DefaultQuestionnairePageScaffoldBuilder(),
          fhirResourceProvider: fhirResourceProvider,
          launchContext: launchContext,
          questionnaireModelDefaults: questionnaireModelDefaults,
          key: key,
        );

  @override
  State<StatefulWidget> createState() => QuestionnaireStepperState();
}
