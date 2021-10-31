import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

/// A view for filler items of type "group".
class GroupItem extends ResponseItemFiller {
  GroupItem(
    QuestionnaireFillerData questionnaireFiller,
    int index,
    ResponseItemModel responseItemModel,
  ) : super(questionnaireFiller, index, responseItemModel);

  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  _GroupItemState();

  @override
  Widget build(BuildContext context) {
    final errorText = widget.responseItemModel.questionnaireResponseModel
        .errorFlagForResponseUid(widget.responseItemModel.responseUid)
        ?.errorText;

    return Column(
      children: [
        if (errorText != null)
          Container(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).errorColor),
            ),
          ),
        const SizedBox(
          height: 16.0,
        )
      ],
    );
  }
}
