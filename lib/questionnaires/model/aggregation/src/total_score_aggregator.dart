import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';

import '../../../../logging/logging.dart';
import '../../model.dart';

// TODO: Reduce code with calculatedExpression code

/// Aggregate answers into a total score.
///
/// The score is the sum of the ordinalValue of all answers.
///
/// Updates immediately when questionnaire is updated and [autoAggregate] is true.
///
/// Can deal with incomplete questionnaires.
///
/// Will return 0 when no score field exists on the questionnaire.
class TotalScoreAggregator extends Aggregator<Decimal> {
  static final _logger = Logger(TotalScoreAggregator);

  late final QuestionnaireItemModel? totalScoreItem;
  TotalScoreAggregator({bool autoAggregate = true})
      : super(Decimal(0), autoAggregate: autoAggregate);

  @override
  void init(QuestionnaireModel questionnaireModel) {
    super.init(questionnaireModel);

    totalScoreItem =
        questionnaireModel.orderedQuestionnaireItemModels().firstWhereOrNull(
              (itemModel) => itemModel.isTotalScore,
            );
    // if there is no total score itemModel then leave value at 0 indefinitely
    if (autoAggregate) {
      if (totalScoreItem != null) {
        for (final itemModel
            in questionnaireModel.orderedQuestionnaireItemModels()) {
          if (!itemModel.isStatic && itemModel != totalScoreItem) {
            itemModel.addListener(() => aggregate(notifyListeners: true));
          }
        }
      }
    }
  }

  @override
  Decimal? aggregate({bool notifyListeners = false}) {
    final totalScoreItem = this.totalScoreItem;
    if (totalScoreItem == null) {
      return null;
    }

    _logger.trace('totalScore.aggregate');
    final sum =
        questionnaireModel.orderedQuestionnaireItemModels().fold<double>(
              0.0,
              (previousValue, element) =>
                  previousValue + (element.ordinalValue?.value ?? 0.0),
            );

    _logger.debug('sum: $sum');
    final result = Decimal(sum);
    if (notifyListeners) {
      value = result;
    }

    totalScoreItem.responseModel.answerModel(0).populateFromExpression(result);
    totalScoreItem.responseModel.updateResponse();

    return result;
  }
}
