import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

class BooleanAnswerFiller extends QuestionnaireAnswerFiller {
  const BooleanAnswerFiller(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation,
      {Key? key})
      : super(itemModel, answerLocation, key: key);
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
          focusNode: firstFocusNode,
          value: value?.value,
          tristate: true,
          onChanged: (newValue) {
            value = (newValue != null) ? Boolean(newValue) : null;
          },
        ));
  }
}
