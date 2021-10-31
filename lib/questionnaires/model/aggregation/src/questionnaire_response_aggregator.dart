import 'package:fhir/r4.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

// TODO: Properly support nested questionnaire items (questions being children of other questions).

/// Aggregates the user's responses into a [QuestionnaireResponse].
///
/// For status = 'complete' the items which are not enabled SHALL be excluded.
/// For other status they might be included  (FHIR-31077) - this implementation
/// does include them.
class QuestionnaireResponseAggregator
    extends Aggregator<QuestionnaireResponse> {
  static final Logger _logger = Logger(QuestionnaireResponseAggregator);

  QuestionnaireResponseAggregator()
      : super(QuestionnaireResponse(), autoAggregate: false);

  /// Initialize the aggregator.
  @override
  void init(QuestionnaireResponseModel questionnaireResponseModel) {
    super.init(questionnaireResponseModel);
  }

  QuestionnaireResponseItem? _fromGroupItem(
    GroupItemModel itemModel,
    QuestionnaireResponseStatus responseStatus,
  ) {
    if (responseStatus == QuestionnaireResponseStatus.completed &&
        !itemModel.isEnabled) {
      return null;
    }

    final nestedItems = <QuestionnaireResponseItem>[];

    for (final nestedItem in questionnaireResponseModel
        .orderedResponseItemModels()
        .where((rim) => rim.parentItem == itemModel)) {
      if (nestedItem.questionnaireItemModel.isGroup) {
        final groupItem =
            _fromGroupItem(nestedItem as GroupItemModel, responseStatus);
        if (groupItem != null) {
          nestedItems.add(groupItem);
        }
      } else {
        if (nestedItem.responseItem != null) {
          nestedItems.add(nestedItem.responseItem!);
        }
      }
    }

    // TODO: Should this be done by the group model itself?
    if (nestedItems.isNotEmpty) {
      return QuestionnaireResponseItem(
        linkId: itemModel.questionnaireItemModel.linkId,
        text: itemModel.questionnaireItemModel.titleText,
        item: nestedItems,
      );
    } else {
      return null;
    }
  }

  @override
  QuestionnaireResponse? aggregate({
    QuestionnaireResponseStatus? responseStatus,
    bool notifyListeners = false,
    bool containPatient = false,
  }) {
    _logger.trace('QuestionnaireResponse.aggregate');

    // Are all minimum fields for SDC profile present?
    bool isValidSdc = true;

    responseStatus ??= questionnaireResponseModel.responseStatus;

    final responseItems = <QuestionnaireResponseItem>[];

    for (final itemModel in questionnaireResponseModel
        .orderedResponseItemModels()
        .where((rim) => rim.parentItem == null)) {
      if (itemModel.questionnaireItemModel.isGroup) {
        final groupItem =
            _fromGroupItem(itemModel as GroupItemModel, responseStatus);
        if (groupItem != null) {
          responseItems.add(groupItem);
        }
      } else {
        if (itemModel.responseItem != null &&
            (responseStatus != QuestionnaireResponseStatus.completed ||
                itemModel.isEnabled)) {
          responseItems.add(itemModel.responseItem!);
        }
      }
    }

    final narrativeAggregator =
        questionnaireResponseModel.aggregator<NarrativeAggregator>();

    final questionnaireUrl = questionnaireResponseModel
        .questionnaireModel.questionnaire.url
        ?.toString();
    final questionnaireVersion =
        questionnaireResponseModel.questionnaireModel.questionnaire.version;
    final questionnaireCanonical = (questionnaireUrl != null)
        ? Canonical(
            "$questionnaireUrl${(questionnaireVersion != null) ? '|$questionnaireVersion' : ''}",
          )
        : null;

    final questionnaireTitle =
        questionnaireResponseModel.questionnaireModel.questionnaire.title;

    final contained = <Resource>[];

    final subject = questionnaireResponseModel.launchContext.patient;

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
      Canonical(
        'http://hl7.org/fhir/4.0/StructureDefinition/QuestionnaireResponse',
      ),
      if (isValidSdc)
        Canonical(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaireresponse',
        ),
      if (isValidSdc)
        Canonical(
          'http://fhir.org/guides/argonaut/questionnaire/StructureDefinition/argo-questionnaireresponse',
        ),
    ];

    final meta = (profiles.isNotEmpty)
        ? Meta(profile: profiles.isNotEmpty ? profiles : null)
        : null;

    final narrative = narrativeAggregator.aggregate();

    final questionnaireResponse = QuestionnaireResponse(
      status: responseStatus,
      meta: meta,
      contained: (contained.isNotEmpty) ? contained : null,
      questionnaire: questionnaireCanonical,
      item: (responseItems.isNotEmpty) ? responseItems : null,
      authored: FhirDateTime(DateTime.now()),
      text: (narrative?.status == NarrativeStatus.empty) ? null : narrative,
      language: Code(locale.toLanguageTag()),
      subject: subjectReference,
      questionnaireElement: (questionnaireTitle != null)
          ? Element(
              extension_: [
                FhirExtension(
                  url: FhirUri(
                    'http://hl7.org/fhir/StructureDefinition/display',
                  ),
                  valueString: questionnaireResponseModel
                      .questionnaireModel.questionnaire.title,
                )
              ],
            )
          : null,
    );

    if (notifyListeners) {
      value = questionnaireResponse;
    }
    return questionnaireResponse;
  }
}
