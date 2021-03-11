import 'package:collection/collection.dart';
import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../util/safe_access_extensions.dart';
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
        super(Decimal(0)) {
    totalScoreLocation =
        top.preOrder().firstWhereOrNull((location) => location.isTotalScore);
    // if there is no total score location then leave value at 0 indefinitely
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

    final unit = totalScoreLocation!.questionnaireItem.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-unit')
        ?.valueCoding
        ?.display;

    if (unit != null) {
      totalScoreLocation!.responseItem = QuestionnaireResponseItem(
          linkId: totalScoreLocation!.linkId,
          text: totalScoreLocation!.questionnaireItem.text,
          answer: [
            QuestionnaireResponseAnswer(
                valueQuantity: Quantity(value: value, unit: unit))
          ]);
    } else {
      totalScoreLocation!.responseItem = QuestionnaireResponseItem(
          linkId: totalScoreLocation!.linkId,
          text: totalScoreLocation!.questionnaireItem.text,
          answer: [QuestionnaireResponseAnswer(valueDecimal: value)]);
    }
  }
}
