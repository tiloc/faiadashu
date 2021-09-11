import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../model/model.dart';

/// Loading indicator during retrieval / decoding of a questionnaire.
class QuestionnaireLoadingIndicator extends StatelessWidget {
  final ConnectionState state;
  final Object? detail;
  final bool hasError;

  QuestionnaireLoadingIndicator(
    AsyncSnapshot<QuestionnaireModel> snapshot, {
    Key? key,
  })  : state = snapshot.connectionState,
        hasError = snapshot.hasError,
        detail = (snapshot.hasData) ? snapshot.data?.linkId : snapshot.error,
        super(key: key);

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
              style: Theme.of(context).textTheme.subtitle1,
            ),
        ],
      ),
    );
  }
}
