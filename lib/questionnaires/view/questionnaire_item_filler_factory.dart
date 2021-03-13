import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class QuestionnaireItemFillerFactory {
  static QuestionnaireItemFiller fromQuestionnaireItem(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key}) {
    switch (location.questionnaireItem.type!) {
      case QuestionnaireItemType.choice:
      case QuestionnaireItemType.open_choice:
        return ChoiceItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        return NumericalItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.string:
      case QuestionnaireItemType.text:
        return StringItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.group:
        return GroupItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.date:
      case QuestionnaireItemType.datetime:
      case QuestionnaireItemType.time:
        return DateTimeItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.boolean:
        return BooleanItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.display:
      case QuestionnaireItemType.attachment:
      case QuestionnaireItemType.unknown:
      case QuestionnaireItemType.reference:
      case QuestionnaireItemType.url:
        return _UnsupportedItemWidget(location);
    }
  }
}

class _UnsupportedItemWidget extends QuestionnaireItemFiller {
  const _UnsupportedItemWidget(QuestionnaireLocation location, {Key? key})
      : super(location, const DefaultQuestionnaireItemDecorator(), key: key);

  @override
  State<StatefulWidget> createState() => _UnsupportedItemState();
}

class _UnsupportedItemState extends State<_UnsupportedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Text(widget.location.questionnaireItem.toJson().toString()),
    );
  }
}
