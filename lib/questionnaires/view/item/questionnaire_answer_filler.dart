import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../questionnaires.dart';

/// A Widget to fill an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  final QuestionnaireLocation location;
  final AnswerLocation answerLocation;

  const QuestionnaireAnswerFiller(this.location, this.answerLocation,
      {Key? key})
      : super(key: key);
}

abstract class QuestionnaireAnswerState<V, W extends QuestionnaireAnswerFiller>
    extends State<W> {
  static final _abstractLogger = Logger(QuestionnaireAnswerState);
  V? _value;

  QuestionnaireItem get qi => widget.location.questionnaireItem;
  Locale get locale => widget.location.top.locale;
  QuestionnaireTopLocation get top => widget.location.top;
  QuestionnaireLocation get location => widget.location;

  QuestionnaireAnswerState();

  Widget buildReadOnly(BuildContext context);

  Widget buildEditable(BuildContext context);

  QuestionnaireResponseAnswer? fillAnswer();

  List<QuestionnaireResponseAnswer>? fillChoiceAnswers() {
    throw UnimplementedError('fillChoiceAnswers not implemented.');
  }

  bool hasChoiceAnswers() => false;

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        _value = newValue;
      });

      if (hasChoiceAnswers()) {
        widget.answerLocation.stashChoiceAnswers(fillChoiceAnswers());
      } else {
        widget.answerLocation.stashAnswer(fillAnswer());
      }
    }
  }

  // ignore: avoid_setters_without_getters
  set initialValue(V? initialValue) {
    _abstractLogger
        .debug('initialValue ${widget.location.linkId} = $initialValue');
    _value = initialValue;
  }

  V? get value => _value;

  @override
  Widget build(BuildContext context) {
    return widget.location.isReadOnly
        ? buildReadOnly(context)
        : buildEditable(context);
  }
}
