import 'package:faiadashu/coding/coding.dart';
import 'package:fhir/r4.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

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

  QuestionnaireResponseItem? _fromQuestionItem(
    QuestionItemModel itemModel,
    QuestionnaireResponseStatus responseStatus,
    Map<String, dynamic> responseItemRegistry,
  ) {
    if (responseStatus == QuestionnaireResponseStatus.completed &&
        !itemModel.isEnabled) {
      return null;
    }

    final isCodingAnswers = itemModel.questionnaireItemModel.isCodingType;

    final answeredAnswerModels = itemModel.answeredAnswerModels;

    final dataAbsentReason = itemModel.dataAbsentReason;

    // Don't care, if it is read-only, calculated, etc. If it exists: emit it!
    if (answeredAnswerModels.isEmpty && dataAbsentReason == null) {
      return null;
    }

    List<QuestionnaireResponseAnswer>? answers;
    if (answeredAnswerModels.isNotEmpty) {
      if (isCodingAnswers) {
        // Evaluate nested items from first answer only
        final firstAnswer = answeredAnswerModels.first;
        final nestedItems = _fromResponseItems(
          firstAnswer,
          responseStatus,
          responseItemRegistry,
        );

        answers = firstAnswer.createFhirCodingAnswers(nestedItems);
      } else {
        // Evaluate nested items
        final List<QuestionnaireResponseAnswer> createdAnswers = [];
        for (final answerModel in answeredAnswerModels) {
          final nestedItems = _fromResponseItems(
            answerModel,
            responseStatus,
            responseItemRegistry,
          );
          final fhirAnswer = answerModel.createFhirAnswer(nestedItems);
          if (fhirAnswer != null) {
            createdAnswers.add(fhirAnswer);
          }
        }
        answers = (createdAnswers.isNotEmpty) ? createdAnswers : null;
      }
    }

    final responseItem = QuestionnaireResponseItem(
      linkId: itemModel.questionnaireItemModel.linkId,
      text: itemModel.questionnaireItemModel.text?.plainText,
      // TODO: Include textElement
      extension_: (dataAbsentReason != null)
          ? [
              FhirExtension(
                url: dataAbsentReasonExtensionUrl,
                valueCode: dataAbsentReason,
              ),
            ]
          : null,
      answer: answers,
    );

    responseItemRegistry[itemModel.nodeUid] = responseItem.toJson();

    return responseItem;
  }

  QuestionnaireResponseItem? _fromGroupItem(
    GroupItemModel itemModel,
    QuestionnaireResponseStatus responseStatus,
    Map<String, dynamic> responseItemRegistry,
  ) {
    if (responseStatus == QuestionnaireResponseStatus.completed &&
        !itemModel.isEnabled) {
      return null;
    }

    final nestedItems =
        _fromResponseItems(itemModel, responseStatus, responseItemRegistry);

    if (nestedItems != null) {
      final responseItem = QuestionnaireResponseItem(
        linkId: itemModel.questionnaireItemModel.linkId,
        text: itemModel.questionnaireItemModel.text?.plainText,
        // TODO: include textElement
        item: nestedItems,
      );

      responseItemRegistry[itemModel.nodeUid] = responseItem.toJson();

      return responseItem;
    } else {
      return null;
    }
  }

  List<QuestionnaireResponseItem>? _fromResponseItems(
    ResponseNode? parentNode,
    QuestionnaireResponseStatus responseStatus,
    Map<String, dynamic> responseItemRegistry,
  ) {
    final responseItems = <QuestionnaireResponseItem>[];

    for (final itemModel in questionnaireResponseModel
        .orderedResponseItemModelsWithParent(parent: parentNode)) {
      if (itemModel.questionnaireItemModel.isGroup) {
        final groupItem = _fromGroupItem(
          itemModel as GroupItemModel,
          responseStatus,
          responseItemRegistry,
        );
        if (groupItem != null) {
          responseItems.add(groupItem);
        }
      } else {
        // isQuestion
        final questionItem = _fromQuestionItem(
          itemModel as QuestionItemModel,
          responseStatus,
          responseItemRegistry,
        );
        if (questionItem != null) {
          responseItems.add(questionItem);
        }
      }
    }

    return (responseItems.isNotEmpty) ? responseItems : null;
  }

  static const questionnaireResponseKey = '_questionnaireResponse';

  @override
  QuestionnaireResponse? aggregate({
    QuestionnaireResponseStatus? responseStatus,
    bool notifyListeners = false,
    bool containPatient = false,
  }) {
    _logger.trace('QuestionnaireResponseAggregator.aggregate');

    final responseItems = aggregateResponseItems(
      responseStatus: responseStatus,
      notifyListeners: notifyListeners,
      containPatient: containPatient,
    );

    final questionnaireResponse =
        responseItems[questionnaireResponseKey] as QuestionnaireResponse?;

    return questionnaireResponse;
  }

  Map<String, dynamic> aggregateResponseItems({
    QuestionnaireResponseStatus? responseStatus,
    bool notifyListeners = false,
    bool containPatient = false,
  }) {
    _logger.trace('QuestionnaireResponseAggregator.aggregateResponseItems');

    // Are all minimum fields for SDC profile present?
    bool isValidSdc = true;

    responseStatus ??= questionnaireResponseModel.responseStatus;

    final responseItemRegistry = <String, dynamic>{};
    final responseItems =
        _fromResponseItems(null, responseStatus, responseItemRegistry);

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
      item: responseItems,
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
                ),
              ],
            )
          : null,
    );

    if (notifyListeners) {
      value = questionnaireResponse;
    }

    responseItemRegistry[questionnaireResponseKey] = questionnaireResponse;

    return responseItemRegistry;
  }
}
