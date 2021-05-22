import 'package:flutter/material.dart';

import '../questionnaires.dart';

abstract class QuestionnaireViewFactory {
  /// Returns a [QuestionnaireItemFiller] for a given [QuestionnaireItemModel].
  ///
  /// Used by [QuestionnaireFiller].
  QuestionnaireItemFiller createQuestionnaireItemFiller(
      QuestionnaireItemModel itemModel,
      {Key? key});

  /// Returns a [QuestionnaireResponseFiller] for a given [QuestionnaireItemModel].
  ///
  /// Used by [QuestionnaireItemFiller].
  QuestionnaireResponseFiller createQuestionnaireResponseFiller(
      QuestionnaireItemModel itemModel);
}

class DefaultQuestionnaireViewFactory implements QuestionnaireViewFactory {
  const DefaultQuestionnaireViewFactory();

  @override
  QuestionnaireItemFiller createQuestionnaireItemFiller(
      QuestionnaireItemModel itemModel,
      {Key? key}) {
    return QuestionnaireItemFiller.fromQuestionnaireItemModel(itemModel,
        key: key);
  }

  @override
  QuestionnaireResponseFiller createQuestionnaireResponseFiller(
      QuestionnaireItemModel itemModel) {
    return QuestionnaireResponseFiller(itemModel);
  }
}
