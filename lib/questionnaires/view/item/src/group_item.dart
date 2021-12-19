import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

/// A view for filler items of type "group".
class GroupItem extends ResponseItemFiller {
  GroupItem(
    QuestionnaireFillerData questionnaireFiller,
    ResponseItemModel responseItemModel, {
    Key? key,
  }) : super(questionnaireFiller, responseItemModel, key: key);

  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends ResponseItemFillerState<GroupItem> {
  static final _glogger = Logger(GroupItem);

  _GroupItemState();

  @override
  Widget build(BuildContext context) {
    _glogger.trace(
      'build group ${widget.responseItemModel.nodeUid} hidden: ${widget.responseItemModel.questionnaireItemModel.isHidden}, enabled: ${widget.responseItemModel.isEnabled}',
    );

    final errorText = widget.responseItemModel.errorText;

    final titleWidget = this.titleWidget;

    final questionnaireItemModel =
        widget.fillerItemModel.questionnaireItemModel;

    return (questionnaireItemModel.isNotHidden &&
            questionnaireItemModel.isShownDuringCapture)
        ? Focus(
            focusNode: focusNode,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: AnimatedBuilder(
                animation: widget.responseItemModel.questionnaireResponseModel,
                builder: (context, _) {
                  return widget.responseItemModel.isEnabled
                      ? Column(
                          children: [
                            if (titleWidget != null) titleWidget,
                            if (errorText != null)
                              Container(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  errorText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Theme.of(context).errorColor,
                                      ),
                                ),
                              ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        )
                      : const SizedBox();
                },
              ),
            ),
          )
        : const SizedBox();
  }
}
