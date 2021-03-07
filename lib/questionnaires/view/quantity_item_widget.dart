import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'questionnaire_item_widget.dart';

class QuantityItemWidget extends QuestionnaireItemWidget {
  const QuantityItemWidget(
      QuestionnaireLocation ocation, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(ocation, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _QuantityItemState();
}

class _QuantityItemState extends QuestionnaireItemState {
  _QuantityItemState();

  @override
  Widget buildBody(BuildContext context) {
    return Text(widget.location.questionnaireItem.text!);
  }
}
