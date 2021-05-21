import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../coding/coding.dart';
import '../../../coding/data_absent_reasons.dart';
import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logger.dart';
import '../../model/item/response_model.dart';
import '../../questionnaires.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionnaireResponseFiller extends StatefulWidget {
  final QuestionnaireItemModel itemModel;

  QuestionnaireResponseFiller(this.itemModel)
      : super(key: ValueKey<String>(itemModel.linkId));

  @override
  State<StatefulWidget> createState() => QuestionnaireResponseFillerState();
}

class QuestionnaireResponseFillerState
    extends State<QuestionnaireResponseFiller> {
  static final _logger = Logger(QuestionnaireResponseFillerState);
  late final List<QuestionnaireAnswerFiller> _answerFillers;
  late final ResponseModel responseModel;

  late final FocusNode _skipSwitchFocusNode;

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
    _answerFillers = [_createAnswerFiller(0)];
  }

  @override
  void dispose() {
    _skipSwitchFocusNode.dispose();
    super.dispose();
  }

  void onAnswered(
      List<QuestionnaireResponseAnswer?>? answers, int answerIndex) {
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
      if (!widget.itemModel.isReadOnly &&
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

  QuestionnaireAnswerFiller _createAnswerFiller(int answerIndex) {
    _logger.debug('Creating AnswerFiller for ${responseModel.itemModel}');

    final answerModel = responseModel.answerModel(answerIndex);

    try {
      if (responseModel.itemModel.isCalculatedExpression) {
        // TODO: Should there be a dedicated CalculatedExpression Model and item?
        return StaticItem(this, answerIndex);
      } else if (answerModel is NumericalAnswerModel) {
        return NumericalAnswerFiller(this, answerIndex);
      } else if (answerModel is StringAnswerModel) {
        return StringAnswerFiller(this, answerIndex);
      } else if (answerModel is DateTimeAnswerModel) {
        return DateTimeAnswerFiller(this, answerIndex);
      } else if (answerModel is CodingAnswerModel) {
        return CodingAnswerFiller(this, answerIndex);
      } else if (answerModel is BooleanAnswerModel) {
        return BooleanAnswerFiller(this, answerIndex);
      } else if (answerModel is StaticAnswerModel) {
        return StaticItem(this, answerIndex);
      } else {
        throw QuestionnaireFormatException(
            'Unsupported AnswerModel: $answerModel');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return BrokenAnswerFiller(this, answerIndex, exception);
    }
  }
}
