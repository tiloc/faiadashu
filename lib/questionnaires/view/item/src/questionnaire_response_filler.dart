import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types.dart';
import '../../../../l10n/l10n.dart';
import '../../../questionnaires.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionnaireResponseFiller extends StatefulWidget {
  final QuestionnaireItemFiller itemFiller;
  final QuestionnaireItemModel itemModel;

  QuestionnaireResponseFiller._(this.itemFiller, this.itemModel)
      : super(key: ValueKey<String>(itemModel.linkId));

  factory QuestionnaireResponseFiller.fromQuestionnaireItemFiller(
    QuestionnaireItemFiller itemFiller,
  ) {
    return QuestionnaireResponseFiller._(itemFiller, itemFiller.itemModel);
  }

  @override
  State<StatefulWidget> createState() => QuestionnaireResponseFillerState();
}

class QuestionnaireResponseFillerState
    extends State<QuestionnaireResponseFiller> {
  List<QuestionnaireAnswerFiller> _answerFillers = [];
  late final ResponseModel responseModel;

  late final FocusNode _skipSwitchFocusNode;

  QuestionnaireTheme get questionnaireTheme =>
      widget.itemFiller.questionnaireFiller.questionnaireTheme;

  QuestionnaireResponseFillerState();

  @override
  void initState() {
    super.initState();
    responseModel = widget.itemModel.responseModel;

    _skipSwitchFocusNode = FocusNode(
      skipTraversal: true,
      debugLabel: 'SkipSwitch ${widget.itemModel.linkId}',
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
      responseModel.numberOfAnswers,
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
        if (responseModel.itemModel.questionnaireItem.type ==
                QuestionnaireItemType.choice ||
            responseModel.itemModel.questionnaireItem.type ==
                QuestionnaireItemType.open_choice) {
          responseModel.answers = answers ?? [];
        } else {
          responseModel.answers[answerIndex] = answers?.firstOrNull;
        }
        // This assumes all answers having the same dataAbsentReason.
        final newDataAbsentReason =
            answers?.firstOrNull?.extension_?.dataAbsentReason;
        responseModel.dataAbsentReason = newDataAbsentReason;
      });
    }

    // Report the response up the model hierarchy
    responseModel.updateResponse();
  }

  void _setDataAbsentReason(Code? dataAbsentReason) {
    if (mounted) {
      setState(() {
        responseModel.dataAbsentReason = dataAbsentReason;
      });
    }

    // Bubble up the response
    responseModel.updateResponse();
  }

  @override
  Widget build(BuildContext context) {
    final canSkipQuestions = questionnaireTheme.canSkipQuestions;

    // TODO(tiloc) show a list of answers, and buttons to add/remove if repeat
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!responseModel.isAskedButDeclined) ..._answerFillers,
        if (widget.itemModel.isRepeating &&
            widget.itemModel.questionnaireModel.responseStatus ==
                QuestionnaireResponseStatus.in_progress)
          questionnaireTheme.buildAddRepetition(
            context,
            this,
            (!responseModel
                    .answerModel(responseModel.numberOfAnswers - 1)
                    .isUnanswered)
                ? () {
                    setState(() {
                      responseModel.addAnswerModel();
                      _createAnswerFillers();
                    });
                  }
                : null,
          ),
        if (canSkipQuestions &&
            !widget.itemModel.isReadOnly &&
            !widget.itemModel.isRequired)
          Row(
            children: [
              Text(
                FDashLocalizations.of(context)
                    .dataAbsentReasonAskedDeclinedInputLabel,
              ),
              Switch(
                focusNode: _skipSwitchFocusNode,
                value: responseModel.isAskedButDeclined,
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
