import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

/// Filler for a [QuestionnaireResponseItem].
abstract class ResponseItemFiller extends QuestionnaireItemFiller {
  final ResponseItemModel responseItemModel;
  final QuestionnaireItemModel questionnaireItemModel;

  ResponseItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    int index,
    this.responseItemModel,
  )   : questionnaireItemModel = responseItemModel.questionnaireItemModel,
        super(
          questionnaireFiller,
          index,
          responseItemModel,
          key: ValueKey<String>(
            responseItemModel.responseUid,
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
