import 'package:fhir/r4.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../coding/coding.dart';
import '../../../coding/data_absent_reasons.dart';
import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logger.dart';
import '../../questionnaires.dart';
import 'questionnaire_answer_filler_factory.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionnaireResponseFiller extends StatefulWidget {
  final QuestionnaireLocation location;

  QuestionnaireResponseFiller(this.location)
      : super(key: ValueKey<String>(location.linkId));

  @override
  State<StatefulWidget> createState() => QuestionnaireResponseState();
}

class QuestionnaireResponseState extends State<QuestionnaireResponseFiller> {
  late final List<QuestionnaireAnswerFiller> _answerFillers;
  List<QuestionnaireResponseAnswer?> _answers = [];
  static final logger = Logger(QuestionnaireResponseState);

  Code? _dataAbsentReason;

  QuestionnaireResponseItem? get responseItem => widget.location.responseItem;
  set responseItem(QuestionnaireResponseItem? ri) =>
      widget.location.responseItem = ri;

  QuestionnaireResponseState();

  @override
  void initState() {
    super.initState();
    // TODO: Enhancement: Allow repeats = true for other kinds of items
    // This assumes that all answers are of the same kind
    // and repeats = true is only supported for choice items
    _answerFillers = [
      QuestionnaireAnswerFillerFactory.fromQuestionnaireItem(
          widget.location, AnswerLocation._(this, 0))
    ];

    final int? answerCount = responseItem?.answer?.length;
    if (answerCount != null && answerCount > 0) {
      _answers = responseItem!.answer!;
    } else {
      _answers = [null];
    }

    _dataAbsentReason = responseItem?.extension_?.dataAbsentReason;
  }

  void stashAnswer(int answerIndex, QuestionnaireResponseAnswer? answer) {
    // TODO(tiloc): Handle a list of answers.
    if (mounted) {
      setState(() {
        _answers = [answer];
        _dataAbsentReason = answer?.extension_?.dataAbsentReason;
      });
    }
    // Bubble up the response
    responseItem = fillResponse();
  }

  /// Special functionality to allow choice and open-choice items with "repeats".
  void stashCodingAnswers(
      int answerIndex, List<QuestionnaireResponseAnswer?>? answers) {
    if (mounted) {
      setState(() {
        _answers = answers ?? [];
        // This assumes all answers having the same dataAbsentReason.
        final newDataAbsentReason =
            answers?.firstOrNull?.extension_?.dataAbsentReason;
        _dataAbsentReason = newDataAbsentReason;
      });
    }
    // Bubble up the response
    responseItem = fillResponse();
  }

  /// Fill the response with all the answers which are not null.
  /// Return null if no such answers exist.
  QuestionnaireResponseItem? fillResponse() {
    final filledAnswers = _answers
        .where((answer) => answer != null)
        .map<QuestionnaireResponseAnswer>((answer) => answer!)
        .toList(growable: false);

    if (filledAnswers.isEmpty && dataAbsentReason == null) {
      return null;
    }
    final result = QuestionnaireResponseItem(
        linkId: widget.location.linkId,
        text: widget.location.questionnaireItem.text,
        extension_: (_dataAbsentReason != null)
            ? [
                FhirExtension(
                    url: DataAbsentReason.extensionUrl,
                    valueCode: dataAbsentReason)
              ]
            : null,
        // FHIR cannot have empty arrays.
        answer: filledAnswers.isEmpty ? null : filledAnswers);

    return result;
  }

  Code? get dataAbsentReason => _dataAbsentReason;

  set dataAbsentReason(Code? dataAbsentReason) {
    if (mounted) {
      setState(() {
        _dataAbsentReason = dataAbsentReason;
      });
    }
    // Bubble up the response
    responseItem = fillResponse();
  }

  set value(List<QuestionnaireResponseAnswer?> newValue) {
    if (mounted) {
      setState(() {
        _answers = newValue;
      });
    }
    // Bubble up the response
    responseItem = fillResponse();
  }

  List<QuestionnaireResponseAnswer?> get value => _answers;

  /// Is the response 'asked but declined'
  bool get isAskedButDeclined =>
      _dataAbsentReason == DataAbsentReason.askedButDeclinedCode;

  @override
  Widget build(BuildContext context) {
    // TODO(tiloc) show a list of answers, and buttons to add/remove if repeat
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (!isAskedButDeclined) ..._answerFillers,
      if (!widget.location.isReadOnly &&
          widget.location.questionnaireItem.required_ != Boolean(true))
        Row(children: [
          const Text('I choose not to answer'),
          Switch(
            value: isAskedButDeclined,
            onChanged: (bool value) {
              dataAbsentReason =
                  value ? DataAbsentReason.askedButDeclinedCode : null;
            },
          )
        ])
    ]);
  }
}

// TODO(tiloc): This is really a model and also has a smell to it. Eliminate?

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
  void stashCodingAnswers(List<QuestionnaireResponseAnswer?>? answers) {
    _responseState.stashCodingAnswers(_answerIndex, answers);
  }

  QuestionnaireResponseAnswer? get answer =>
      _responseState._answers[_answerIndex];
}
