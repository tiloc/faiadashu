import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class QuestionnaireAnswerFillerFactory {
  static QuestionnaireAnswerFiller fromQuestionnaireItem(
      QuestionnaireLocation location, AnswerLocation answerLocation) {
    switch (location.questionnaireItem.type!) {
      case QuestionnaireItemType.choice:
      case QuestionnaireItemType.open_choice:
        return ChoiceItemAnswer(location, answerLocation);
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        return NumericalItemAnswer(location, answerLocation);
      case QuestionnaireItemType.string:
      case QuestionnaireItemType.text:
        return StringItemAnswer(location, answerLocation);
      case QuestionnaireItemType.group:
        return GroupItemAnswer(location, answerLocation);
      case QuestionnaireItemType.date:
      case QuestionnaireItemType.datetime:
      case QuestionnaireItemType.time:
        return DateTimeItemAnswer(location, answerLocation);
      case QuestionnaireItemType.boolean:
        return BooleanItemAnswer(location, answerLocation);
      case QuestionnaireItemType.display:
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
      case QuestionnaireItemType.url:
        return _UnsupportedItem(location, answerLocation);
    }
  }
}

class _UnsupportedItem extends QuestionnaireAnswerFiller {
  const _UnsupportedItem(
      QuestionnaireLocation location, AnswerLocation answerLocation)
      : super(location, answerLocation);

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
