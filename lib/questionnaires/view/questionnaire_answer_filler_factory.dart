import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class QuestionnaireAnswerFillerFactory {
  static QuestionnaireAnswerFiller fromQuestionnaireItem(
      QuestionnaireLocation location,
      QuestionnaireResponseState responseState,
      int answerIndex) {
    switch (location.questionnaireItem.type!) {
      case QuestionnaireItemType.choice:
      case QuestionnaireItemType.open_choice:
        return ChoiceItemAnswer(location, responseState, answerIndex);
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        return NumericalItemAnswer(location, responseState, answerIndex);
      case QuestionnaireItemType.string:
      case QuestionnaireItemType.text:
        return StringItemAnswer(location, responseState, answerIndex);
      case QuestionnaireItemType.group:
        return GroupItemAnswer(location, responseState, answerIndex);
      case QuestionnaireItemType.date:
      case QuestionnaireItemType.datetime:
      case QuestionnaireItemType.time:
        return DateTimeItemAnswer(location, responseState, answerIndex);
      case QuestionnaireItemType.boolean:
        return BooleanItemAnswer(location, responseState, answerIndex);
      case QuestionnaireItemType.display:
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
      case QuestionnaireItemType.url:
        return _UnsupportedItem(location, responseState, answerIndex);
    }
  }
}

class _UnsupportedItem extends QuestionnaireAnswerFiller {
  const _UnsupportedItem(QuestionnaireLocation location,
      QuestionnaireResponseState responseState, int answerIndex)
      : super(location, responseState, answerIndex);

  @override
  State<StatefulWidget> createState() => _UnsupportedItemState();
}

class _UnsupportedItemState extends State<_UnsupportedItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Text(widget.location.questionnaireItem.toJson().toString()),
    );
  }
}
