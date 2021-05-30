import 'package:flutter/material.dart';

import '../../../view.dart';
import 'questionnaire_answer_filler.dart';

/// Visualize a broken [QuestionnaireAnswerFiller].
class BrokenAnswerFiller extends QuestionnaireAnswerFiller {
  final Object exception;

  BrokenAnswerFiller(QuestionnaireResponseFillerState responseFillerState,
      int answerIndex, this.exception,
      {Key? key})
      : super(responseFillerState, answerIndex, key: key);

  @override
  State<StatefulWidget> createState() => _BrokenItemState();
}

class _BrokenItemState extends State<BrokenAnswerFiller> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BrokenQuestionnaireItem(
        'Could not initialize QuestionnaireAnswerFiller',
        widget.itemModel.questionnaireItem,
        widget.exception);
  }
}
