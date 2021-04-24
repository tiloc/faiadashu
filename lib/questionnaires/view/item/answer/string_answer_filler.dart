import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../model/item/answer/string_answer_model.dart';
import '../../../questionnaires.dart';
import '../questionnaire_answer_filler.dart';

class StringAnswerFiller extends QuestionnaireAnswerFiller {
  const StringAnswerFiller(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState extends QuestionnaireAnswerState<String,
    StringAnswerFiller, StringAnswerModel> {
  final _controller = TextEditingController();

  _StringAnswerState();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void postInitState() {
    _controller.text = value ?? '';
  }

  @override
  Widget buildEditable(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: _controller,
          maxLines: (qi.type == QuestionnaireItemType.text) ? 4 : 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: answerModel.entryFormat,
          ),
          validator: (inputValue) => answerModel.validate(inputValue),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (content) {
            value = content;
          },
          maxLength: answerModel.maxLength,
        ));
  }
}
