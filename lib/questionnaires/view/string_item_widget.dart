import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';
import 'questionnaire_item_filler.dart';

class StringItemWidget extends QuestionnaireItemFiller {
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
  QuestionnaireResponseAnswer? createAnswer() =>
      QuestionnaireResponseAnswer(valueString: value);
}
