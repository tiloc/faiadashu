import 'package:fhir/r4/r4.dart' show QuestionnaireResponseStatus;
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
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
          final isComplete = qm.isQuestionnaireComplete;
          qm.errorFlags.value = isComplete;

          if (isComplete != null) {
            return;
          }
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
              ? Text(
                  FDashLocalizations.of(context)
                      .responseStatusToCompleteButtonLabel,
                )
              : Text(
                  FDashLocalizations.of(context)
                      .responseStatusToInProgressButtonLabel,
                ),
    );
  }
}
