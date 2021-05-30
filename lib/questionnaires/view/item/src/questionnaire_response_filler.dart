import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../model/item/response_model.dart';
import '../../../questionnaires.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionnaireResponseFiller extends StatefulWidget {
  final QuestionnaireItemFiller itemFiller;
  final QuestionnaireItemModel itemModel;

  QuestionnaireResponseFiller._(this.itemFiller, this.itemModel)
      : super(key: ValueKey<String>(itemModel.linkId));

  factory QuestionnaireResponseFiller.fromQuestionnaireItemFiller(
      QuestionnaireItemFiller itemFiller) {
    return QuestionnaireResponseFiller._(itemFiller, itemFiller.itemModel);
  }

  @override
  State<StatefulWidget> createState() => QuestionnaireResponseFillerState();
}

class QuestionnaireResponseFillerState
    extends State<QuestionnaireResponseFiller> {
  late final List<QuestionnaireAnswerFiller> _answerFillers;
  late final ResponseModel responseModel;

  late final FocusNode _skipSwitchFocusNode;

  QuestionnaireViewFactory get viewFactory =>
      widget.itemFiller.questionnaireFiller.viewFactory;

  QuestionnaireResponseFillerState();

  @override
  void initState() {
    super.initState();
    responseModel = widget.itemModel.responseModel;

    _skipSwitchFocusNode = FocusNode(
        skipTraversal: true,
        debugLabel: 'SkipSwitch ${widget.itemModel.linkId}');

    // TODO: Enhancement: Allow repeats = true for other kinds of items
    // This assumes that all answers are of the same kind
    // and repeats = true is only supported for choice items
    _answerFillers = [viewFactory.createAnswerFiller(this, 0)];
  }

  @override
  void dispose() {
    _skipSwitchFocusNode.dispose();
    super.dispose();
  }

  void onAnswered(
      List<QuestionnaireResponseAnswer?>? answers, int answerIndex) {
    // TODO: Should the responsemodel be updated in model code and then
    // setState() be invoked afterwards?
    if (mounted) {
      setState(() {
        responseModel.answers = answers ?? [];
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
    // TODO(tiloc) show a list of answers, and buttons to add/remove if repeat
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (!responseModel.isAskedButDeclined) ..._answerFillers,
      if (viewFactory.showSkipOption() &&
          !widget.itemModel.isReadOnly &&
          widget.itemModel.questionnaireItem.required_ != Boolean(true))
        Row(children: [
          const Text('I choose not to answer'),
          Switch(
            focusNode: _skipSwitchFocusNode,
            value: responseModel.isAskedButDeclined,
            onChanged: (bool value) {
              _setDataAbsentReason(
                  value ? dataAbsentReasonAskedButDeclinedCode : null);
            },
          )
        ])
    ]);
  }
}
