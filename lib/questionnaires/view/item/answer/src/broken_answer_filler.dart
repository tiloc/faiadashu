import 'package:faiadashu/questionnaires/model/item/answer/answer.dart';
import 'package:faiadashu/questionnaires/view/view.dart';
import 'package:flutter/material.dart';

/// Visualize a broken [QuestionnaireAnswerFiller].
class BrokenAnswerFiller extends QuestionnaireAnswerFiller {
  final Object exception;

  BrokenAnswerFiller(
      super.answerModel,
    this.exception, {
        super.key,
  });

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
      widget.questionnaireItemModel.questionnaireItem,
      widget.exception,
    );
  }
}
