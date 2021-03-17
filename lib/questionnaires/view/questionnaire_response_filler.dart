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
    // TODO(tiloc): Handle a list of answers.
    value = [answer];
  }

  /// Special functionality to allow choice and open-choice items with "repeats".
  void stashChoiceAnswers(
      int answerIndex, List<QuestionnaireResponseAnswer?>? answers) {
    value = answers ?? [];
  }

  /// Fill the response with all the answers which are not null.
  /// Return null if no such answers exist.
  QuestionnaireResponseItem? fillResponse() {
    final filledAnswers = _answers
        .where((answer) => answer != null)
        .map<QuestionnaireResponseAnswer>((answer) => answer!)
        .toList(growable: false);

    if (filledAnswers.isEmpty) {
      return null;
    }
    return QuestionnaireResponseItem(
        linkId: widget.location.linkId,
        text: widget.location.questionnaireItem.text,
        answer: filledAnswers);
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
    // TODO(tiloc) show a list of answers, and buttons to add/remove if repeat
    return _answerFillers[0];
  }
}

/// A place where [QuestionnaireAnswerFiller]s can stash their result.
/// Provides isolation from underlying response filler and answers.
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

  /// Special functionality to allow choice and open-choice items with "repeats".
  void stashChoiceAnswers(List<QuestionnaireResponseAnswer?>? answers) {
    _responseState.stashChoiceAnswers(_answerIndex, answers);
  }

  QuestionnaireResponseAnswer? get answer =>
      _responseState._answers[_answerIndex];
}
