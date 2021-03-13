import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/model/aggregator.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import '../model/questionnaire_location.dart';
import 'questionnaire_item_filler_factory.dart';

class QuestionnaireFiller extends StatefulWidget {
  final Widget child;
  final QuestionnaireLocation topLocation;
  final List<Aggregator>? _aggregators;

  QuestionnaireFiller(this.topLocation,
      {Key? key, required this.child, List<Aggregator>? aggregators})
      : _aggregators = aggregators,
        super(key: key) {
    if (aggregators != null) {
      for (final aggregator in aggregators) {
        aggregator.init(topLocation);
      }
    }

    topLocation.aggregate();
  }

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
      aggregators: widget._aggregators,
      child: widget.child,
    );
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  final QuestionnaireLocation topLocation;
  final Iterable<QuestionnaireLocation> surveyLocations;
  final int _revision;
  // TODO(tiloc) is it worth the extra complexity of this being nullable?
  late final List<QuestionnaireItemFiller?> _itemFillers;
  final ValueChanged<int> _onRevisionChange;
  final List<Aggregator>? _aggregators;

  QuestionnaireFillerData._(
    this.topLocation, {
    Key? key,
    required int revision,
    required List<Aggregator>? aggregators,
    required ValueChanged<int> onRevisionChange,
    required Widget child,
  })   : surveyLocations = topLocation.preOrder(),
        _revision = revision,
        _onRevisionChange = onRevisionChange,
        _aggregators = aggregators,
        super(key: key, child: child) {
    _itemFillers =
        List<QuestionnaireItemFiller?>.filled(surveyLocations.length, null);
  }

  T aggregator<T extends Aggregator>() {
    if (_aggregators == null) {
      throw StateError('Aggregators have not been specified in constructor.');
    }
    return (_aggregators?.firstWhere((aggregator) => aggregator is T) as T?)!;
  }

  static QuestionnaireFillerData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<QuestionnaireFillerData>();
    assert(result != null, 'No QuestionnaireFillerData found in context');
    return result!;
  }

  List<QuestionnaireItemFiller> itemFillers(
      QuestionnaireItemDecorator decorator) {
    for (int i = 0; i < _itemFillers.length; i++) {
      if (_itemFillers[i] == null) {
        _itemFillers[i] = itemFillerAt(i, decorator);
      }
    }

    return _itemFillers
        .map<QuestionnaireItemFiller>(
            (itemFiller) => ArgumentError.checkNotNull(itemFiller))
        .toList();
  }

  QuestionnaireItemFiller itemFillerAt(
      int index, QuestionnaireItemDecorator decorator) {
    _itemFillers[index] ??=
        QuestionnaireItemFillerFactory.fromQuestionnaireItem(
            surveyLocations.elementAt(index), decorator);

    return _itemFillers[index]!;
  }

  @override
  bool updateShouldNotify(QuestionnaireFillerData oldWidget) {
    return oldWidget._revision != _revision ||
        oldWidget._onRevisionChange != _onRevisionChange;
  }
}
