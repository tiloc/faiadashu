import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

/// A Widget to work with an individual [QuestionnaireItem].
/// The [decorator] is used to adapt the output style to the needs of the app.
abstract class QuestionnaireItemWidget extends StatefulWidget {
  final QuestionnaireLocation location;
  final QuestionnaireItemDecorator decorator;

  const QuestionnaireItemWidget(this.location, this.decorator, {Key? key})
      : super(key: key);
}

abstract class QuestionnaireItemState<T>
    extends State<QuestionnaireItemWidget> {
  QuestionnaireItemState(T? value) : _value = value;

  T? _value;

  Widget buildBodyReadOnly(BuildContext context);

  Widget buildBodyEditable(BuildContext context);

  QuestionnaireResponseItem createResponse();

  set value(T? newValue) {
    if (mounted) {
      setState(() {
        _value = newValue;
      });
    }
    widget.location.responseItem = createResponse();
  }

  T? get value => _value;

  @override
  Widget build(BuildContext context) {
    return widget.decorator.build(context, widget.location,
        body: (widget.location.isReadOnly)
            ? buildBodyReadOnly(context)
            : buildBodyEditable(context));
  }
}

abstract class QuestionnaireItemDecorator {
  const QuestionnaireItemDecorator();

  Widget build(BuildContext context, QuestionnaireLocation location,
      {required Widget body});
}
