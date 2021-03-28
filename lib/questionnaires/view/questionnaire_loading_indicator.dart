import 'package:flutter/material.dart';

/// Loading indicator during retrieval / decoding of a questionnaire.
class QuestionnaireLoadingIndicator extends StatelessWidget {
  const QuestionnaireLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
