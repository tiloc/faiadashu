import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'questionnaire_item_widget.dart';

class StringItemWidget extends QuestionnaireItemWidget {
  const StringItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _StringItemState();
}

class _StringItemState
    extends QuestionnaireItemState<String, StringItemWidget> {
  _StringItemState() : super(null);

  @override
  Widget buildBodyReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  @override
  Widget buildBodyEditable(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: widget.location.questionnaireItem.text),
      onChanged: (content) {
        value = content;
        createResponse();
      },
    );
  }

  @override
  QuestionnaireResponseItem createResponse() {
    return QuestionnaireResponseItem(
        linkId: widget.location.linkId,
        text: widget.location.questionnaireItem.text,
        answer: [QuestionnaireResponseAnswer(valueString: value)]);
  }
}
