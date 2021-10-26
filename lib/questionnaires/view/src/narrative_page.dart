import 'package:faiadashu/faiadashu.dart';
import 'package:flutter/material.dart';

/// Display a narrative on a dedicated page.
class NarrativePage extends StatelessWidget {
  final QuestionnaireModel? questionnaireModel;
  const NarrativePage({this.questionnaireModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FDashLocalizations.of(context).narrativePageTitle),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: NarrativeTile(questionnaireModel: questionnaireModel),
        ),
      ),
    );
  }
}
