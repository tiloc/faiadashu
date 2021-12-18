import 'package:collection/collection.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

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

  late final QuestionItemModel? totalScoreItem;
  TotalScoreAggregator({bool autoAggregate = true})
      : super(Decimal(0), autoAggregate: autoAggregate);

  @override
  void init(QuestionnaireResponseModel questionnaireResponseModel) {
    super.init(questionnaireResponseModel);

    totalScoreItem =
        questionnaireResponseModel.orderedResponseItemModels().firstWhereOrNull(
              (rim) => rim.questionnaireItemModel.isTotalScore,
            ) as QuestionItemModel?;
    // if there is no total score item then leave value at 0 indefinitely
    if (autoAggregate) {
      if (totalScoreItem != null) {
        for (final rim
            in questionnaireResponseModel.orderedResponseItemModels()) {
          if (!rim.questionnaireItemModel.isStatic && rim != totalScoreItem) {
            rim.addListener(() => aggregate(notifyListeners: true));
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
        questionnaireResponseModel.orderedQuestionItemModels().fold<double>(
              0.0,
              (previousValue, element) =>
                  previousValue + (element.ordinalValue?.value ?? 0.0),
            );

    _logger.debug('sum: $sum');
    final result = Decimal(sum);
    if (notifyListeners) {
      value = result;
    }

    totalScoreItem.firstAnswerModel.populateFromExpression(result);

    return result;
  }
}
