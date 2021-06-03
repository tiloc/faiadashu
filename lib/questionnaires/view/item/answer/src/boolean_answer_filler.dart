import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../questionnaires.dart';

class BooleanAnswerFiller extends QuestionnaireAnswerFiller {
  BooleanAnswerFiller(
      QuestionnaireResponseFillerState responseFillerState, int answerIndex,
      {Key? key})
      : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _BooleanItemState();
}

class _BooleanItemState extends QuestionnaireAnswerFillerState<Boolean,
    BooleanAnswerFiller, BooleanAnswerModel> {
  _BooleanItemState();

  @override
  void postInitState() {
    // Intentionally do nothing.
  }

  @override
  Widget buildInputControl(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Checkbox(
          focusNode: firstFocusNode,
          value: value?.value,
          tristate: true,
          onChanged: (answerModel.isEnabled)
              ? (newValue) {
                  firstFocusNode.requestFocus();
                  value = (newValue != null) ? Boolean(newValue) : null;
                }
              : null,
        ));
  }
}
