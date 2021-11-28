import 'package:flutter/material.dart';

import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

/// A view for filler items of type "display".
class DisplayItem extends QuestionnaireItemFiller {
  DisplayItem(
    QuestionnaireFillerData questionnaireFiller,
    FillerItemModel fillerItem, {
    Key? key,
  }) : super(questionnaireFiller, fillerItem, key: key);
  @override
  State<StatefulWidget> createState() => _DisplayItemState();
}

class _DisplayItemState extends QuestionnaireItemFillerState<DisplayItem> {
  _DisplayItemState();

  static final _dlogger = Logger(GroupItem);

  @override
  Widget build(BuildContext context) {
    _dlogger.trace(
      'build display item ${widget.fillerItemModel.nodeUid} hidden: ${widget.fillerItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.fillerItemModel.isEnabled}',
    );

    final titleWidget = this.titleWidget;

    final questionnaireItemModel =
        widget.fillerItemModel.questionnaireItemModel;

    return (questionnaireItemModel.isNotHidden &&
            questionnaireItemModel.isShownDuringCapture)
        ? Focus(
            focusNode: focusNode,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: widget.fillerItemModel.isEnabled
                  ? Column(
                      children: [
                        if (titleWidget != null) titleWidget,
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          )
        : const SizedBox(
            height: 16.0,
          );
  }
}
