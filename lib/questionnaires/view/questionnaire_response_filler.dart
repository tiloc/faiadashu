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
    // TODO(tiloc): This is currently limited to a single answer
    _answerFillers = [
      QuestionnaireAnswerFillerFactory.fromQuestionnaireItem(
          widget.location, AnswerLocation._(this, 0))
    ];

    final int? answerCount = widget.location.responseItem?.answer?.length;
    if (answerCount != null && answerCount > 0) {
      _answers = [widget.location.responseItem!.answer![0]];
    } else {
      _answers = [null];
    }
  }

  void stashAnswer(int answerIndex, QuestionnaireResponseAnswer? answer) {
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

/// A cubbyhole where [QuestionnaireAnswerFiller]s can stash their result.
class AnswerLocation {
  final QuestionnaireResponseState _responseState;
  final int _answerIndex;
  const AnswerLocation._(
      QuestionnaireResponseState responseState, int answerIndex)
      : _responseState = responseState,
        _answerIndex = answerIndex;

  void stashAnswer(QuestionnaireResponseAnswer? answer) {
    _responseState.stashAnswer(_answerIndex, answer);
  }

  QuestionnaireResponseAnswer? get answer =>
      _responseState._answers[_answerIndex];
}
