import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class StringAnswerFiller extends QuestionnaireAnswerFiller {
  StringAnswerFiller(
    AnswerModel answerModel, {
    Key? key,
  }) : super(answerModel, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState extends QuestionnaireAnswerFillerState<String,
    StringAnswerFiller, StringAnswerModel> {
  final _editingController = TextEditingController();

  _StringAnswerState();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void postInitState() {
    final initialValue = answerModel.value ?? '';

    _editingController.value = TextEditingValue(
      text: initialValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: initialValue.length),
      ),
    );
  }

  @override
  Widget createInputControl() => _StringAnswerInputControl(
        answerModel,
        focusNode: firstFocusNode,
        editingController: _editingController,
      );
}

class _StringAnswerInputControl extends AnswerInputControl<StringAnswerModel> {
  final TextEditingController editingController;

  const _StringAnswerInputControl(
    StringAnswerModel answerModel, {
    required this.editingController,
    FocusNode? focusNode,
    Key? key,
  }) : super(
          answerModel,
          focusNode: focusNode,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final answerModel = this.answerModel;
    final keyboardType = const {
      StringAnswerKeyboard.plain: TextInputType.text,
      StringAnswerKeyboard.email: TextInputType.emailAddress,
      StringAnswerKeyboard.phone: TextInputType.phone,
      StringAnswerKeyboard.number: TextInputType.number,
      StringAnswerKeyboard.url: TextInputType.url,
      StringAnswerKeyboard.multiline: TextInputType.multiline,
    }[answerModel.keyboard]!;

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        height: 72, // Same height with and without error text
        child: TextFormField(
          focusNode: focusNode,
          enabled: answerModel.isControlEnabled,
          keyboardType: keyboardType,
          controller: editingController,
          maxLines: (qi.type == QuestionnaireItemType.text)
              ? QuestionnaireTheme.of(context).maxLinesForTextItem
              : 1,
          decoration: InputDecoration(
            errorText: answerModel.displayErrorText,
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
            answerModel.value = content;
          },
          maxLength: answerModel.maxLength,
        ),
      ),
    );
  }
}
