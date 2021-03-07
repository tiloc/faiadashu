import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

abstract class QuestionnaireItemWidget extends StatefulWidget {
  final QuestionnaireLocation location;
  final QuestionnaireItemDecorator decorator;

  const QuestionnaireItemWidget(this.location, this.decorator, {Key? key})
      : super(key: key);
}

abstract class QuestionnaireItemState extends State<QuestionnaireItemWidget> {
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return widget.decorator
        .build(context, widget.location, body: buildBody(context));
  }
}

abstract class QuestionnaireItemDecorator {
  const QuestionnaireItemDecorator();

  Widget build(BuildContext context, QuestionnaireLocation location,
      {required Widget body});
}
