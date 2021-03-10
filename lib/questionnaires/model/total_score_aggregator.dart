import 'package:collection/collection.dart';
import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import 'questionnaire_location.dart';

/// Aggregate responses into a total score.
/// Updates immediately when questionnaire is updated.
/// Can deal with incomplete questionnaires.
/// Will return 0 when no score field exists on the questionnaire.
class TotalScoreAggregator extends ValueNotifier<Decimal> {
  final QuestionnaireLocation top;
  late final QuestionnaireLocation? totalScoreLocation;
  TotalScoreAggregator(QuestionnaireLocation location)
      : top = location.top,
        super(Decimal(0.0)) {
    totalScoreLocation =
        top.preOrder().firstWhereOrNull((location) => location.isTotalScore);
    // if there is no total score location then leave value at NaN indefinitely
    if (totalScoreLocation != null) {
      for (final location in top.preOrder()) {
        if (!location.isStatic && location != totalScoreLocation) {
          location.addListener(() => _updateScore());
        }
      }
    }
  }

  void _updateScore() {
    // Special handling if this is the total score
    double sum = 0.0;
    for (final location in top.preOrder()) {
      if (location != totalScoreLocation) {
        final points = location.score;
        if (points != null) {
          sum += location.score!.value!;
        }
      }
    }

    value = Decimal(sum);

    totalScoreLocation!.responseItem = QuestionnaireResponseItem(
        linkId: totalScoreLocation!.linkId,
        text: totalScoreLocation!.questionnaireItem.text,
        answer: [QuestionnaireResponseAnswer(valueDecimal: value)]);
  }
}
