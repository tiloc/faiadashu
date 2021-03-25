import 'dart:convert';
import 'dart:developer' as developer;

import 'package:fhir/r4/resource_types/specialized/definitional_artifacts/definitional_artifacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../model/aggregator.dart';
import '../model/questionnaire_location.dart';
import '../questionnaires.dart';

class QuestionnaireFiller extends StatefulWidget {
  final Widget child;
  final Future<QuestionnaireTopLocation> Function(dynamic param) loaderFuture;
  final dynamic loaderParam;
  static const String logTag = 'wof.QuestionnaireFiller';

  static Future<QuestionnaireTopLocation> _loadFromAsset(
      dynamic assetPath) async {
    developer.log('Enter _loadFromAsset', level: LogLevel.trace, name: logTag);
    final instrumentString = await rootBundle.loadString(assetPath.toString());
    final jsonQuestionnaire =
        json.decode(instrumentString) as Map<String, dynamic>;
    return QuestionnaireTopLocation.fromQuestionnaire(
      Questionnaire.fromJson(jsonQuestionnaire),
      aggregators: [
        TotalScoreAggregator(),
        NarrativeAggregator(),
        QuestionnaireResponseAggregator()
      ],
    );
  }

  QuestionnaireFiller.fromAsset(this.loaderParam,
      {Key? key, required this.child})
      // ignore: avoid_field_initializers_in_const_classes
      : loaderFuture = _loadFromAsset,
        super(key: key);

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
  late final Future<QuestionnaireTopLocation> builderFuture;
  QuestionnaireTopLocation? _topLocation;
  void Function()? _onTopChangeListenerFunction;
  late final String logTag;

  _QuestionnaireFillerState() {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
  }

  @override
  void initState() {
    super.initState();
    builderFuture = widget.loaderFuture.call(widget.loaderParam);
  }

  @override
  void dispose() {
    developer.log('dispose', level: LogLevel.trace, name: logTag);

    if (_onTopChangeListenerFunction != null && _topLocation != null) {
      _topLocation!.removeListener(_onTopChangeListenerFunction!);
      _topLocation = null;
      _onTopChangeListenerFunction = null;
    }
    super.dispose();
  }

  void _onTopChange() {
    developer.log('_onTopChange', level: LogLevel.trace, name: logTag);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    developer.log('Enter build()', level: LogLevel.trace, name: logTag);
    return FutureBuilder<QuestionnaireTopLocation>(
        future: builderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            developer.log('FutureBuilder hasData',
                level: LogLevel.debug, name: logTag);
            _topLocation = snapshot.data;
            if (_onTopChangeListenerFunction == null) {
              _onTopChangeListenerFunction = () => _onTopChange();
              _topLocation!.addListener(_onTopChangeListenerFunction!);
            }
            return QuestionnaireFillerData._(
              _topLocation!,
              child: widget.child,
            );
          } else {
            developer.log('FutureBuilder still waiting for data...',
                level: LogLevel.debug, name: logTag);
            return const CircularProgressIndicator();
          }
        });
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  final QuestionnaireTopLocation topLocation;
  final Iterable<QuestionnaireLocation> surveyLocations;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  late final int _revision;
  late final String logTag;

  QuestionnaireFillerData._(
    this.topLocation, {
    Key? key,
    required Widget child,
  })   : _revision = topLocation.revision,
        surveyLocations = topLocation.preOrder(),
        _itemFillers = List<QuestionnaireItemFiller?>.filled(
            topLocation.preOrder().length, null),
        super(key: key, child: child) {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
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
    return oldWidget._revision != _revision;
  }
}
