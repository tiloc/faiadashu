import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:flutter/material.dart';

/// Loading indicator during retrieval / decoding of a questionnaire.
class QuestionnaireLoadingIndicator extends StatelessWidget {
  final ConnectionState state;
  final Object? detail;
  final bool hasError;

  QuestionnaireLoadingIndicator(
    AsyncSnapshot<QuestionnaireResponseModel> snapshot, {
    super.key,
  })  : state = snapshot.connectionState,
        hasError = snapshot.hasError,
        detail = (snapshot.hasData)
            ? snapshot.data?.questionnaireModel.title
            : snapshot.error;

  @override
  Widget build(BuildContext context) {
    const shortAxis = 50.0;

    return Card(
      color: hasError ? Colors.amber : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasError)
            const Icon(
              Icons.error,
              color: Colors.red,
            )
          else
            SizedBox(
              width: shortAxis,
              height: shortAxis,
              child: CircularProgressIndicator(
                semanticsLabel:
                    FDashLocalizations.of(context).progressQuestionnaireLoading,
              ),
            ),
          const SizedBox(
            height: 16,
          ),
          if (detail != null)
            Text(
              detail.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
    );
  }
}
