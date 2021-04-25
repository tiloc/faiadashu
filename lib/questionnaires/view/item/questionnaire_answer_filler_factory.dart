import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../faiadashu.dart';
import '../../model/questionnaire_item_model.dart';
import '../broken_questionnaire_item.dart';
import 'answer/answer.dart';
import 'item.dart';

// ignore: avoid_classes_with_only_static_members
class QuestionnaireAnswerFillerFactory {
  static final _logger = Logger(QuestionnaireAnswerFillerFactory);

  static QuestionnaireAnswerFiller fromQuestionnaireItem(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation) {
    _logger.debug('Creating AnswerFiller for $itemModel');

    try {
      switch (itemModel.questionnaireItem.type!) {
        case QuestionnaireItemType.choice:
        case QuestionnaireItemType.open_choice:
          return CodingAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.quantity:
        case QuestionnaireItemType.decimal:
        case QuestionnaireItemType.integer:
          return (itemModel.isCalculatedExpression)
              ? StaticItem(itemModel, answerLocation)
              : NumericalAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.string:
        case QuestionnaireItemType.text:
        case QuestionnaireItemType.url:
          return StringAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.display:
        case QuestionnaireItemType.group:
          return StaticItem(itemModel, answerLocation);
        case QuestionnaireItemType.date:
        case QuestionnaireItemType.datetime:
        case QuestionnaireItemType.time:
          return DateTimeAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.boolean:
          return BooleanAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.attachment:
        case QuestionnaireItemType.unknown:
        case QuestionnaireItemType.reference:
          throw QuestionnaireFormatException(
              'Unsupported item type: ${itemModel.questionnaireItem.type!}');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return _BrokenItem(itemModel, answerLocation, exception);
    }
  }
}

class _BrokenItem extends QuestionnaireAnswerFiller {
  final Object exception;

  const _BrokenItem(QuestionnaireItemModel itemModel,
      AnswerLocation answerLocation, this.exception)
      : super(itemModel, answerLocation);

  @override
  State<StatefulWidget> createState() => _BrokenItemState();
}

class _BrokenItemState extends State<_BrokenItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BrokenQuestionnaireItem(
        'Could not initialize QuestionnaireAnswerFiller',
        widget.itemModel.questionnaireItem,
        widget.exception);
  }
}
