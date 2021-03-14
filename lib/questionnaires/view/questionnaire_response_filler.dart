import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

/// A Widget to fill a [QuestionnaireResponseItem].
class QuestionnaireResponseFiller extends StatefulWidget {
  final QuestionnaireLocation location;

  QuestionnaireResponseFiller(this.location)
      : super(key: ValueKey<String>(location.linkId));

  @override
  State<StatefulWidget> createState() => QuestionnaireResponseState();
}

class QuestionnaireResponseState extends State<QuestionnaireResponseFiller> {
  List<QuestionnaireAnswerFiller> _answerFillers = [];
  List<QuestionnaireResponseAnswer?> _answers = [];

  QuestionnaireResponseState();

  @override
  void initState() {
    super.initState();
    _answerFillers = [
      QuestionnaireAnswerFillerFactory.fromQuestionnaireItem(
          widget.location, this, 0)
    ];

    _answers = [null];
  }

  void fillAnswer(int answerIndex, QuestionnaireResponseAnswer? answer) {
    // TODO(tiloc): This can only handle a single answer
    value = [answer];
  }

  QuestionnaireResponseItem? fillResponse() {
    final answer = _answers[0];
    return (answer != null)
        ? QuestionnaireResponseItem(
            linkId: widget.location.linkId,
            text: widget.location.questionnaireItem.text,
            answer: [answer])
        : null;
  }

  set value(List<QuestionnaireResponseAnswer?> newValue) {
    if (mounted) {
      setState(() {
        _answers = newValue;
      });
    }
    // Bubble up the response
    widget.location.responseItem = fillResponse();
  }

  List<QuestionnaireResponseAnswer?> get value => _answers;

  @override
  Widget build(BuildContext context) {
    return _answerFillers[0];
  }
}
