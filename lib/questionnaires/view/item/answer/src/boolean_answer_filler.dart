import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class BooleanAnswerFiller extends QuestionnaireAnswerFiller {
  BooleanAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);
  @override
  State<StatefulWidget> createState() => _BooleanItemState();
}

class _BooleanItemState extends QuestionnaireAnswerFillerState<Boolean,
    BooleanAnswerFiller, BooleanAnswerModel> {
  _BooleanItemState();

  @override
  // ignore: no-empty-block
  void postInitState() {
    // Intentionally do nothing.
  }

  @override
  Widget buildInputControl(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          ),
      ],
    );
  }
}
