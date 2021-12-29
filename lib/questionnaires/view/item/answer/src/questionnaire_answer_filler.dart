import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

/// Filler for an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  final QuestionResponseItemFillerState responseFillerState;
  final AnswerModel answerModel;
  final QuestionnaireItemModel questionnaireItemModel;
  final QuestionItemModel responseItemModel;
  final QuestionnaireTheme questionnaireTheme;

  QuestionnaireAnswerFiller(
    this.responseFillerState,
    this.answerModel, {
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
  M get answerModel => widget.answerModel as M;

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

    Object? answerModelError;

    try {
      firstFocusNode = FocusNode(
        debugLabel:
            'AnswerFiller firstFocusNode: ${widget.responseItemModel.nodeUid}',
      );

      postInitState();
    } catch (exception) {
      _abstractLogger.warn(
        'Could not initialize model for ${itemModel.linkId}',
        error: exception,
      );
      answerModelError = exception;
    } finally {
      this.answerModelError = answerModelError;
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

  Widget _guardedBuildInputControl(BuildContext context) {
    if (answerModelError != null) {
      return BrokenQuestionnaireItem.fromException(answerModelError!);
    }

    // OPTIMIZE: Is there a more elegant solution? Do I have to unregister the listener?
    // Listen to the parent FocusNode and become focussed when it does.
    if (!_isFocusHookedUp) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        // Focus.of could otherwise fail with: Looking up a deactivated widget's ancestor is unsafe.
        if (mounted) {
          Focus.maybeOf(context)?.addListener(_handleFocusChange);
        }
      });
      _isFocusHookedUp = true;
    }

    return buildInputControl(context);
  }

  void _handleFocusChange() {
    if ((firstFocusNode.parent?.hasPrimaryFocus ?? false) &&
        !firstFocusNode.hasPrimaryFocus) {
      firstFocusNode.requestFocus();
    }
  }

  Widget buildInputControl(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.responseItemModel,
      builder: (context, _) {
        return _guardedBuildInputControl(context);
      },
    );
  }
}
