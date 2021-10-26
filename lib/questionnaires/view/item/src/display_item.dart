import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

/// A pseudo-filler for items of type "display".
class DisplayItem extends QuestionnaireAnswerFiller {
  DisplayItem(
    QuestionnaireResponseFillerState responseFillerState,
    int answerIndex, {
    Key? key,
  }) : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _DisplayItemState();
}

class _DisplayItemState extends State<DisplayItem> {
  _DisplayItemState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }
}
