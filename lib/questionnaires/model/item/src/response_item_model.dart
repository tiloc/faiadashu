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
            () => questionnaireResponseModel.questionnaireResponse,
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

  /// Returns a description of an error situation with this response item.
  String? errorText;

  Future<bool> get isComplete async {
    if (questionnaireItemModel.isRequired && isUnanswered) {
      errorText = lookupFDashLocalizations(questionnaireResponseModel.locale)
          .validatorRequiredItem;

      return false;
    }

    if (!await isSatisfyingConstraint) {
      errorText = questionnaireItemModel.constraintHuman;

      return false;
    }

    return true;
  }

  /// Returns whether the item is satisfying the `questionnaire-constraint`.
  ///
  /// Returns true if no constraint is specified.
  Future<bool> get isSatisfyingConstraint async {
    final constraintExpression = _constraintExpression;
    if (constraintExpression == null) {
      return true;
    }

    final fhirPathResult = await constraintExpression.fetchValue();

    return isFhirPathResultTrue(
      fhirPathResult,
      constraintExpression,
      unknownValue: true,
    );
  }
}
