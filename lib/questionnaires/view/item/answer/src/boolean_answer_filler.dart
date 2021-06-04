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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 8,
      ),
      Checkbox(
        focusNode: firstFocusNode,
        value: value?.value,
        activeColor: (answerModel.errorText != null)
            ? Theme.of(context).errorColor
            : null,
        tristate: true,
        onChanged: (answerModel.isEnabled)
            ? (newValue) {
                firstFocusNode.requestFocus();
                value = (newValue != null) ? Boolean(newValue) : null;
              }
            : null,
      ),
      if (answerModel.errorText != null)
        Text(
          answerModel.errorText!,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Theme.of(context).errorColor),
        )
    ]);
  }
}
