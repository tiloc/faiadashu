import 'package:faiadashu/faiadashu.dart';
import 'package:flutter/material.dart';

/// Display a narrative on a dedicated page.
class NarrativePage extends StatelessWidget {
  final QuestionnaireTopLocation? topLocation;
  const NarrativePage({this.topLocation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NarrativeTile(topLocation: topLocation),
    );
  }
}
