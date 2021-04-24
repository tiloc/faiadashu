import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../model/item/answer/answer_model_factory.dart';
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
    M extends AnswerModel<Object, V>> extends State<W> {
  static final _abstractLogger = Logger(QuestionnaireAnswerState);
  late final M answerModel;

  late final Object? answerModelError;

  QuestionnaireItem get qi => widget.location.questionnaireItem;
  Locale get locale => widget.location.top.locale;
  QuestionnaireLocation get location => widget.location;

  QuestionnaireAnswerState();

  @override
  void initState() {
    super.initState();

    try {
      answerModel =
          AnswerModelFactory.createModel<M>(location, widget.answerLocation)
              as M;

      answerModelError = null;
    } catch (exception) {
      _abstractLogger.warn('Could not initialize model for ${location.linkId}',
          error: exception);
      answerModelError = exception;
    }
  }

  Widget _guardedBuildReadOnly(BuildContext context) {
    if (answerModelError != null) {
      return BrokenQuestionnaireItem.fromException(answerModelError!);
    }

    return buildReadOnly(context);
  }

  Widget _guardedBuildEditable(BuildContext context) {
    if (answerModelError != null) {
      return BrokenQuestionnaireItem.fromException(answerModelError!);
    }

    return buildEditable(context);
  }

  Widget buildReadOnly(BuildContext context) {
    return Text(answerModel.display);
  }

  Widget buildEditable(BuildContext context);

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        answerModel.value = newValue;
      });

      if (answerModel.hasCodingAnswers()) {
        widget.answerLocation
            .stashCodingAnswers(answerModel.fillCodingAnswers());
      } else {
        widget.answerLocation.stashAnswer(answerModel.fillAnswer());
      }
    }
  }

  V? get value => answerModel.value;

  @override
  Widget build(BuildContext context) {
    return widget.location.isReadOnly
        ? _guardedBuildReadOnly(context)
        : _guardedBuildEditable(context);
  }
}
