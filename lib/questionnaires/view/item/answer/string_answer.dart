import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../../../questionnaires.dart';
import '../questionnaire_answer_filler.dart';

class StringAnswer extends QuestionnaireAnswerFiller {
  const StringAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState
    extends QuestionnaireAnswerState<String, StringAnswer> {
  _StringAnswerState();

  @override
  void initState() {
    super.initState();
    initialValue = widget.answerLocation.answer?.valueString;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  @override
  Widget buildEditable(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: TextFormField(
          initialValue: value,
          maxLines: (widget.location.questionnaireItem.type ==
                  QuestionnaireItemType.text)
              ? 4
              : 1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (content) {
            value = content;
          },
          maxLength: widget.location.questionnaireItem.maxLength?.value,
        ));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    return (value != null && value!.isNotEmpty)
        ? QuestionnaireResponseAnswer(valueString: value)
        : null;
  }
}
