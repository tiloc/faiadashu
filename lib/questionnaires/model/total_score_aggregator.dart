import 'dart:developer' as developer;
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';

import '../../fhir_types/fhir_types_extensions.dart';
import '../../logging/logging.dart';
import '../../questionnaires/model/aggregator.dart';
import 'questionnaire_location.dart';

/// Aggregate responses into a total score.
/// Updates immediately when questionnaire is updated and [autoAggregate] is true.
/// Can deal with incomplete questionnaires.
/// Will return 0 when no score field exists on the questionnaire.
class TotalScoreAggregator extends Aggregator<Decimal> {
  late final QuestionnaireLocation? totalScoreLocation;
  late final String logTag;
  TotalScoreAggregator({bool autoAggregate = true})
      : super(Decimal(0), autoAggregate: autoAggregate) {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
  }

  @override
  void init(QuestionnaireTopLocation topLocation) {
    super.init(topLocation);

    totalScoreLocation = topLocation
        .preOrder()
        .firstWhereOrNull((location) => location.isCalculatedExpression);
    // if there is no total score location then leave value at 0 indefinitely
    if (autoAggregate) {
      if (totalScoreLocation != null) {
        for (final location in topLocation.preOrder()) {
          if (!location.isStatic && location != totalScoreLocation) {
            location.addListener(() => aggregate(null, notifyListeners: true));
          }
        }
      }
    }
  }

  @override
  Decimal? aggregate(Locale? locale, {bool notifyListeners = false}) {
    if (totalScoreLocation == null) {
      return null;
    }

    developer.log('totalScore.aggregrate', level: LogLevel.debug, name: logTag);
    // Special handling if this is the total score
    double sum = 0.0;
    for (final location in topLocation.preOrder()) {
      if (location != totalScoreLocation) {
        final points = location.score;
        developer.log('Adding $location: $points',
            level: LogLevel.trace, name: logTag);
        if (points != null) {
          sum += points.value!;
        }
      }
    }

    developer.log('sum: $sum', level: LogLevel.debug, name: logTag);
    final result = Decimal(sum);
    if (notifyListeners) {
      value = result;
    }

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

    return result;
  }
}
