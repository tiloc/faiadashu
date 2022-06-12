import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class StringAnswerFiller extends QuestionnaireAnswerFiller {
  StringAnswerFiller(
      super.answerModel, {
        super.key,
  });
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

    // FIXME: What should be the repaint mechanism for calculated items?
    // (it is getting repainted currently, but further optimization might break that)

    // Calculated items need an automated entry into the text field.
    if (itemModel.isCalculated) {
      final currentValue = answerModel.value ?? '';

      editingController.value = TextEditingValue(
        text: currentValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: currentValue.length),
        ),
      );
    }

    final keyboardType = const {
      StringAnswerKeyboard.plain: TextInputType.text,
      StringAnswerKeyboard.email: TextInputType.emailAddress,
      StringAnswerKeyboard.phone: TextInputType.phone,
      StringAnswerKeyboard.number: TextInputType.number,
      StringAnswerKeyboard.url: TextInputType.url,
      StringAnswerKeyboard.multiline: TextInputType.multiline,
    }[answerModel.keyboard]!;

    final theme = QuestionnaireTheme.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        height: theme.textFieldHeight,
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
            prefixIcon: itemModel.isCalculated
                ? Icon(
                    Icons.calculate,
                    color: (answerModel.displayErrorText != null)
                        ? Theme.of(context).errorColor
                        : null,
                  )
                : null,
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
