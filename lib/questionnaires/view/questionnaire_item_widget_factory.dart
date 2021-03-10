import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';
import 'package:widgets_on_fhir/questionnaires/view/string_item_widget.dart';

class QuestionnaireItemWidgetFactory {
  static QuestionnaireItemWidget fromQuestionnaireItem(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key}) {
    switch (location.questionnaireItem.type) {
      case QuestionnaireItemType.choice:
        return ChoiceItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.quantity:
      case QuestionnaireItemType.decimal:
      case QuestionnaireItemType.integer:
        return NumericalItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.string:
        return StringItemWidget(location, decorator, key: key);
      case QuestionnaireItemType.group:
        return GroupItemWidget(location, decorator, key: key);
      default:
        return _UnsupportedItemWidget(location);
    }
  }
}

class _UnsupportedItemWidget extends QuestionnaireItemWidget {
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
