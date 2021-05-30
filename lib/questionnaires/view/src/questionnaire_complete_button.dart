import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import 'questionnaire_filler.dart';

/// A button to complete a questionnaire.
///
/// Toggles from Complete / In-Progress
class QuestionnaireCompleteButton extends StatefulWidget {
  const QuestionnaireCompleteButton({Key? key}) : super(key: key);

  @override
  _QuestionnaireCompleteButtonState createState() =>
      _QuestionnaireCompleteButtonState();
}

class _QuestionnaireCompleteButtonState
    extends State<QuestionnaireCompleteButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final currentResponseStatus =
            QuestionnaireFiller.of(context).questionnaireModel.responseStatus;

        setState(() {
          QuestionnaireFiller.of(context).questionnaireModel.responseStatus =
              (currentResponseStatus == QuestionnaireResponseStatus.completed)
                  ? QuestionnaireResponseStatus.in_progress
                  : QuestionnaireResponseStatus.completed;
        });
      },
      icon:
          (QuestionnaireFiller.of(context).questionnaireModel.responseStatus !=
                  QuestionnaireResponseStatus.completed)
              ? const Icon(Icons.check_circle)
              : const Icon(Icons.edit),
      label:
          (QuestionnaireFiller.of(context).questionnaireModel.responseStatus !=
                  QuestionnaireResponseStatus.completed)
              ? const Text('Complete')
              : const Text('Amend'),
    );
  }
}
