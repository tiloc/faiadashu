import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types.dart';
import '../../../../l10n/l10n.dart';
import '../../../questionnaires.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionResponseItemFiller extends ResponseItemFiller {
  final QuestionResponseItemModel questionResponseItemModel;

  QuestionResponseItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    int index,
    this.questionResponseItemModel,
  ) : super(
          questionnaireFiller,
          index,
          questionResponseItemModel,
// FIXME: Restore key handling
/*          key: ValueKey<String>(
            responseItemModel.linkId,
          ), */
        ); // FIXME: linkId is not unique

  @override
  State<StatefulWidget> createState() => QuestionResponseItemFillerState();
}

class QuestionResponseItemFillerState
    extends ResponseItemFillerState<QuestionResponseItemFiller> {
  late final QuestionResponseItemModel questionResponseItemModel;

  List<QuestionnaireAnswerFiller> _answerFillers = [];

  late final FocusNode _skipSwitchFocusNode;

  QuestionResponseItemFillerState();

  @override
  void initState() {
    super.initState();

    questionResponseItemModel = widget.questionResponseItemModel;

    // FIXME: LinkId is not unique
    _skipSwitchFocusNode = FocusNode(
      skipTraversal: true,
      debugLabel: 'SkipSwitch ${responseItemModel.linkId}',
    );

    _createAnswerFillers();
  }

  @override
  void dispose() {
    _skipSwitchFocusNode.dispose();
    super.dispose();
  }

  void _createAnswerFillers() {
    // OPTIMIZE: Reuse existing fillers
    _answerFillers = List.generate(
      questionResponseItemModel.numberOfAnswers,
      (index) => questionnaireTheme.createAnswerFiller(this, index),
    );
  }

  void onAnswered(
    List<QuestionnaireResponseAnswer?>? answers,
    int answerIndex,
  ) {
    // TODO: Should the responsemodel be updated in model code and then
    // setState() be invoked afterwards?
    if (mounted) {
      setState(() {
        if (questionResponseItemModel
                    .questionnaireItemModel.questionnaireItem.type ==
                QuestionnaireItemType.choice ||
            questionResponseItemModel
                    .questionnaireItemModel.questionnaireItem.type ==
                QuestionnaireItemType.open_choice) {
          questionResponseItemModel.answers = answers ?? [];
        } else {
          questionResponseItemModel.answers[answerIndex] = answers?.firstOrNull;
        }
        // This assumes all answers having the same dataAbsentReason.
        final newDataAbsentReason =
            answers?.firstOrNull?.extension_?.dataAbsentReason;
        questionResponseItemModel.dataAbsentReason = newDataAbsentReason;
      });
    }

    // Report the response up the model hierarchy
    questionResponseItemModel.updateResponse();
  }

  void _setDataAbsentReason(Code? dataAbsentReason) {
    if (mounted) {
      setState(() {
        questionResponseItemModel.dataAbsentReason = dataAbsentReason;
      });
    }

    // Bubble up the response
    questionResponseItemModel.updateResponse();
  }

  @override
  Widget build(BuildContext context) {
// FIXME: Restore tracing
    /*    _logger.trace(
     'build $linkId hidden: ${widget.responseItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.responseItemModel.isEnabled}',
    );
*/
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
                                        child: _buildAnswerFillers(context))
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
            (!questionResponseItemModel
                    .answerModel(questionResponseItemModel.numberOfAnswers - 1)
                    .isUnanswered)
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
