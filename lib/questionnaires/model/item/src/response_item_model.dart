import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

/// Model a response item
///
/// This is a base class for either a question or a group item model.
abstract class ResponseItemModel extends FillerItemModel {
  static final _rimLogger = Logger(ResponseItemModel);

  late final FhirPathExpressionEvaluator? _constraintExpression;

  ResponseItemModel(
    ResponseNode? parentNode,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel questionnaireItemModel,
  ) : super(
          parentNode,
          questionnaireResponseModel,
          questionnaireItemModel,
        ) {
    final constraintExpression = questionnaireItemModel.constraintExpression;

    _constraintExpression = constraintExpression != null
        ? FhirPathExpressionEvaluator(
            () => questionnaireResponseModel.createQuestionnaireResponse(),
            Expression(
              expression: constraintExpression,
              language: ExpressionLanguage.text_fhirpath,
            ),
            [
              ...itemWithPredecessorsExpressionEvaluators,
            ],
          )
        : null;
  }

  /// Can the item be answered?
  ///
  /// Static or read-only items cannot be answered.
  /// Items which are not enabled cannot be answered.
  bool get isAnswerable {
    final returnValue = !(questionnaireItemModel.isReadOnly || !isEnabled);

    _rimLogger.trace('isAnswerable $nodeUid: $returnValue');

    return returnValue;
  }

  /// Is the item answered?
  ///
  /// Static or read-only items are not answered.
  /// Items which are not enabled are not answered.
  bool get isAnswered;

  /// Is the item unanswered?
  ///
  /// Static or read-only items are not unanswered.
  /// Items which are not enabled are not unanswered.
  bool get isUnanswered;

  /// Is the item invalid?
  bool get isInvalid;

  /// Returns a description of the current error situation with this item.
  ///
  /// Localized text if an error exists. Or null if no error exists.
  String? errorText;

  Map<String, String>? validate({
    bool updateErrorText = true,
    bool notifyListeners = false,
  }) {
    String? newErrorText;

    if (questionnaireItemModel.isRequired && isUnanswered) {
      newErrorText = lookupFDashLocalizations(questionnaireResponseModel.locale)
          .validatorRequiredItem;
    }

    final constraintError = validateConstraint();
    newErrorText ??= constraintError;

    if (errorText != newErrorText) {
      if (updateErrorText) {
        errorText = newErrorText;
      }
      if (notifyListeners) {
        this.notifyListeners();
      }
    }

    if (newErrorText == null) {
      return null;
    } else {
      final resultMap = <String, String>{};
      resultMap[nodeUid] = newErrorText;

      return resultMap;
    }
  }

  /// Returns whether the item is satisfying the `questionnaire-constraint`.
  ///
  /// Returns null if satisfied, or a human-readable text if not satisfied.
  /// Returns null if no constraint is specified.
  String? validateConstraint() {
    final constraintExpression = _constraintExpression;
    if (constraintExpression == null) {
      return null;
    }

    final isSatisfied = constraintExpression.fetchBoolValue(
      unknownValue: true,
      location: nodeUid,
    );

    return isSatisfied ? null : questionnaireItemModel.constraintHuman;
  }
}
