import '../../../../l10n/l10n.dart';
import '../../../../logging/logging.dart';
import '../../model.dart';

/// Model a response item
///
/// This is a base class for either a question or a group item model.
abstract class ResponseItemModel extends FillerItemModel {
  static final _rimLogger = Logger(ResponseItemModel);

  ResponseItemModel(
    FillerItemModel? parentItem,
    int? parentAnswerIndex,
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel questionnaireItemModel,
  ) : super(
          parentItem,
          parentAnswerIndex,
          questionnaireResponseModel,
          questionnaireItemModel,
        );

  /// Can the item be answered?
  ///
  /// Static or read-only items cannot be answered.
  /// Items which are not enabled cannot be answered.
  bool get isAnswerable {
    final returnValue = !(questionnaireItemModel.isReadOnly || !isEnabled);

    _rimLogger.debug('isAnswerable $responseUid: $returnValue');
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

  Iterable<QuestionnaireErrorFlag>? get isComplete {
    if (questionnaireItemModel.isRequired && isUnanswered) {
      return [
        QuestionnaireErrorFlag(
          responseUid,
          errorText: lookupFDashLocalizations(questionnaireResponseModel.locale)
              .validatorRequiredItem,
        )
      ];
    }

    if (!isSatisfyingConstraint) {
      return [
        QuestionnaireErrorFlag(
          responseUid,
          errorText: questionnaireItemModel.constraintHuman,
        )
      ];
    }

    return null;
  }

  /// Returns whether the item is satisfying the `questionnaire-constraint`.
  ///
  /// Returns true if no constraint is specified.
  bool get isSatisfyingConstraint {
    final fhirPathExpression = questionnaireItemModel.constraintExpression;
    if (fhirPathExpression == null) {
      return true;
    }

    final fhirPathResult = evaluateFhirPathExpression(fhirPathExpression);

    return isFhirPathResultTrue(
      fhirPathResult,
      fhirPathExpression,
      unknownValue: true,
    );
  }
}
