import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../../../logging/logging.dart';
import '../../../../questionnaires.dart';

/// Filler for an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  final QuestionResponseItemFillerState responseFillerState;
  final int answerIndex;
  final QuestionnaireItemModel questionnaireItemModel;
  final QuestionItemModel responseItemModel;
  final QuestionnaireTheme questionnaireTheme;

  QuestionnaireAnswerFiller(
    this.responseFillerState,
    this.answerIndex, {
    Key? key,
  })  : responseItemModel = responseFillerState.questionResponseItemModel,
        questionnaireItemModel =
            responseFillerState.responseItemModel.questionnaireItemModel,
        questionnaireTheme = responseFillerState.questionnaireTheme,
        super(key: key);
}

abstract class QuestionnaireAnswerFillerState<
    V,
    W extends QuestionnaireAnswerFiller,
    M extends AnswerModel<Object, V>> extends State<W> {
  static final _abstractLogger = Logger(QuestionnaireAnswerFillerState);
  late final M answerModel;

  late final Object? answerModelError;

  late final FocusNode firstFocusNode;
  bool _isFocusHookedUp = false;

  QuestionnaireItem get qi => widget.questionnaireItemModel.questionnaireItem;
  Locale get locale =>
      widget.responseItemModel.questionnaireResponseModel.locale;
  QuestionnaireItemModel get itemModel => widget.questionnaireItemModel;

  QuestionnaireTheme get questionnaireTheme =>
      widget.responseFillerState.questionnaireTheme;

  QuestionnaireAnswerFillerState();

  @override
  void initState() {
    super.initState();

    try {
      answerModel =
          widget.responseItemModel.answerModel(widget.answerIndex) as M;

      answerModelError = null;

      firstFocusNode = FocusNode(
        debugLabel:
            'AnswerFiller firstFocusNode: ${widget.responseItemModel.responseUid}',
      );

      widget.responseItemModel.questionnaireResponseModel
          .addListener(_forceRebuild);

      postInitState();
    } catch (exception) {
      _abstractLogger.warn(
        'Could not initialize model for ${itemModel.linkId}',
        error: exception,
      );
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
    widget.responseItemModel.questionnaireResponseModel
        .removeListener(_forceRebuild);

    firstFocusNode.dispose();
    super.dispose();
  }

  // OPTIMIZE: Should everything listen to the central model on the top?
  // Or do something more hierarchical?

  /// Triggers a repaint of the filler.
  ///
  /// Required for visual updates on enablement changes.
  void _forceRebuild() {
    _abstractLogger.trace('_forceRebuild()');
    setState(() {
      // Just repaint.
    });
  }

  Widget _guardedBuildInputControl(BuildContext context) {
    if (answerModelError != null) {
      return BrokenQuestionnaireItem.fromException(answerModelError!);
    }

    // OPTIMIZE: Is there a more elegant solution? Do I have to unregister the listener?
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

    return buildInputControl(context);
  }

  Widget buildInputControl(BuildContext context);

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        // TODO: Should filling a single answer reset all error markers?
        widget.responseItemModel.questionnaireResponseModel.resetMarkers();
        answerModel.value = newValue;
      });

      if (answerModel.hasCodingAnswers) {
        widget.responseFillerState.onAnswered(
          answerModel.filledCodingAnswers,
          answerModel.answerIndex,
        );
      } else {
        widget.responseFillerState
            .onAnswered([answerModel.filledAnswer], answerModel.answerIndex);
      }
    }
  }

  V? get value => answerModel.value;

  @override
  Widget build(BuildContext context) {
    return _guardedBuildInputControl(context);
  }
}
