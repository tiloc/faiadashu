import 'package:faiadashu/faiadashu.dart';
import 'package:flutter/material.dart';

/// Display a narrative on a dedicated page.
class NarrativePage extends StatelessWidget {
  final QuestionnaireModel? questionnaireModel;
  const NarrativePage({this.questionnaireModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NarrativeTile(questionnaireModel: questionnaireModel),
    );
  }
}
