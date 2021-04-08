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
  late final String? _humanPattern;
  late final RegExp? _regExp;

  _StringAnswerState();

  @override
  void initState() {
    super.initState();
    initialValue = widget.answerLocation.answer?.valueString;

    _humanPattern = widget.location.questionnaireItem.extension_
        ?.extensionOrNull('http://hl7.org/fhir/StructureDefinition/regex')
        ?.valueString;

    if (_humanPattern != null) {
      _regExp = RegExp(
          '^$_humanPattern\$'
              .replaceAll(RegExp('N'), r'\d')
              .replaceAll(RegExp('A'), r"[\p{L}]"),
          caseSensitive: false,
          unicode: true);
    } else {
      _regExp = null;
    }
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  String? _validate(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (_regExp != null) {
      if (!_regExp!.hasMatch(inputValue)) {
        return "Enter as '$_humanPattern'";
      }
    }

    return null;
  }

  @override
  Widget buildEditable(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: TextFormField(
          initialValue: value,
          maxLines: (widget.location.questionnaireItem.type ==
                  QuestionnaireItemType.text)
              ? 4
              : 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: entryFormat ?? _humanPattern,
          ),
          validator: (inputValue) => _validate(inputValue),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (content) {
            value = content;
          },
          maxLength: widget.location.questionnaireItem.maxLength?.value,
        ));
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    return (value != null && value!.isNotEmpty)
        ? QuestionnaireResponseAnswer(valueString: value)
        : null;
  }
}
