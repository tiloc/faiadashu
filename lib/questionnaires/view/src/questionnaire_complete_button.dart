import 'package:fhir/r4/r4.dart' show QuestionnaireResponseStatus;
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../questionnaires.dart' show QuestionnaireResponseFiller;

/// A button to complete a questionnaire.
///
/// Toggles from Complete / In-Progress
/// Requires a [QuestionnaireResponseFiller]
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
      onPressed: () async {
        final qf = QuestionnaireResponseFiller.of(context);
        final qm = qf.questionnaireResponseModel;
        final currentResponseStatus = qm.responseStatus;

        if (currentResponseStatus != QuestionnaireResponseStatus.completed) {
          final isComplete = await qm.isQuestionnaireComplete;
          qm.isValid.value = isComplete;

          if (!isComplete) {
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
      icon: (QuestionnaireResponseFiller.of(context)
                  .questionnaireResponseModel
                  .responseStatus !=
              QuestionnaireResponseStatus.completed)
          ? const Icon(Icons.check_circle)
          : const Icon(Icons.edit),
      label: (QuestionnaireResponseFiller.of(context)
                  .questionnaireResponseModel
                  .responseStatus !=
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
