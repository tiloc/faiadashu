import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

/// Filler for an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  final AnswerModel answerModel;
  final QuestionnaireItemModel questionnaireItemModel;
  final QuestionItemModel responseItemModel;
  final QuestionnaireTheme questionnaireTheme;

  QuestionnaireAnswerFiller(
    this.answerModel,
    this.questionnaireTheme, {
    Key? key,
  })  : responseItemModel = answerModel.responseItemModel,
        questionnaireItemModel =
            answerModel.responseItemModel.questionnaireItemModel,
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
  FocusNode? _parentFocusNode;

  QuestionnaireItem get qi => widget.questionnaireItemModel.questionnaireItem;
  Locale get locale =>
      widget.responseItemModel.questionnaireResponseModel.locale;
  QuestionnaireItemModel get itemModel => widget.questionnaireItemModel;

  QuestionnaireTheme get questionnaireTheme => widget.questionnaireTheme;

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

  // TODO: Can this be eliminated in favor of the normal initState?
  /// Initialize the filler after the model has been successfully finished.
  ///
  /// Do not place initialization code into [initState], but place it here.
  ///
  /// Guarantees a properly initialized [answerModel].
  void postInitState();

  @override
  void dispose() {
    _parentFocusNode?.removeListener(_handleFocusChange);
    firstFocusNode.dispose();
    super.dispose();
  }

  // FIXME: This assumes that questions can only have a single answer.
  void _handleFocusChange() {
    if ((_parentFocusNode?.hasPrimaryFocus ?? false) &&
        !firstFocusNode.hasPrimaryFocus) {
      firstFocusNode.requestFocus();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _parentFocusNode?.removeListener(_handleFocusChange);

    _parentFocusNode = Focus.maybeOf(context);
    _abstractLogger.debug('parentFocusNode: $_parentFocusNode');

    _parentFocusNode?.addListener(_handleFocusChange);
  }

  /// Factory method to create an input control for the answer.
  ///
  /// Will have guaranteed availability of [answerModel].
  ///
  /// Will be invoked everytime the [answerModel] changes.
  /// Thus, the returned Widget should preferably be const Stateless.
  Widget createInputControl();

  @override
  Widget build(BuildContext context) {
    final answerModelError = this.answerModelError;

    return answerModelError != null
        ? BrokenQuestionnaireItem.fromException(answerModelError)
        : AnimatedBuilder(
            // FIXME: It should be possible to change this to answerModel, but leads to severe malfunctions
            // Coding answers not working
            // No redraw when validity of question item changes
            animation: widget.responseItemModel,
            builder: (context, _) {
              try {
                return createInputControl();
              } catch (ex) {
                return BrokenQuestionnaireItem.fromException(ex);
              }
            },
          );
  }
}
