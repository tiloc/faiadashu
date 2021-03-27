import 'dart:developer' as developer;
import 'dart:ui';

import 'package:fhir/r4.dart';

import '../questionnaires.dart';

class QuestionnaireResponseAggregator
    extends Aggregator<QuestionnaireResponse> {
  QuestionnaireResponseAggregator()
      : super(QuestionnaireResponse(), autoAggregate: false);

  /// Initialize the aggregator.
  @override
  void init(QuestionnaireTopLocation topLocation) {
    super.init(topLocation);
  }

  QuestionnaireResponseItem _fromGroupItem(QuestionnaireLocation location) {
    final nestedItems = <QuestionnaireResponseItem>[];

    for (final nestedItem in location.children) {
      if (nestedItem.questionnaireItem.type == QuestionnaireItemType.group) {
        nestedItems.add(_fromGroupItem(nestedItem));
      } else {
        if (nestedItem.responseItem != null) {
          nestedItems.add(nestedItem.responseItem!);
        }
      }
    }

    return QuestionnaireResponseItem(
        linkId: location.linkId, text: location.titleText, item: nestedItems);
  }

  @override
  QuestionnaireResponse? aggregate(Locale? locale,
      {bool notifyListeners = false}) {
    developer.log('QuestionnaireResponse.aggregrate', level: 500);

    final responseItems = <QuestionnaireResponseItem>[];

    for (final location in topLocation.siblings) {
      if (location.questionnaireItem.type == QuestionnaireItemType.group) {
        responseItems.add(_fromGroupItem(location));
      } else {
        if (location.responseItem != null) {
          responseItems.add(location.responseItem!);
        }
      }
    }

    final narrativeAggregator = topLocation.aggregator<NarrativeAggregator>();

    final questionnaireResponse = QuestionnaireResponse(
        status: topLocation.responseStatus,
        item: responseItems,
        authored: FhirDateTime(DateTime.now()),
        text: narrativeAggregator.aggregate(locale));

    if (notifyListeners) {
      value = questionnaireResponse;
    }
    return questionnaireResponse;
  }
}
