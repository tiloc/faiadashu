import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';
import 'questionnaire_answer_filler.dart';

class StringItemAnswer extends QuestionnaireAnswerFiller {
  const StringItemAnswer(QuestionnaireLocation location,
      QuestionnaireResponseState responseState, int answerIndex,
      {Key? key})
      : super(location, responseState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _StringItemState();
}

class _StringItemState
    extends QuestionnaireAnswerState<String, StringItemAnswer> {
  _StringItemState() : super(null);

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  @override
  Widget buildEditable(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: widget.location.questionnaireItem.text),
      onChanged: (content) {
        value = content;
      },
    );
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
      QuestionnaireResponseAnswer(valueString: value);
}
