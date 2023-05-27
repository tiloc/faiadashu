import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

/// A view for filler items of type "group".
class GroupItem extends ResponseItemFiller {
  GroupItem(
    super.questionnaireFiller,
    super.responseItemModel, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends ResponseItemFillerState<GroupItem> {
  static final _gLogger = Logger(GroupItem);

  _GroupItemState();

  @override
  Widget build(BuildContext context) {
    _gLogger.trace(
      'build group ${widget.responseItemModel}',
    );

    final titleWidget = this.titleWidget;

    return AnimatedBuilder(
      animation: widget.responseItemModel,
      builder: (context, _) {
        final errorText = widget.responseItemModel.errorText;

        return widget.responseItemModel.displayVisibility !=
                DisplayVisibility.hidden
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (titleWidget != null) titleWidget,
                  if (errorText != null)
                    Container(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        errorText,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                      ),
                    ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
