import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class StaticItem extends QuestionnaireAnswerFiller {
  const StaticItem(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _StaticItemState();
}

class _StaticItemState extends QuestionnaireAnswerState {
  _StaticItemState();

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
