import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

class BooleanAnswerFiller extends QuestionnaireAnswerFiller {
  const BooleanAnswerFiller(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _BooleanItemState();
}

class _BooleanItemState extends QuestionnaireAnswerState<Boolean,
    BooleanAnswerFiller, BooleanAnswerModel> {
  _BooleanItemState();

  @override
  void postInitState() {
    // Intentionally do nothing.
  }

  @override
  Widget buildEditable(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Checkbox(
          value: value?.value,
          tristate: true,
          onChanged: (newValue) {
            value = (newValue != null) ? Boolean(newValue) : null;
          },
        ));
  }
}
