import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
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
  late final RegExp? _regExp;
  late final int _minLength;
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
    initialValue = widget.answerLocation.answer?.valueString;
    _controller.text = value ?? '';

    final _regexPattern = qi.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/regex')
        ?.valueString;

    if (_regexPattern != null) {
      _regExp = RegExp(_regexPattern, unicode: true);
    } else {
      _regExp = null;
    }

    _minLength = qi.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/minLength')
            ?.valueInteger
            ?.value ??
        0;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  String? _validate(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (inputValue.length < _minLength) {
      return 'Enter $_minLength or more characters.';
    }

    if (qi.type == QuestionnaireItemType.url) {
      if (!RegExp(
              r'^(http|https|ftp|sftp)://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+')
          .hasMatch(inputValue)) {
        return 'Enter a valid URL.';
      }
    }

    if (_regExp != null) {
      if (!_regExp!.hasMatch(inputValue)) {
        if (entryFormat != null) {
          return "Provide as '$entryFormat'";
        } else {
          return 'Provide a valid answer.';
        }
      }
    }

    return null;
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
          validator: (inputValue) => _validate(inputValue),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (content) {
            value = content;
          },
          maxLength: qi.maxLength?.value,
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
