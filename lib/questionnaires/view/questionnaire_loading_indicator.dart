import 'package:flutter/material.dart';

import '../model/questionnaire_location.dart';

/// Loading indicator during retrieval / decoding of a questionnaire.
class QuestionnaireLoadingIndicator extends StatelessWidget {
  final String state;
  final String detail;
  final bool hasError;

  QuestionnaireLoadingIndicator(
      AsyncSnapshot<QuestionnaireTopLocation> snapshot,
      {Key? key})
      : state = snapshot.connectionState.toString(),
        hasError = snapshot.hasError,
        detail = (snapshot.hasData)
            ? snapshot.data!.linkId
            : snapshot.error.toString(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: hasError ? Colors.amber : null,
        child: Column(children: [
          const CircularProgressIndicator(),
          Text(state),
          Text(detail),
        ]));
  }
}
