import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

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
      'build ${widget.fillerItemModel}',
    );

    final titleWidget = this.titleWidget;

    return AnimatedBuilder(
      animation: widget.fillerItemModel,
      builder: (context, _) {
        return widget.fillerItemModel.displayVisibility !=
                DisplayVisibility.hidden
            ? Column(
                children: [
                  if (titleWidget != null) titleWidget,
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
