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
abstract class FillerItemModel extends ChangeNotifier {
  static final _fimLogger = Logger(FillerItemModel);

  final QuestionnaireResponseModel questionnaireResponseModel;
  final QuestionnaireItemModel questionnaireItemModel;

  late final List<VariableModel>? _variables;

  FillerItemModel(this.questionnaireResponseModel, this.questionnaireItemModel);

  /// Returns the linkId of the item
  ///
  /// The linkId is NOT unique in a tree of responses!
  String get linkId => questionnaireItemModel.linkId;

  QuestionnaireItem get questionnaireItem =>
      questionnaireItemModel.questionnaireItem;

  /// Updates the current enablement status of this item.
  ///
  /// Determines the applicable method (enableWhen / enableWhenExpression).
  ///
  /// Sets the [isEnabled] property
  void _updateEnabled() {
    _fimLogger.trace('Enter _updateEnabled()');

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
    // FIXME: Restore functionality
/*    _isEnabled = false;
    for (final child in children) {
      child._disableWithChildren();
    } */
  }

  /// Updates the current enablement status of this item, based on enabledWhen.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhen() {
    _fimLogger.trace('Enter _updateEnabledByEnableWhen()');

    // FIXME: Restore functionality
/*    bool anyTrigger = false;
    int allTriggered = 0;
    int allCount = 0;

    forEnableWhens((qew) {
      allCount++;
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          if (questionnaireModel.fromLinkId(qew.question!).isAnswered ==
              qew.answerBoolean!.value) {
            anyTrigger = true;
            allTriggered++;
          }
          break;
        case QuestionnaireEnableWhenOperator.eq:
        case QuestionnaireEnableWhenOperator.ne:
          final responseCoding = questionnaireModel
              .fromLinkId(qew.question!)
              .responseItem
              ?.answer
              ?.firstOrNull
              ?.valueCoding;
          // TODO: More sophistication- System, cardinality, etc.
          if (responseCoding?.code == qew.answerCoding?.code) {
            _fimLogger
                .debug('enableWhen: $responseCoding == ${qew.answerCoding}');
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
    } */
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
    final calculatedVariables = hasVariables
        ? Map.fromEntries(
            _variables!.map<MapEntry<String, dynamic>>(
              (variable) => MapEntry('%${variable.name}', variable.value),
            ),
          )
        : null;

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
      'evaluateFhirPathExpression on $linkId: $fhirPathExpression = $fhirPathResult',
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
          'Questionnaire design issue: "$fhirPathExpression" at $linkId results in $fhirPathResult. Expected a bool.');
      return fhirPathResult.first != null;
    } else {
      return fhirPathResult.first as bool;
    }
  }
}
