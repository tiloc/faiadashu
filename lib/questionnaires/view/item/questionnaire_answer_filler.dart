import 'package:faiadashu/questionnaires/model/item/item_model_factory.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../questionnaires.dart';
import '../broken_questionnaire_item.dart';

/// Filler for an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  final QuestionnaireLocation location;
  final AnswerLocation answerLocation;

  const QuestionnaireAnswerFiller(this.location, this.answerLocation,
      {Key? key})
      : super(key: key);
}

abstract class QuestionnaireAnswerState<V, W extends QuestionnaireAnswerFiller,
    M extends ItemModel<Object, V>> extends State<W> {
  static final _abstractLogger = Logger(QuestionnaireAnswerState);
  late final M itemModel;

  late final Object? itemModelError;

  QuestionnaireItem get qi => widget.location.questionnaireItem;
  Locale get locale => widget.location.top.locale;
  QuestionnaireTopLocation get top => widget.location.top;
  QuestionnaireLocation get location => widget.location;

  QuestionnaireAnswerState();

  @override
  void initState() {
    super.initState();

    try {
      itemModel =
          ItemModelFactory.createModel<M>(location, widget.answerLocation) as M;

      itemModelError = null;
    } catch (exception) {
      _abstractLogger.warn('Could not initialize model for ${location.linkId}',
          error: exception);
      itemModelError = exception;
    }
  }

  Widget _guardedBuildReadOnly(BuildContext context) {
    if (itemModelError != null) {
      return BrokenQuestionnaireItem.fromException(itemModelError!);
    }

    return buildReadOnly(context);
  }

  Widget _guardedBuildEditable(BuildContext context) {
    if (itemModelError != null) {
      return BrokenQuestionnaireItem.fromException(itemModelError!);
    }

    return buildEditable(context);
  }

  Widget buildReadOnly(BuildContext context);

  Widget buildEditable(BuildContext context);

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        itemModel.value = newValue;
      });

      if (itemModel.hasCodingAnswers()) {
        widget.answerLocation.stashCodingAnswers(itemModel.fillCodingAnswers());
      } else {
        widget.answerLocation.stashAnswer(itemModel.fillAnswer());
      }
    }
  }

  V? get value => itemModel.value;

  @override
  Widget build(BuildContext context) {
    return widget.location.isReadOnly
        ? _guardedBuildReadOnly(context)
        : _guardedBuildEditable(context);
  }
}
