import 'dart:convert';

import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../logging/logging.dart';
import '../questionnaires.dart';
import '../valueset/valueset_provider.dart';

class QuestionnaireFiller extends StatefulWidget {
  final WidgetBuilder builder;
  final Future<QuestionnaireTopLocation> Function(
      dynamic param, ValueSetProvider? valueSetProvider) loaderFuture;
  final dynamic loaderParam;
  final ValueSetProvider? valueSetProvider;
  static final logger = Logger(QuestionnaireFiller);

  static Future<QuestionnaireTopLocation> _loadFromString(
      dynamic instrumentString, ValueSetProvider? valueSetProvider) async {
    final jsonQuestionnaire =
        json.decode(instrumentString as String) as Map<String, dynamic>;
    final topLocation = QuestionnaireTopLocation.fromQuestionnaire(
        Questionnaire.fromJson(jsonQuestionnaire),
        aggregators: [
          TotalScoreAggregator(),
          NarrativeAggregator(),
          QuestionnaireResponseAggregator()
        ],
        valueSetProvider: valueSetProvider);

    await topLocation.initState();

    return topLocation;
  }

  static Future<QuestionnaireTopLocation> _loadFromAsset(
      dynamic assetPath, ValueSetProvider? valueSetProvider) async {
    logger.log('Enter _loadFromAsset', level: LogLevel.trace);
    final instrumentString = await rootBundle.loadString(assetPath.toString());
    return _loadFromString(instrumentString, valueSetProvider);
  }

  const QuestionnaireFiller.fromAsset(this.loaderParam,
      {Key? key, required this.builder, this.valueSetProvider})
      // ignore: avoid_field_initializers_in_const_classes
      : loaderFuture = _loadFromAsset,
        super(key: key);

  const QuestionnaireFiller.fromString(this.loaderParam,
      {Key? key, required this.builder, this.valueSetProvider})
      // ignore: avoid_field_initializers_in_const_classes
      : loaderFuture = _loadFromString,
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
  static final logger = Logger(_QuestionnaireFillerState);

  late final Future<QuestionnaireTopLocation> builderFuture;
  QuestionnaireTopLocation? _topLocation;
  void Function()? _onTopChangeListenerFunction;

  @override
  void initState() {
    super.initState();
    builderFuture =
        widget.loaderFuture.call(widget.loaderParam, widget.valueSetProvider);
  }

  @override
  void dispose() {
    logger.log('dispose', level: LogLevel.trace);

    if (_onTopChangeListenerFunction != null && _topLocation != null) {
      _topLocation!.removeListener(_onTopChangeListenerFunction!);
      _topLocation = null;
      _onTopChangeListenerFunction = null;
    }
    super.dispose();
  }

  void _onTopChange() {
    logger.log('_onTopChange', level: LogLevel.trace);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.log('Enter build()', level: LogLevel.trace);
    return FutureBuilder<QuestionnaireTopLocation>(
        future: builderFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              // TODO: This should never happen in our use-case?
              logger.log('FutureBuilder is active...', level: LogLevel.debug);
              return QuestionnaireLoadingIndicator(snapshot);
            case ConnectionState.none:
              return QuestionnaireLoadingIndicator(snapshot);
            case ConnectionState.waiting:
              logger.log('FutureBuilder still waiting for data...',
                  level: LogLevel.debug);
              return QuestionnaireLoadingIndicator(snapshot);
            case ConnectionState.done:
              if (snapshot.hasError) {
                logger.log('FutureBuilder hasError', level: LogLevel.warn);
                return QuestionnaireLoadingIndicator(snapshot);
              }
              if (snapshot.hasData) {
                logger.log('FutureBuilder hasData');
                _topLocation = snapshot.data;
                // TODO: There has got to be a more elegant way! Goal is to register the lister exactly once, after the future has completed.
                // Can I do .then for that?
                if (_onTopChangeListenerFunction == null) {
                  _onTopChangeListenerFunction = () => _onTopChange();
                  _topLocation!.addListener(_onTopChangeListenerFunction!);
                }
                return QuestionnaireFillerData._(
                  _topLocation!,
                  builder: widget.builder,
                );
              }
              throw StateError(
                  'FutureBuilder snapshot has unexpected state: $snapshot');
          }
        });
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  static final logger = Logger(QuestionnaireFillerData);
  final QuestionnaireTopLocation topLocation;
  final Iterable<QuestionnaireLocation> surveyLocations;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  late final int _revision;

  QuestionnaireFillerData._(
    this.topLocation, {
    Key? key,
    required WidgetBuilder builder,
  })   : _revision = topLocation.revision,
        surveyLocations = topLocation.preOrder(),
        _itemFillers = List<QuestionnaireItemFiller?>.filled(
            topLocation.preOrder().length, null),
        super(key: key, child: Builder(builder: builder));

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
