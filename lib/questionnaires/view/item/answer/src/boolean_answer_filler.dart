import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class BooleanAnswerFiller extends QuestionnaireAnswerFiller {
  BooleanAnswerFiller(
    AnswerModel answerModel, {
    Key? key,
  }) : super(answerModel, key: key);
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
  Widget createInputControl() => _BooleanInputControl(
        answerModel,
        focusNode: firstFocusNode,
      );
}

class _BooleanInputControl extends AnswerInputControl<BooleanAnswerModel> {
  const _BooleanInputControl(
    BooleanAnswerModel answerModel, {
    FocusNode? focusNode,
  }) : super(
          answerModel,
          focusNode: focusNode,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Checkbox(
          focusNode: focusNode,
          value: (answerModel.isTriState)
              ? answerModel.value?.value
              : (answerModel.value?.value != null),
          activeColor: (answerModel.displayErrorText != null)
              ? Theme.of(context).errorColor
              : null,
          tristate: answerModel.isTriState,
          onChanged: (answerModel.isControlEnabled)
              ? (newValue) {
                  focusNode?.requestFocus();
                  answerModel.value = answerModel.isTriState
                      ? ((newValue != null) ? Boolean(newValue) : null)
                      : (newValue ?? false)
                          ? Boolean(true)
                          : null;
                }
              : null,
        ),
        if (answerModel.displayErrorText != null)
          Text(
            answerModel.displayErrorText!,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).errorColor),
          ),
      ],
    );
  }
}
