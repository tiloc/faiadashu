import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class StringAnswerFiller extends QuestionnaireAnswerFiller {
  StringAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState extends QuestionnaireAnswerFillerState<String,
    StringAnswerFiller, StringAnswerModel> {
  final _editingController = TextEditingController();
  late final TextInputType _keyboardType;

  _StringAnswerState();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void postInitState() {
    final initialValue = value ?? '';

    _editingController.value = TextEditingValue(
      text: initialValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: initialValue.length),
      ),
    );

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
        controller: _editingController,
        maxLines: (qi.type == QuestionnaireItemType.text)
            ? questionnaireTheme.maxLinesForTextItem
            : 1,
        decoration: questionnaireTheme.createDecoration().copyWith(
              errorText: answerModel.errorText,
              errorStyle: (itemModel
                      .isCalculated) // Force display of error text on calculated item
                  ? TextStyle(
                      color: Theme.of(context).errorColor,
                    )
                  : null,
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
