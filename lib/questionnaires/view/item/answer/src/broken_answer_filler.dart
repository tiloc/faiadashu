import 'package:flutter/material.dart';

import '../../../../model/item/answer/src/answer_model.dart';
import '../../../view.dart';

/// Visualize a broken [QuestionnaireAnswerFiller].
class BrokenAnswerFiller extends QuestionnaireAnswerFiller {
  final Object exception;

  BrokenAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel,
    this.exception, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);

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
