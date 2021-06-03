import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../../questionnaires.dart' show QuestionnaireFiller;

/// A button to complete a questionnaire.
///
/// Toggles from Complete / In-Progress
/// Requires a [QuestionnaireFiller]
class QuestionnaireCompleteButton extends StatefulWidget {
  final VoidCallback? onCompleted;

  const QuestionnaireCompleteButton({this.onCompleted, Key? key})
      : super(key: key);

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
        final qf = QuestionnaireFiller.of(context);
        final qm = qf.questionnaireModel;
        final currentResponseStatus = qm.responseStatus;

        if (currentResponseStatus != QuestionnaireResponseStatus.completed) {
          qm.markers.value = qm.isQuestionnaireComplete;
        }

        final newResponseStatus =
            (currentResponseStatus == QuestionnaireResponseStatus.completed)
                ? QuestionnaireResponseStatus.in_progress
                : QuestionnaireResponseStatus.completed;

        setState(() {
          qm.responseStatus = newResponseStatus;
        });

        if (newResponseStatus == QuestionnaireResponseStatus.completed) {
          widget.onCompleted?.call();
        }
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
