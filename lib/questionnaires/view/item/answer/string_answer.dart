import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../model/validation/string_validator.dart';
import '../../../questionnaires.dart';
import '../questionnaire_answer_filler.dart';

class StringAnswer extends QuestionnaireAnswerFiller {
  const StringAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _StringAnswerState();
}

class _StringAnswerState
    extends QuestionnaireAnswerState<String, StringAnswer> {
  late final StringValidator _validator;

  final _controller = TextEditingController();

  _StringAnswerState();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _validator = StringValidator(location, entryFormat);

    initialValue = widget.answerLocation.answer?.valueString;
    _controller.text = value ?? '';
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
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
            hintText: entryFormat,
          ),
          validator: (inputValue) => _validator.validate(inputValue),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (content) {
            value = content;
          },
          maxLength: _validator.maxLength,
        ));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    return (value != null && value!.isNotEmpty)
        ? (qi.type != QuestionnaireItemType.url)
            ? QuestionnaireResponseAnswer(valueString: value)
            : QuestionnaireResponseAnswer(valueUri: FhirUri(value))
        : null;
  }
}
