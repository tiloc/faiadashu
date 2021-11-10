import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../coding/coding.dart';
import '../../../../l10n/l10n.dart';
import '../../../../logging/src/logger.dart';
import '../../../questionnaires.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionResponseItemFiller extends ResponseItemFiller {
  final QuestionItemModel questionResponseItemModel;

  QuestionResponseItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    int index,
    this.questionResponseItemModel,
  ) : super(questionnaireFiller, index, questionResponseItemModel);

  @override
  State<StatefulWidget> createState() => QuestionResponseItemFillerState();
}

class QuestionResponseItemFillerState
    extends ResponseItemFillerState<QuestionResponseItemFiller> {
  static final _qrimLogger = Logger(QuestionResponseItemFillerState);

  late final QuestionItemModel questionResponseItemModel;

  List<QuestionnaireAnswerFiller> _answerFillers = [];

  late final FocusNode _skipSwitchFocusNode;

  QuestionResponseItemFillerState();

  @override
  void initState() {
    super.initState();

    questionResponseItemModel = widget.questionResponseItemModel;

    _skipSwitchFocusNode = FocusNode(
      skipTraversal: true,
      debugLabel: 'SkipSwitch ${responseItemModel.responseUid}',
    );

    _createAnswerFillers();
  }

  @override
  void dispose() {
    _skipSwitchFocusNode.dispose();
    super.dispose();
  }

  void _createAnswerFillers() {
    final fillableAnswerModels = questionResponseItemModel.fillableAnswerModels;
    _answerFillers = fillableAnswerModels
        .map<QuestionnaireAnswerFiller>(
            (am) => questionnaireTheme.createAnswerFiller(this, am))
        .toList();
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
      'build ${widget.responseItemModel.responseUid} hidden: ${widget.responseItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.responseItemModel.isEnabled}',
    );
    return (!widget.responseItemModel.questionnaireItemModel.isHidden)
        ? Focus(
            focusNode: focusNode,
// Only enable for low-level focus coding
/*            onFocusChange: (gainedFocus) {
              debugDumpFocusTree();
            }, */
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: widget.responseItemModel.isEnabled
                  ? LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        // Wide landscape screen: Use horizontal layout
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: (constraints.maxWidth > 1000)
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (titleWidget != null)
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                          ),
                                          child: titleWidget,
                                        ),
                                      )
                                    else
                                      Expanded(child: Container()),
                                    Expanded(
                                      flex: 2,
                                      child: _buildAnswerFillers(context),
                                    )
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
                                    const SizedBox(width: 8),
                                    _buildAnswerFillers(context),
                                  ],
                                ),
                        );
                      },
                    )
                  : const SizedBox(),
            ),
          )
        : const SizedBox();
  }

  Widget _buildAnswerFillers(BuildContext context) {
    final canSkipQuestions = questionnaireTheme.canSkipQuestions;

    // TODO(tiloc) show a list of answers, and buttons to add/remove if repeat
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!questionResponseItemModel.isAskedButDeclined) ..._answerFillers,
        if (widget.questionnaireItemModel.isRepeating &&
            widget.responseItemModel.questionnaireResponseModel
                    .responseStatus ==
                QuestionnaireResponseStatus.in_progress)
          questionnaireTheme.buildAddRepetition(
            context,
            this,
            (!questionResponseItemModel.latestAnswerModel.isUnanswered)
                ? () {
                    setState(() {
                      questionResponseItemModel.addAnswerModel();
                      _createAnswerFillers();
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
              )
            ],
          )
      ],
    );
  }
}
