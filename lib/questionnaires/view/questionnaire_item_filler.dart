import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

/// A Widget to fill an individual [QuestionnaireItem].
/// The [decorator] is used to adapt the output style to the needs of the app.
abstract class QuestionnaireItemFiller extends StatefulWidget {
  final QuestionnaireLocation location;
  final QuestionnaireItemDecorator decorator;

  const QuestionnaireItemFiller(this.location, this.decorator, {Key? key})
      : super(key: key);
}

abstract class QuestionnaireItemState<V, W extends QuestionnaireItemFiller>
    extends State<W> {
  QuestionnaireItemState(V? value) : _value = value;
  final focusNode = FocusNode();

  V? _value;

  Widget buildBodyReadOnly(BuildContext context);

  Widget buildBodyEditable(BuildContext context);

  QuestionnaireResponseItem? createResponse() {
    final answer = createAnswer();
    return (answer != null)
        ? QuestionnaireResponseItem(
            linkId: widget.location.linkId,
            text: widget.location.questionnaireItem.text,
            answer: [answer])
        : null;
  }

  QuestionnaireResponseAnswer? createAnswer();

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        _value = newValue;
      });
    }
    if (!widget.location.isReadOnly) {
      widget.location.responseItem = createResponse();
    }
  }

  V? get value => _value;

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
