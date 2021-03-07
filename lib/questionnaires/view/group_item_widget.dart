import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'questionnaire_item_widget.dart';

class GroupItemWidget extends QuestionnaireItemWidget {
  const GroupItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends QuestionnaireItemState {
  _GroupItemState();

  @override
  Widget buildBody(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }
}
