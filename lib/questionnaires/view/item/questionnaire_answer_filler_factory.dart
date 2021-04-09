import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../faiadashu.dart';
import '../../model/questionnaire_location.dart';
import '../broken_questionnaire_item.dart';
import 'answer/answer.dart';
import 'item.dart';

// ignore: avoid_classes_with_only_static_members
class QuestionnaireAnswerFillerFactory {
  static final logger = Logger(QuestionnaireAnswerFillerFactory);

  static QuestionnaireAnswerFiller fromQuestionnaireItem(
      QuestionnaireLocation location, AnswerLocation answerLocation) {
    logger.log('Creating AnswerFiller for $location', level: LogLevel.debug);

    try {
      switch (location.questionnaireItem.type!) {
        case QuestionnaireItemType.choice:
        case QuestionnaireItemType.open_choice:
          return ChoiceAnswer(location, answerLocation);
        case QuestionnaireItemType.quantity:
        case QuestionnaireItemType.decimal:
        case QuestionnaireItemType.integer:
          return (location.isCalculatedExpression)
              ? StaticItem(location, answerLocation)
              : NumericalAnswer(location, answerLocation);
        case QuestionnaireItemType.string:
        case QuestionnaireItemType.text:
        case QuestionnaireItemType.url:
          return StringAnswer(location, answerLocation);
        case QuestionnaireItemType.display:
        case QuestionnaireItemType.group:
          return StaticItem(location, answerLocation);
        case QuestionnaireItemType.date:
        case QuestionnaireItemType.datetime:
        case QuestionnaireItemType.time:
          return DateTimeAnswer(location, answerLocation);
        case QuestionnaireItemType.boolean:
          return BooleanAnswer(location, answerLocation);
        case QuestionnaireItemType.attachment:
        case QuestionnaireItemType.unknown:
        case QuestionnaireItemType.reference:
          throw QuestionnaireFormatException(
              'Unsupported item type: ${location.questionnaireItem.type!}');
      }
    } catch (exception) {
      logger.log('Cannot create answer filler:',
          level: LogLevel.warn, error: exception);
      return _BrokenItem(location, answerLocation, exception);
    }
  }
}

class _BrokenItem extends QuestionnaireAnswerFiller {
  final Object exception;

  const _BrokenItem(QuestionnaireLocation location,
      AnswerLocation answerLocation, this.exception)
      : super(location, answerLocation);

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
        widget.location.questionnaireItem,
        widget.exception);
  }
}
