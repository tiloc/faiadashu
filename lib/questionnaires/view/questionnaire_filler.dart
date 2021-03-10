import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/model/questionnaire_location.dart';

class QuestionnaireFiller extends StatefulWidget {
  final Widget child;
  final QuestionnaireLocation topLocation;

  const QuestionnaireFiller(this.topLocation, {Key? key, required this.child})
      : super(key: key);

  static QuestionnaireFillerData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<QuestionnaireFillerData>();
    assert(result != null, 'No QuestionnaireFillerData found in context');
    return result!;
  }

  @override
  _QuestionnaireFillerState createState() => _QuestionnaireFillerState();
}

class _QuestionnaireFillerState extends State<QuestionnaireFiller> {
  int revision;

  _QuestionnaireFillerState({this.revision = -1});

  @override
  void initState() {
    super.initState();
    widget.topLocation.addListener(() => _onTopChange());
  }

  void _onTopChange() {
    onRevisionChange(widget.topLocation.revision);
  }

  void onRevisionChange(int newRevision) {
    setState(() {
      revision = newRevision;
    });
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireFillerData(
      widget.topLocation,
      revision: revision,
      onRevisionChange: onRevisionChange,
      child: widget.child,
    );
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  final QuestionnaireLocation topLocation;
  final Iterable<QuestionnaireLocation> preOrder;
  final int revision;
  final ValueChanged<int>? onRevisionChange;

  QuestionnaireFillerData(
    this.topLocation, {
    Key? key,
    this.revision = -1,
    this.onRevisionChange,
    required Widget child,
  })   : preOrder = topLocation.preOrder(),
        super(key: key, child: child);

  static QuestionnaireFillerData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<QuestionnaireFillerData>();
    assert(result != null, 'No QuestionnaireFillerData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(QuestionnaireFillerData oldWidget) {
    return oldWidget.revision != revision ||
        oldWidget.onRevisionChange != onRevisionChange;
  }
}
