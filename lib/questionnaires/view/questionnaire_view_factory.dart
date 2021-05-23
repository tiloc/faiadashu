import 'package:flutter/material.dart';

import '../../logging/logger.dart';
import '../questionnaires.dart';

/// Create the views for filling all levels of a questionnaire.
abstract class QuestionnaireViewFactory {
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
      QuestionnaireItemFiller itemFiller);

  QuestionnaireAnswerFiller createAnswerFiller(
      QuestionnaireResponseFillerState responseFiller, int answerIndex);
}

/// The default implementation of [QuestionnaireViewFactory].
class DefaultQuestionnaireViewFactory implements QuestionnaireViewFactory {
  static final _logger = Logger(DefaultQuestionnaireViewFactory);

  const DefaultQuestionnaireViewFactory();

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
      QuestionnaireItemFiller itemFiller) {
    return QuestionnaireResponseFiller.fromQuestionnaireItemFiller(itemFiller);
  }

  @override
  QuestionnaireAnswerFiller createAnswerFiller(
      QuestionnaireResponseFillerState responseFiller, int answerIndex) {
    try {
      final responseModel = responseFiller.responseModel;

      _logger.debug('Creating AnswerFiller for ${responseModel.itemModel}');
      final answerModel = responseModel.answerModel(answerIndex);

      if (responseModel.itemModel.isCalculatedExpression) {
        // TODO: Should there be a dedicated CalculatedExpression Model and item?
        return StaticItem(responseFiller, answerIndex);
      } else if (answerModel is NumericalAnswerModel) {
        return NumericalAnswerFiller(responseFiller, answerIndex);
      } else if (answerModel is StringAnswerModel) {
        return StringAnswerFiller(responseFiller, answerIndex);
      } else if (answerModel is DateTimeAnswerModel) {
        return DateTimeAnswerFiller(responseFiller, answerIndex);
      } else if (answerModel is CodingAnswerModel) {
        return CodingAnswerFiller(responseFiller, answerIndex);
      } else if (answerModel is BooleanAnswerModel) {
        return BooleanAnswerFiller(responseFiller, answerIndex);
      } else if (answerModel is StaticAnswerModel) {
        return StaticItem(responseFiller, answerIndex);
      } else {
        throw QuestionnaireFormatException(
            'Unsupported AnswerModel: $answerModel');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return BrokenAnswerFiller(responseFiller, answerIndex, exception);
    }
  }
}
