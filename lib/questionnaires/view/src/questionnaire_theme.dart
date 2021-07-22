import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../questionnaires.dart';

/// Create the views for all levels of a questionnaire. Provide styling theme.
abstract class QuestionnaireTheme {
  /// Returns a [QuestionnaireItemFiller] for a given [QuestionnaireFiller].
  ///
  /// Used by [QuestionnaireFiller].
  QuestionnaireItemFiller createQuestionnaireItemFiller(
      QuestionnaireFillerData questionnaireFiller, int index,
      {Key? key});

  /// Returns a [QuestionnaireResponseFiller] for a given [QuestionnaireItemFiller].
  ///
  /// Used by [QuestionnaireItemFiller].
  QuestionnaireResponseFiller createQuestionnaireResponseFiller(
      QuestionnaireItemFiller itemFiller,
      {Key? key});

  QuestionnaireAnswerFiller createAnswerFiller(
      QuestionnaireResponseFillerState responseFiller, int answerIndex,
      {Key? key});

  /// Returns a decoration for [TextFormField]s.
  ///
  /// Used for consistent styling of all text fields in the filler.
  InputDecoration createDecoration();

  /// Returns whether user will be offered option to skip question.
  bool showSkipOption();

  /// Returns whether user will be offered option for a null radio button value.
  bool showNullCodingOption();
}

/// The Faiadashu default implementation of [QuestionnaireTheme].
class FDashQuestionnaireTheme implements QuestionnaireTheme {
  static final _logger = Logger(FDashQuestionnaireTheme);

  /// These options may be set to customize the Faiadashu default theme
  ///
  /// To use this, call `questionnaireTheme: FDashQuestionnaireTheme()`
  /// within [QuestionnaireScroller], [QuestionnaireScrollerPage],
  /// [QuestionnaireStepper], or [QuestionnaireStepperPage]
  /// and set the options you want

  final bool? canSkipQuestions;
  final bool? showNullAnswerChoices;

  const FDashQuestionnaireTheme(
      {this.canSkipQuestions, this.showNullAnswerChoices});

  @override
  QuestionnaireItemFiller createQuestionnaireItemFiller(
      QuestionnaireFillerData questionnaireFiller, int index,
      {Key? key}) {
    return QuestionnaireItemFiller.fromQuestionnaireFiller(
        questionnaireFiller, index,
        key: key);
  }

  @override
  QuestionnaireResponseFiller createQuestionnaireResponseFiller(
      QuestionnaireItemFiller itemFiller,
      {Key? key}) {
    return QuestionnaireResponseFiller.fromQuestionnaireItemFiller(itemFiller);
  }

  @override
  QuestionnaireAnswerFiller createAnswerFiller(
      QuestionnaireResponseFillerState responseFiller, int answerIndex,
      {Key? key}) {
    try {
      final responseModel = responseFiller.responseModel;

      _logger.debug('Creating AnswerFiller for ${responseModel.itemModel}');
      final answerModel = responseModel.answerModel(answerIndex);

      if (responseModel.itemModel.isCalculatedExpression) {
        // TODO: Should there be a dedicated CalculatedExpression Model and item?
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
      } else if (answerModel is StaticAnswerModel) {
        return StaticItem(responseFiller, answerIndex, key: key);
      } else if (answerModel is UnsupportedAnswerModel) {
        throw QuestionnaireFormatException(
            'Unsupported item type: ${answerModel.qi.type}',
            answerModel.itemModel.linkId);
      } else {
        throw QuestionnaireFormatException('Unknown AnswerModel: $answerModel');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return BrokenAnswerFiller(responseFiller, answerIndex, exception,
          key: key);
    }
  }

  @override
  InputDecoration createDecoration() {
    return const InputDecoration(filled: true);
  }

  @override
  bool showSkipOption() => canSkipQuestions ?? false;

  @override
  bool showNullCodingOption() => showNullAnswerChoices ?? true;
}
