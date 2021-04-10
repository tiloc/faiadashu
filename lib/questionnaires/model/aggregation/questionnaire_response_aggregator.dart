import 'package:fhir/r4.dart';

import '../../../logging/logger.dart';
import '../../questionnaires.dart';

class QuestionnaireResponseAggregator
    extends Aggregator<QuestionnaireResponse> {
  static final Logger _logger = Logger(QuestionnaireResponseAggregator);

  QuestionnaireResponseAggregator()
      : super(QuestionnaireResponse(), autoAggregate: false);

  /// Initialize the aggregator.
  @override
  void init(QuestionnaireTopLocation topLocation) {
    super.init(topLocation);
  }

  QuestionnaireResponseItem? _fromGroupItem(QuestionnaireLocation location) {
    final nestedItems = <QuestionnaireResponseItem>[];

    for (final nestedItem in location.children) {
      if (nestedItem.questionnaireItem.type == QuestionnaireItemType.group) {
        final groupItem = _fromGroupItem(nestedItem);
        if (groupItem != null) {
          nestedItems.add(groupItem);
        }
      } else {
        if (nestedItem.responseItem != null) {
          nestedItems.add(nestedItem.responseItem!);
        }
      }
    }

    if (nestedItems.isNotEmpty) {
      return QuestionnaireResponseItem(
          linkId: location.linkId, text: location.titleText, item: nestedItems);
    } else {
      return null;
    }
  }

  @override
  QuestionnaireResponse? aggregate({bool notifyListeners = false}) {
    _logger.trace('QuestionnaireResponse.aggregrate');

    final responseItems = <QuestionnaireResponseItem>[];

    for (final location in topLocation.siblings) {
      if (location.questionnaireItem.type == QuestionnaireItemType.group) {
        final groupItem = _fromGroupItem(location);
        if (groupItem != null) {
          responseItems.add(groupItem);
        }
      } else {
        if (location.responseItem != null) {
          responseItems.add(location.responseItem!);
        }
      }
    }

    final narrativeAggregator = topLocation.aggregator<NarrativeAggregator>();

    final questionnaireUrl = topLocation.questionnaire.url?.toString();
    final questionnaireVersion = topLocation.questionnaire.version;
    final questionnaireCanonical = (questionnaireUrl != null)
        ? Canonical(
            "$questionnaireUrl${(questionnaireVersion != null) ? '|$questionnaireVersion' : ''}")
        : null;

    final questionnaireResponse = QuestionnaireResponse(
        // TODO: Should this come from topLocation, or simply be a param for aggregate?
        // TODO: For status = 'complete' the items which are not enabled SHALL be excluded.
        //  For other status they might be included  (FHIR-31077)
        status: topLocation.responseStatus,
        questionnaire: questionnaireCanonical,
        item: (responseItems.isNotEmpty) ? responseItems : null,
        authored: FhirDateTime(DateTime.now()),
        text: narrativeAggregator.aggregate());

    // TODO: SDC mandates a an extension on "questionnaire", but the FHIR library doesn't have questionnaireElement
    // see http://hl7.org/fhir/2018Sep/extension-display.html

    if (notifyListeners) {
      value = questionnaireResponse;
    }
    return questionnaireResponse;
  }
}
