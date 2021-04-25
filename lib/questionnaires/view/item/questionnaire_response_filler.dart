import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../coding/coding.dart';
import '../../../coding/data_absent_reasons.dart';
import '../../../fhir_types/fhir_types_extensions.dart';
import '../../model/item/response_model.dart';
import '../../questionnaires.dart';
import 'questionnaire_answer_filler_factory.dart';

/// Filler for a [QuestionnaireResponseItem].
class QuestionnaireResponseFiller extends StatefulWidget {
  final QuestionnaireItemModel itemModel;

  QuestionnaireResponseFiller(this.itemModel)
      : super(key: ValueKey<String>(itemModel.linkId));

  @override
  State<StatefulWidget> createState() => QuestionnaireResponseState();
}

class QuestionnaireResponseState extends State<QuestionnaireResponseFiller> {
  late final List<QuestionnaireAnswerFiller> _answerFillers;
  late final ResponseModel responseModel;

  QuestionnaireResponseState();

  @override
  void initState() {
    super.initState();
    responseModel = ResponseModel(widget.itemModel);

    // TODO: Enhancement: Allow repeats = true for other kinds of items
    // This assumes that all answers are of the same kind
    // and repeats = true is only supported for choice items
    _answerFillers = [
      QuestionnaireAnswerFillerFactory.fromQuestionnaireItem(widget.itemModel,
          AnswerLocation(responseModel.answers, 0, _stashAnswers))
    ];
  }

  void _stashAnswers(
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
            value: responseModel.isAskedButDeclined,
            onChanged: (bool value) {
              _setDataAbsentReason(
                  value ? DataAbsentReason.askedButDeclinedCode : null);
            },
          )
        ])
    ]);
  }
}
