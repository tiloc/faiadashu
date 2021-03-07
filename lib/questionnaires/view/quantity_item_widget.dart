import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
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
  _QuantityItemState() : super(null);

  @override
  Widget buildBodyEditable(BuildContext context) {
    return Text(widget.location.questionnaireItem.text!);
  }

  @override
  QuestionnaireResponseItem createResponse() {
    // TODO: implement createResponse
    throw UnimplementedError();
  }
}
