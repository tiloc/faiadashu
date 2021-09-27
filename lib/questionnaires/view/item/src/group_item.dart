import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

/// A pseudo-filler for items of type "group".
class GroupItem extends QuestionnaireAnswerFiller {
  GroupItem(
    QuestionnaireResponseFillerState responseFillerState,
    int answerIndex, {
    Key? key,
  }) : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  _GroupItemState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }
}
