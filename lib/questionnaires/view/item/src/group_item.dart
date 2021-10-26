import 'package:flutter/material.dart';

import '../../../questionnaires.dart';

/// A pseudo-filler for items of type "group".
class GroupItem extends QuestionnaireAnswerFiller {
  GroupItem(
    QuestionnaireResponseFillerState responseFillerState,
    int answerIndex, {
    Key? key,
  }) : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  _GroupItemState();

  @override
  Widget build(BuildContext context) {
    final errorText = widget.itemModel.questionnaireModel
        .errorFlagForLinkId(widget.itemModel.linkId)
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
