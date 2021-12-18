import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Filler for a [QuestionnaireResponseItem].
abstract class ResponseItemFiller extends QuestionnaireItemFiller {
  final ResponseItemModel responseItemModel;
  final QuestionnaireItemModel questionnaireItemModel;

  ResponseItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    this.responseItemModel,
  )   : questionnaireItemModel = responseItemModel.questionnaireItemModel,
        super(
          questionnaireFiller,
          responseItemModel,
          key: ValueKey<String>(
            responseItemModel.nodeUid,
          ),
        );
}

abstract class ResponseItemFillerState<W extends ResponseItemFiller>
    extends QuestionnaireItemFillerState<W> {
  late final ResponseItemModel responseItemModel;

  ResponseItemFillerState();

  @override
  void initState() {
    super.initState();
    responseItemModel = widget.responseItemModel;

    widget.responseItemModel.questionnaireResponseModel
        .addListener(forceRebuild);
  }

  @override
  void dispose() {
    widget.responseItemModel.questionnaireResponseModel
        .removeListener(forceRebuild);

    super.dispose();
  }
}
