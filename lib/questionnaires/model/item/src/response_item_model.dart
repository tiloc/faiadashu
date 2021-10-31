import 'package:fhir/r4.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../l10n/l10n.dart';
import '../../../../logging/logging.dart';
import '../../model.dart';

/// Model a response item
///
/// This is a base class for either a question or a group response item model.
abstract class ResponseItemModel extends FillerItemModel {
  static final _rimLogger = Logger(ResponseItemModel);

  ResponseItemModel(
    QuestionnaireResponseModel questionnaireResponseModel,
    QuestionnaireItemModel questionnaireItemModel,
  ) : super(questionnaireResponseModel, questionnaireItemModel);

  QuestionnaireResponseItem? get responseItem;

  /// Returns a [Decimal] value which can be added to a score.
  ///
  /// Returns null if not applicable (either question unanswered, or wrong type)
  Decimal? get ordinalValue {
    if (responseItem == null) {
      return null;
    }

    // Find ordinal value in extensions
    final ordinalExtension = responseItem
            ?.answer?.firstOrNull?.valueCoding?.extension_
            ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value',
        ) ??
        responseItem?.answer?.firstOrNull?.valueCoding?.extension_
            ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/ordinalValue',
        );
    if (ordinalExtension == null) {
      return null;
    }

    return ordinalExtension.valueDecimal;
  }

  /// Can the item be answered?
  ///
  /// Static or read-only items cannot be answered.
  /// Items which are not enabled cannot be answered.
  bool get isAnswerable {
    _rimLogger.trace('isAnswerable $linkId');
    if (questionnaireItemModel.isReadOnly || !isEnabled) {
      return false;
    }

    return true;
  }

  /// Is the item answered?
  ///
  /// Static or read-only items are not answered.
  /// Items which are not enabled are not answered.
  bool get isAnswered {
    _rimLogger.trace('isAnswered $linkId');
    if (!isAnswerable) {
      return false;
    }

    if (responseItem != null) {
      _rimLogger.debug('responseItem $responseItem');
      _rimLogger.debug('$linkId is answered.');
      return true;
    }

    return false;
  }

  /// Is the item unanswered?
  ///
  /// Static or read-only items are not unanswered.
  /// Items which are not enabled are not unanswered.
  bool get isUnanswered {
    _rimLogger.trace('isUnanswered $linkId');
    if (!isAnswerable) {
      return false;
    }

    if (responseItem != null) {
      _rimLogger.debug('responseItem $responseItem');
      return false;
    }

    _rimLogger.debug('$linkId is unanswered.');

    return true;
  }

  /// Is the item invalid?
  bool get isInvalid;

  Iterable<QuestionnaireErrorFlag>? get isComplete {
    if (questionnaireItemModel.isRequired && !isUnanswered) {
      return [
        QuestionnaireErrorFlag(
          linkId,
          errorText: lookupFDashLocalizations(questionnaireResponseModel.locale)
              .validatorRequiredItem,
        )
      ];
    }

    if (!isSatisfyingConstraint) {
      return [
        QuestionnaireErrorFlag(linkId,
            errorText: questionnaireItemModel.constraintHuman)
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
