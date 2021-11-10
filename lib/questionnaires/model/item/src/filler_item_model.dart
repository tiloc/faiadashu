import 'package:collection/src/iterable_extensions.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_path/run_fhir_path.dart';
import 'package:flutter/foundation.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

/// An item entry for a questionnaire filler.
///
/// This is a common base-class for items that can generate responses (questions, groups),
/// and those that don't (display).
abstract class FillerItemModel extends ChangeNotifier with Diagnosticable {
  static final _fimLogger = Logger(FillerItemModel);

  final QuestionnaireResponseModel questionnaireResponseModel;
  final QuestionnaireItemModel questionnaireItemModel;
  final FillerItemModel? parentItem;
  final int? parentAnswerIndex;

  List<VariableModel>? _variables;
  final String _responseUid;

  FillerItemModel(
    this.parentItem,
    this.parentAnswerIndex,
    this.questionnaireResponseModel,
    this.questionnaireItemModel,
  ) : _responseUid =
            "${(parentItem != null) ? parentItem.questionnaireItemModel.linkId : ''}${(parentAnswerIndex != null) ? '[$parentAnswerIndex]' : ''}/${questionnaireItemModel.linkId}";

  /// Returns a unique id that identifies this item in a tree of responses.
  String get responseUid => _responseUid;

  QuestionnaireItem get questionnaireItem =>
      questionnaireItemModel.questionnaireItem;

  /// Updates the current enablement status of this item.
  ///
  /// Determines the applicable method (enableWhen / enableWhenExpression).
  ///
  /// Sets the [isEnabled] property
  void updateEnabled() {
    _fimLogger.trace('Enter updateEnabled()');

    if (questionnaireItemModel.isEnabledWhen) {
      _updateEnabledByEnableWhen();
    } else if (questionnaireItemModel.isEnabledWhenExpression) {
      _updateEnabledByEnableWhenExpression();
    }
  }

  /// Updates the current enablement status of this item, based on enabledWhenExpression.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhenExpression() {
    _fimLogger.trace('Enter _updateEnabledByEnableWhenExpression()');

    final fhirPathExpression = questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-enableWhenExpression',
        )
        ?.valueExpression
        ?.expression;

    if (fhirPathExpression == null) {
      throw QuestionnaireFormatException(
        'enableWhenExpression missing expression',
        questionnaireItem,
      );
    }

    final fhirPathResult = evaluateFhirPathExpression(fhirPathExpression);

    // Evaluate result
    if (!isFhirPathResultTrue(
      fhirPathResult,
      fhirPathExpression,
      unknownValue: false,
    )) {
      _disableWithChildren();
    }
  }

  void _disableWithChildren() {
    _isEnabled = false;
    for (final child in questionnaireResponseModel
        .orderedFillerItemModels()
        .where((fim) => fim.parentItem == this)) {
      child._disableWithChildren();
    }
  }

  ResponseItemModel fromLinkId(String linkId) {
    // TODO: This makes a crude assumption about 1:1 relationship question/response
    // Expected behavior according to spec:
    // If multiple question occurrences are present for the same question (same linkId), then this refers to the nearest question occurrence reachable by tracing first the "ancestor" axis and then the "preceding" axis and then the "following" axis. If there are multiple items with the same linkId and all are equadistant (e.g. a question references a question that appears in a separate repeating group), that is an error. (Consider using the enableWhenExpression extension to define logic to handle such a situation.)
    // https://stackoverflow.com/questions/22455959/xpath-difference-between-preceding-and-ancestor/22456251
    return questionnaireResponseModel
        .orderedResponseItemModels()
        .where((rim) => rim.questionnaireItemModel.linkId == linkId)
        .first;
  }

  /// Updates the current enablement status of this item, based on enabledWhen.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhen() {
    _fimLogger.trace('Enter _updateEnabledByEnableWhen()');

    bool anyTrigger = false;
    int allTriggered = 0;
    int allCount = 0;

    questionnaireItemModel.forEnableWhens((qew) {
      // TODO: implement the following rule: If enableWhen logic depends on an item that is disabled, the logic should proceed as though the item is not valued - even if a default value or other value might be retained in memory in the event of the item being re-enabled.
      final questionLinkId = qew.question;
      if (questionLinkId == null) {
        throw QuestionnaireFormatException(
            'enableWhen with unspecified linkId.', qew);
      }

      allCount++;
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          if (fromLinkId(qew.question!).isAnswered ==
              qew.answerBoolean!.value) {
            anyTrigger = true;
            allTriggered++;
          }
          break;
        case QuestionnaireEnableWhenOperator.eq:
        case QuestionnaireEnableWhenOperator.ne:
          final question = fromLinkId(questionLinkId);
          if (question is QuestionItemModel) {
            final firstAnswer =
                (fromLinkId(questionLinkId) as QuestionItemModel)
                    .answeredAnswerModels
                    .firstOrNull;

            if (firstAnswer == null) {
              // null equals nothing
              if (qew.operator_ == QuestionnaireEnableWhenOperator.ne) {
                anyTrigger = true;
                allTriggered++;
              }
            } else if (firstAnswer is CodingAnswerModel) {
              final responseCoding = firstAnswer.value?.coding?.firstOrNull;

              // TODO: More sophistication- System, cardinality, etc.
              if (responseCoding?.code == qew.answerCoding?.code) {
                _fimLogger.debug(
                    'enableWhen: $responseCoding == ${qew.answerCoding}');
                if (qew.operator_ == QuestionnaireEnableWhenOperator.eq) {
                  anyTrigger = true;
                  allTriggered++;
                }
              } else {
                _fimLogger.debug(
                  'enableWhen: $responseCoding != ${qew.answerCoding}',
                );
                if (qew.operator_ == QuestionnaireEnableWhenOperator.ne) {
                  anyTrigger = true;
                  allTriggered++;
                }
              }
            } else {
              _fimLogger.warn(
                  'Unsupported: Item with linkId is not a code question: $questionLinkId.');
              // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
              // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
              anyTrigger = true;
              allTriggered++;
            }
          } else {
            _fimLogger
                .warn('linkId refers to non-question item: $questionLinkId.');
            // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
            // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
            anyTrigger = true;
            allTriggered++;
          }
          break;
        default:
          _fimLogger.warn('Unsupported operator: ${qew.operator_}.');
          // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
          // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
          anyTrigger = true;
          allTriggered++;
      }
    });

    // TODO: Optimization: 'any' could stop evaluation after first trigger.
    switch (questionnaireItem.enableBehavior) {
      case QuestionnaireItemEnableBehavior.any:
      case null:
        if (!anyTrigger) {
          _disableWithChildren();
        }
        break;
      case QuestionnaireItemEnableBehavior.all:
        if (allCount != allTriggered) {
          _disableWithChildren();
        }
        break;
      case QuestionnaireItemEnableBehavior.unknown:
        throw QuestionnaireFormatException(
          'enableWhen with unknown enableBehavior: ${questionnaireItem.enableBehavior}',
          questionnaireItem,
        );
    }
  }

  /// INTERNAL USE: Enable the item.
  void enable() {
    _isEnabled = true;
  }

  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;

  bool get hasVariables => (_variables != null) && _variables!.isNotEmpty;

  /// Returns the evaluation result of a FHIRPath expression
  List<dynamic> evaluateFhirPathExpression(
    String fhirPathExpression, {
    bool requiresQuestionnaireResponse = true,
  }) {
    final responseResource = requiresQuestionnaireResponse
        ? questionnaireResponseModel.questionnaireResponse
        : null;

    // Variables for launch context
    final launchContextVariables = <String, dynamic>{};
    if (questionnaireResponseModel.launchContext.patient != null) {
      launchContextVariables.addEntries(
        [
          MapEntry<String, dynamic>(
            '%patient',
            questionnaireResponseModel.launchContext.patient?.toJson(),
          )
        ],
      );
    }

    // Calculated variables

    // Questionnaire-level variables
    final calculatedVariables = questionnaireResponseModel.hasVariables
        ? Map.fromEntries(
            questionnaireResponseModel.variables!
                .map<MapEntry<String, dynamic>>(
              (variable) => MapEntry('%${variable.name}', variable.value),
            ),
          )
        : null;

    // TODO: Add item-level variables

    // SDC variables
    // TODO: %qitem, etc.
    // http://hl7.org/fhir/uv/sdc/2019May/expressions.html#fhirpath-and-questionnaire
    // http://build.fhir.org/ig/HL7/sdc/expressions.html#fhirpath

    final evaluationVariables = launchContextVariables;
    if (calculatedVariables != null) {
      evaluationVariables.addAll(calculatedVariables);
    }

    final fhirPathResult = r4WalkFhirPath(
      responseResource,
      fhirPathExpression,
      evaluationVariables,
    );

    _fimLogger.debug(
      'evaluateFhirPathExpression on $responseUid: $fhirPathExpression = $fhirPathResult',
    );

    return fhirPathResult;
  }

  bool isFhirPathResultTrue(
    List<dynamic> fhirPathResult,
    String fhirPathExpression, {
    required bool unknownValue,
  }) {
    // Proper behavior is undefined: http://jira.hl7.org/browse/FHIR-33295
    // Using singleton collection evaluation: https://hl7.org/fhirpath/#singleton-evaluation-of-collections
    if (fhirPathResult.isEmpty) {
      return unknownValue;
    } else if (fhirPathResult.first is! bool) {
      _fimLogger.warn(
        'Questionnaire design issue: "$fhirPathExpression" at $responseUid results in $fhirPathResult. Expected a bool.',
      );
      return fhirPathResult.first != null;
    } else {
      return fhirPathResult.first as bool;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('responseUid', responseUid));
  }
}
