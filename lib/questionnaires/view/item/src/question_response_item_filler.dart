import 'package:faiadashu/coding/coding.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/src/logger.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionResponseItemFiller extends ResponseItemFiller {
  final QuestionItemModel questionResponseItemModel;

  QuestionResponseItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    this.questionResponseItemModel, {
    Key? key,
  }) : super(questionnaireFiller, questionResponseItemModel, key: key);

  @override
  State<StatefulWidget> createState() => QuestionResponseItemFillerState();
}

class QuestionResponseItemFillerState
    extends ResponseItemFillerState<QuestionResponseItemFiller> {
  static final _qrimLogger = Logger(QuestionResponseItemFillerState);

  late final QuestionItemModel questionResponseItemModel;

  final _answerFillers = <String, QuestionnaireAnswerFiller>{};

  late final FocusNode _skipSwitchFocusNode;

  late final RenderingString? _promptText;

  QuestionResponseItemFillerState();

  @override
  void initState() {
    super.initState();

    questionResponseItemModel = widget.questionResponseItemModel;

    _skipSwitchFocusNode = FocusNode(
      skipTraversal: true,
      debugLabel: 'SkipSwitch ${responseItemModel.nodeUid}',
    );

    _initAnswerFillers();

    _promptText =
        questionResponseItemModel.questionnaireItemModel.promptTextItem?.text;
  }

  @override
  void dispose() {
    _skipSwitchFocusNode.dispose();
    super.dispose();
  }

  void _initAnswerFillers() {
    final fillableAnswerModels = questionResponseItemModel.fillableAnswerModels;
    for (final answerModel in fillableAnswerModels) {
      _answerFillers[answerModel.nodeUid] =
          questionnaireTheme.createAnswerFiller(
        this,
        answerModel,
        key: ValueKey<String>('answer-filler-${answerModel.nodeUid}'),
      );
    }
  }

  void _addAnswerFiller(AnswerModel answerModel) {
    _answerFillers[answerModel.nodeUid] = questionnaireTheme.createAnswerFiller(
      this,
      answerModel,
      key: ValueKey<String>('answer-filler-${answerModel.nodeUid}'),
    );
  }

  void _setDataAbsentReason(Code? dataAbsentReason) {
    if (mounted) {
      setState(() {
        questionResponseItemModel.dataAbsentReason = dataAbsentReason;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _qrimLogger.trace(
      'build ${widget.responseItemModel} hidden: ${widget.responseItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.responseItemModel.isEnabled}',
    );

    final promptText = _promptText;

    return AnimatedBuilder(
      animation: widget.responseItemModel,
      builder: (context, _) {
        const int twoThirds = 2;

        return widget.responseItemModel.displayVisibility !=
                DisplayVisibility.hidden
            ? Focus(
// Only enable for low-level focus coding
/*            onFocusChange: (gainedFocus) {
              debugDumpFocusTree();
            }, */
                focusNode: focusNode,
                child: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints constraints,
                  ) {
                    // Wide landscape screen: Use horizontal layout
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: (constraints.maxWidth >
                              questionnaireTheme.landscapeBreakpoint)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (titleWidget != null)
                                      Expanded(
                                        child: titleWidget!,
                                      )
                                    else
                                      Expanded(child: Container()),
                                    Expanded(
                                      flex: twoThirds,
                                      child: _buildAnswerFillers(context),
                                    ),
                                  ],
                                ),
                                if (promptText != null)
                                  const SizedBox(height: 8.0),
                                if (promptText != null)
                                  Xhtml.fromXhtmlString(
                                    context,
                                    promptText,
                                  ),
                                const SizedBox(height: 16.0),
                              ],
                            )
                          // Narrow, portrait screen: Use vertical layout
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (titleWidget != null)
                                  Container(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: titleWidget,
                                  ),
                                _buildAnswerFillers(context),
                                if (promptText != null)
                                  Xhtml.fromXhtmlString(
                                    context,
                                    promptText,
                                  ),
                                const SizedBox(width: 8),
                              ],
                            ),
                    );
                  },
                ),
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildAnswerFillers(BuildContext context) {
    final canSkipQuestions = questionnaireTheme.canSkipQuestions;

    final isRepeating = widget.questionnaireItemModel.isRepeating;
    final hasMoreThanOneAnswer = _answerFillers.length > 1;

    final decoratedAnswerFillers =
        _decorateAnswerFillers(context, isRepeating, hasMoreThanOneAnswer);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!questionResponseItemModel.isAskedButDeclined)
          ...decoratedAnswerFillers,
        if (isRepeating &&
            widget.responseItemModel.questionnaireResponseModel
                    .responseStatus ==
                QuestionnaireResponseStatus.in_progress)
          questionnaireTheme.buildAddRepetition(
            context,
            this,
            (questionResponseItemModel.latestAnswerModel.isNotEmpty)
                ? () {
                    setState(() {
                      final newAnswerModel =
                          questionResponseItemModel.addAnswerModel();
                      _addAnswerFiller(newAnswerModel);
                    });
                  }
                : null,
          ),
        if (canSkipQuestions &&
            !widget.questionnaireItemModel.isReadOnly &&
            !widget.questionnaireItemModel.isRequired)
          Row(
            children: [
              Text(
                FDashLocalizations.of(context)
                    .dataAbsentReasonAskedDeclinedInputLabel,
              ),
              Switch(
                focusNode: _skipSwitchFocusNode,
                value: questionResponseItemModel.isAskedButDeclined,
                onChanged: (bool value) {
                  _setDataAbsentReason(
                    value ? dataAbsentReasonAskedButDeclinedCode : null,
                  );
                },
              ),
            ],
          ),
      ],
    );
  }

  Iterable<Widget> _decorateAnswerFillers(
    BuildContext context,
    bool isRepeating,
    bool hasMoreThanOneAnswer,
  ) {
    return isRepeating
        ? _answerFillers.values.map<Widget>(
            (answerFiller) => questionnaireTheme.decorateRepeatingAnswer(
              context,
              answerFiller,
              hasMoreThanOneAnswer &&
                      widget.responseItemModel.questionnaireResponseModel
                              .responseStatus ==
                          QuestionnaireResponseStatus.in_progress
                  ? () {
                      _removeAnswerFiller(answerFiller);
                    }
                  : null,
            ),
          )
        : _answerFillers.values;
  }

  void _removeAnswerFiller(QuestionnaireAnswerFiller answerFiller) {
    final answerModel = answerFiller.answerModel;

    setState(() {
      questionResponseItemModel.removeAnswerModel(answerModel);
      final removedAnswerFiller = _answerFillers.remove(answerModel.nodeUid);
      _qrimLogger.debug(
        'Removed answerfiller: $removedAnswerFiller',
      );
    });
  }
}
