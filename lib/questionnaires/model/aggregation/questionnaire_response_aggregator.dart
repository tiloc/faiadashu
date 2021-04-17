import 'package:fhir/r4.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logger.dart';
import '../../../resource_provider/resource_uris.dart';
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
  QuestionnaireResponse? aggregate(
      {QuestionnaireResponseStatus? responseStatus,
      bool notifyListeners = false,
      bool containPatient = false}) {
    _logger.trace('QuestionnaireResponse.aggregrate');

    // Are all minimum fields for SDC profile present?
    bool isValidSdc = true;

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

    final questionnaireTitle = topLocation.questionnaire.title;

    final contained = <Resource>[];

    final subject = topLocation.fhirResourceProvider
        .getResource(subjectResourceUri) as Patient?;

    Reference? subjectReference;
    if (subject != null) {
      if (!containPatient) {
        subjectReference = subject.reference;
      } else {
        if (subject.id != null) {
          subjectReference =
              Reference(type: FhirUri('Patient'), reference: '#${subject.id}');
          contained.add(subject);
        }
      }
    }

    if (subjectReference == null) {
      isValidSdc = false;
    }

    final profiles = [
      if (isValidSdc)
        Canonical(
            'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaireresponse'),
      if (isValidSdc)
        Canonical(
            'http://fhir.org/guides/argonaut/questionnaire/StructureDefinition/argo-questionnaireresponse'),
    ];

    final meta = (profiles.isNotEmpty)
        ? Meta(profile: profiles.isNotEmpty ? profiles : null)
        : null;

    final narrative = narrativeAggregator.aggregate();

    final questionnaireResponse = QuestionnaireResponse(
      // TODO: For status = 'complete' the items which are not enabled SHALL be excluded.
      //  For other status they might be included  (FHIR-31077)
      status: responseStatus ?? topLocation.responseStatus,
      meta: meta,
      contained: (contained.isNotEmpty) ? contained : null,
      questionnaire: questionnaireCanonical,
      item: (responseItems.isNotEmpty) ? responseItems : null,
      authored: FhirDateTime(DateTime.now()),
      text: (narrative?.status == NarrativeStatus.empty) ? null : narrative,
      subject: subjectReference,
      questionnaireElement: (questionnaireTitle != null)
          ? Element(extension_: [
              FhirExtension(
                  url: FhirUri(
                      'http://hl7.org/fhir/StructureDefinition/display'),
                  valueString: topLocation.questionnaire.title)
            ])
          : null,
    );

    if (notifyListeners) {
      value = questionnaireResponse;
    }
    return questionnaireResponse;
  }
}
