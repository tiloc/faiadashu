import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../questionnaires.dart';

/// Create the views for all levels of a questionnaire. Provide styling theme.
class QuestionnaireTheme {
  static final _logger = Logger(QuestionnaireTheme);

  /// Returns whether user will be offered option to skip question.
  final bool canSkipQuestions;

  /// Returns whether user will be offered option for a null radio button value.
  final bool showNullAnswerOption;

  /// Returns whether each question will be preceded by its own ID.
  final bool showQuestionNumbers;

  const QuestionnaireTheme({
    this.canSkipQuestions = false,
    this.showNullAnswerOption = true,
    this.showQuestionNumbers = false,
  });

  /// Returns a [QuestionnaireItemFiller] for a given [QuestionnaireFiller].
  ///
  /// Used by [QuestionnaireFiller].
  QuestionnaireItemFiller createQuestionnaireItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    int index, {
    Key? key,
  }) {
    return QuestionnaireItemFiller.fromQuestionnaireFiller(
      questionnaireFiller,
      index,
      key: key,
    );
  }

  /// Returns a [QuestionnaireResponseFiller] for a given [QuestionnaireItemFiller].
  ///
  /// Used by [QuestionnaireItemFiller].
  QuestionnaireResponseFiller createQuestionnaireResponseFiller(
    QuestionnaireItemFiller itemFiller, {
    Key? key,
  }) {
    return QuestionnaireResponseFiller.fromQuestionnaireItemFiller(itemFiller);
  }

  /// Returns a [QuestionnaireAnswerFiller] for a given [QuestionnaireResponseFiller].
  ///
  /// Can be overridden through inheritance of [QuestionnaireTheme].
  QuestionnaireAnswerFiller createAnswerFiller(
    QuestionnaireResponseFillerState responseFiller,
    int answerIndex, {
    Key? key,
  }) {
    try {
      final responseModel = responseFiller.responseModel;

      _logger.debug('Creating AnswerFiller for ${responseModel.itemModel}');
      final answerModel = responseModel.answerModel(answerIndex);

      if (responseModel.itemModel.isScored) {
        // TODO: Should there be a dedicated Total Score item?
        return StaticItem(responseFiller, answerIndex, key: key);
      } else if (answerModel is NumericalAnswerModel) {
        return NumericalAnswerFiller(responseFiller, answerIndex, key: key);
      } else if (answerModel is StringAnswerModel) {
        return StringAnswerFiller(responseFiller, answerIndex, key: key);
      } else if (answerModel is DateTimeAnswerModel) {
        return DateTimeAnswerFiller(responseFiller, answerIndex, key: key);
      } else if (answerModel is CodingAnswerModel) {
        return CodingAnswerFiller(responseFiller, answerIndex, key: key);
      } else if (answerModel is BooleanAnswerModel) {
        return BooleanAnswerFiller(responseFiller, answerIndex, key: key);
      } else if (answerModel is DisplayAnswerModel ||
          answerModel is GroupAnswerModel) {
        return StaticItem(responseFiller, answerIndex, key: key);
      } else if (answerModel is UnsupportedAnswerModel) {
        throw QuestionnaireFormatException(
          'Unsupported item type: ${answerModel.qi.type}',
          answerModel.itemModel.linkId,
        );
      } else {
        throw QuestionnaireFormatException('Unknown AnswerModel: $answerModel');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return BrokenAnswerFiller(
        responseFiller,
        answerIndex,
        exception,
        key: key,
      );
    }
  }

  /// Returns a decoration for [TextFormField]s.
  ///
  /// Used for consistent styling of all text fields in the filler.
  InputDecoration createDecoration() {
    return const InputDecoration(filled: true);
  }
}
