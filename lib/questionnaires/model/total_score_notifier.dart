import 'package:collection/collection.dart';
import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import 'questionnaire_location.dart';

/// Notify listeners of the total score of a questionnaire.
/// Updates immediately when questionnaire is updated.
/// Can deal with incomplete questionnaires.
/// Will return [double.nan] when no score field exists on the questionnaire.
class TotalScoreNotifier extends ValueNotifier<Decimal> {
  final QuestionnaireLocation top;
  late final QuestionnaireLocation? totalScoreLocation;
  TotalScoreNotifier(QuestionnaireLocation location)
      : top = location.top,
        super(Decimal(double.nan)) {
    totalScoreLocation =
        top.preOrder().firstWhereOrNull((location) => location.isTotalScore);
    // if there is no total score location then leave value at NaN indefinitely
    if (totalScoreLocation != null) {
      _updateScore();
      for (final location in top.preOrder()) {
        if (!location.isReadOnly) {
          location.addListener(() => _updateScore());
        }
      }
    }
  }

  void _updateScore() {
    // Special handling if this is the total score
    double sum = 0.0;
    for (final location in top.preOrder()) {
      if (!location.isReadOnly) {
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
