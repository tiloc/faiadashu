import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

// TODO(tiloc): Answers for static items shouldn't exist

class StaticItemAnswer extends QuestionnaireAnswerFiller {
  const StaticItemAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends QuestionnaireAnswerState {
  _GroupItemState();

  @override
  Widget buildReadOnly(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    // Not required for a static item
    throw UnimplementedError();
  }

  @override
  Widget buildEditable(BuildContext context) {
    // Not required for a read-only item
    throw UnimplementedError();
  }
}
