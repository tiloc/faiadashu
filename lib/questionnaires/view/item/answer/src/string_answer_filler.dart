import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../questionnaires.dart';
import 'questionnaire_answer_filler.dart';

class StringAnswerFiller extends QuestionnaireAnswerFiller {
  StringAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    int answerIndex, {
    Key? key,
  }) : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState extends QuestionnaireAnswerFillerState<String,
    StringAnswerFiller, StringAnswerModel> {
  final _controller = TextEditingController();
  late final TextInputType _keyboardType;

  _StringAnswerState();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void postInitState() {
    _controller.text = value ?? '';

    _keyboardType = const {
      StringAnswerKeyboard.plain: TextInputType.text,
      StringAnswerKeyboard.email: TextInputType.emailAddress,
      StringAnswerKeyboard.phone: TextInputType.phone,
      StringAnswerKeyboard.number: TextInputType.number,
      StringAnswerKeyboard.url: TextInputType.url,
      StringAnswerKeyboard.multiline: TextInputType.multiline,
    }[answerModel.keyboard]!;
  }

  @override
  Widget buildInputControl(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextFormField(
        focusNode: firstFocusNode,
        enabled: answerModel.isEnabled,
        keyboardType: _keyboardType,
        controller: _controller,
        maxLines: (qi.type == QuestionnaireItemType.text) ? 4 : 1,
        decoration: questionnaireTheme.createDecoration().copyWith(
              errorText: answerModel.errorText,
              hintText: answerModel.entryFormat,
            ),
        validator: (inputValue) => answerModel.validateInput(inputValue),
        autovalidateMode: AutovalidateMode.always,
        onChanged: (content) {
          value = content;
        },
        maxLength: answerModel.maxLength,
      ),
    );
  }
}
