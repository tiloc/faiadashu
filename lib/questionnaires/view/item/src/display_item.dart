import 'package:flutter/material.dart';

import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

/// A view for filler items of type "display".
class DisplayItem extends QuestionnaireItemFiller {
  const DisplayItem(
    QuestionnaireFillerData questionnaireFiller,
    int index,
    FillerItemModel fillerItem, {
    Key? key,
  }) : super(questionnaireFiller, index, fillerItem, key: key);
  @override
  State<StatefulWidget> createState() => _DisplayItemState();
}

class _DisplayItemState extends QuestionnaireItemFillerState<DisplayItem> {
  _DisplayItemState();

  static final _dlogger = Logger(GroupItem);

  @override
  Widget build(BuildContext context) {
    _dlogger.trace(
      'build display item ${widget.fillerItemModel.responseUid} hidden: ${widget.fillerItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.fillerItemModel.isEnabled}',
    );

    final titleWidget = this.titleWidget;

    return (!widget.fillerItemModel.questionnaireItemModel.isHidden)
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
                        )
                      ],
                    )
                  : const SizedBox(),
            ),
          )
        : const SizedBox(height: 16.0,);
  }
}
