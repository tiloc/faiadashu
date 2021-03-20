import 'package:flutter/material.dart';

import '../model/aggregator.dart';
import '../model/questionnaire_location.dart';
import '../questionnaires.dart';

class QuestionnaireFiller extends StatefulWidget {
  final Widget child;
  final QuestionnaireTopLocation topLocation;

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
  int _revision = -1;

  _QuestionnaireFillerState();

  @override
  void initState() {
    super.initState();
    widget.topLocation.addListener(() => _onTopChange());
  }

  void _onTopChange() {
    _onRevisionChange(widget.topLocation.revision);
  }

  void _onRevisionChange(int newRevision) {
    setState(() {
      _revision = newRevision;
    });
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireFillerData._(
      widget.topLocation,
      revision: _revision,
      onRevisionChange: _onRevisionChange,
      child: widget.child,
    );
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  final QuestionnaireTopLocation topLocation;
  final Iterable<QuestionnaireLocation> surveyLocations;
  final int _revision;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  final ValueChanged<int> _onRevisionChange;

  QuestionnaireFillerData._(
    this.topLocation, {
    Key? key,
    required int revision,
    required ValueChanged<int> onRevisionChange,
    required Widget child,
  })   : surveyLocations = topLocation.preOrder(),
        _revision = revision,
        _onRevisionChange = onRevisionChange,
        super(key: key, child: child) {
    _itemFillers =
        List<QuestionnaireItemFiller?>.filled(surveyLocations.length, null);
  }

  T aggregator<T extends Aggregator>() {
    return topLocation.aggregator<T>();
  }

  static QuestionnaireFillerData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<QuestionnaireFillerData>();
    assert(result != null, 'No QuestionnaireFillerData found in context');
    return result!;
  }

  List<QuestionnaireItemFiller> itemFillers() {
    for (int i = 0; i < _itemFillers.length; i++) {
      if (_itemFillers[i] == null) {
        _itemFillers[i] = itemFillerAt(i);
      }
    }

    return _itemFillers
        .map<QuestionnaireItemFiller>(
            (itemFiller) => ArgumentError.checkNotNull(itemFiller))
        .toList();
  }

  QuestionnaireItemFiller itemFillerAt(int index) {
    _itemFillers[index] ??= QuestionnaireItemFiller.fromQuestionnaireItem(
        surveyLocations.elementAt(index));

    return _itemFillers[index]!;
  }

  @override
  bool updateShouldNotify(QuestionnaireFillerData oldWidget) {
    return oldWidget._revision != _revision ||
        oldWidget._onRevisionChange != _onRevisionChange;
  }
}
