import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

/// Filler for an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
//  static final _logger = Logger(QuestionnaireAnswerFiller);
  final QuestionnaireResponseFillerState responseFillerState;
  final int answerIndex;
  final QuestionnaireItemModel itemModel;
  final QuestionnaireViewFactory viewFactory;

  QuestionnaireAnswerFiller(this.responseFillerState, this.answerIndex,
      {Key? key})
      : itemModel = responseFillerState.responseModel.itemModel,
        viewFactory = responseFillerState
            .widget.itemFiller.questionnaireFiller.viewFactory,
        super(key: key);
}

abstract class QuestionnaireAnswerState<V, W extends QuestionnaireAnswerFiller,
    M extends AnswerModel<Object, V>> extends State<W> {
  static final _abstractLogger = Logger(QuestionnaireAnswerState);
  late final M answerModel;

  late final Object? answerModelError;

  late final FocusNode firstFocusNode;
  bool _isFocusHookedUp = false;

  QuestionnaireItem get qi => widget.itemModel.questionnaireItem;
  Locale get locale => widget.itemModel.questionnaireModel.locale;
  QuestionnaireItemModel get itemModel => widget.itemModel;

  QuestionnaireViewFactory get viewFactory => widget
      .responseFillerState.widget.itemFiller.questionnaireFiller.viewFactory;

  QuestionnaireAnswerState();

  @override
  void initState() {
    super.initState();

    try {
      answerModel = widget.responseFillerState.responseModel
          .answerModel(widget.answerIndex) as M;

      answerModelError = null;

      firstFocusNode = FocusNode(
          debugLabel:
              'AnswerFiller firstFocusNode: ${widget.itemModel.linkId}');

      postInitState();
    } catch (exception) {
      _abstractLogger.warn('Could not initialize model for ${itemModel.linkId}',
          error: exception);
      answerModelError = exception;
    }
  }

  /// Initialize the filler after the model has been successfully finished.
  ///
  /// Do not place initialization code into [initState], but place it here.
  ///
  /// Guarantees a properly initialized [answerModel].
  void postInitState();

  @override
  void dispose() {
    firstFocusNode.dispose();
    super.dispose();
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

    // TODO: Is there a more elegant solution? Do I have to unregister the listener?
    // Listen to the parent FocusNode and become focussed when it does.
    if (!_isFocusHookedUp) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        Focus.of(context).addListener(() {
          if ((firstFocusNode.parent?.hasPrimaryFocus ?? false) &&
              !firstFocusNode.hasPrimaryFocus) {
            firstFocusNode.requestFocus();
          }
        });
      });
      _isFocusHookedUp = true;
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
        widget.responseFillerState.onAnswered(
            answerModel.fillCodingAnswers(), answerModel.answerIndex);
      } else {
        widget.responseFillerState
            .onAnswered([answerModel.fillAnswer()], answerModel.answerIndex);
      }
    }
  }

  V? get value => answerModel.value;

  @override
  Widget build(BuildContext context) {
    return widget.itemModel.isReadOnly
        ? _guardedBuildReadOnly(context)
        : _guardedBuildEditable(context);
  }
}
