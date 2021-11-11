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

  // FIXME: Restore this functionality
  /// Returns an integer, starting with 1, that provides the number
  /// of [QuestionnaireModel]s that have [isAnswerable] flags set to true
  ///
/*  int getQuestionNumber(int answerIndex) {
    late final int questionNumber;

    /// If [answerIndex] falls within the _cachedAnswerModels data set...
    /// Check each question in turn until [answerIndex] is reached.
    /// Create a count of all questions that are labeled as answerable until
    /// [answerIndex]
    ///
    if (_orderedItems != null) {
      if (_orderedItems!.length >= answerIndex) {
        var iterable = 1;
        for (var idx = 0; idx < answerIndex; idx++) {
          // Use linked hash map to ensure a key exists at this answer index
          if (_orderedItems?.keys.elementAt(idx).isNotEmpty ?? false) {
            // If a key exists, check to see if the isAnswerable flag is true
            if (_orderedItems?[_orderedItems?.keys.elementAt(idx)]
                ?.isAnswerable ??
                false) {
              iterable++;
            }
          }
        }
        questionNumber = iterable;
      } else {
        throw ArgumentError(
          'answerIndex $answerIndex not found in _orderedItems',
        );
      }
    } else {
      throw StateError('_orderedItems not found');
    }
    return questionNumber;
  } */
}
