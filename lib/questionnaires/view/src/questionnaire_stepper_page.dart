import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

/// A page, incl. a [Scaffold], that presents a questionnaire in the style of a wizard.
///
/// see [QuestionnaireStepper]
/// see [QuestionnaireScrollerPage]
class QuestionnaireStepperPage extends QuestionnaireStepper {
  const QuestionnaireStepperPage({
    super.locale,
    required super.fhirResourceProvider,
    required super.launchContext,
    super.questionnaireModelDefaults,
    super.key,
  }) : super(
          scaffoldBuilder: const DefaultQuestionnairePageScaffoldBuilder(),
        );

  @override
  State<StatefulWidget> createState() => QuestionnaireStepperState();
}
