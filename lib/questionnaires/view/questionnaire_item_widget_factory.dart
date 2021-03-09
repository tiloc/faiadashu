import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

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
      case QuestionnaireItemType.group:
        return GroupItemWidget(location, decorator, key: key);
      default:
        throw ArgumentError(
            'Unsupported item type: ${location.questionnaireItem.type}');
    }
  }
}
