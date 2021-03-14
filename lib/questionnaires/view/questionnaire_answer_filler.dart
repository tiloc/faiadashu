import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

/// A Widget to fill an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  final QuestionnaireLocation location;
  final QuestionnaireResponseState responseState;
  final int answerIndex;

  const QuestionnaireAnswerFiller(
      this.location, this.responseState, this.answerIndex,
      {Key? key})
      : super(key: key);
}

abstract class QuestionnaireAnswerState<V, W extends QuestionnaireAnswerFiller>
    extends State<W> {
  V? _value;

  QuestionnaireAnswerState(V? value) : _value = value;

  Widget buildReadOnly(BuildContext context);

  Widget buildEditable(BuildContext context);

  QuestionnaireResponseAnswer? fillAnswer();

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        _value = newValue;
      });

      widget.responseState.fillAnswer(widget.answerIndex, fillAnswer());
    }
  }

  V? get value => _value;

  @override
  Widget build(BuildContext context) {
    return widget.location.isReadOnly
        ? buildReadOnly(context)
        : buildEditable(context);
  }
}
