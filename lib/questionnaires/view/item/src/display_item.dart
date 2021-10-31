import 'package:flutter/material.dart';

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

class _DisplayItemState extends State<DisplayItem> {
  _DisplayItemState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }
}
