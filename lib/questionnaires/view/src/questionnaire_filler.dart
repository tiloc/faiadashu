import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

/// Fill a [Questionnaire].
///
/// Provides visual components to view and fill a [Questionnaire].
/// The components are provided as a [List] of [Widget]s of type [QuestionnaireItemFiller].
/// It is up to a higher-level component to present these to the user.
///
/// see: [QuestionnaireScrollerPage]
/// see: [QuestionnaireStepperPage]
class QuestionnaireFiller extends StatefulWidget {
  final Locale locale;
  final WidgetBuilder builder;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final void Function(QuestionnaireModel)? onDataAvailable;
  final QuestionnaireTheme questionnaireTheme;

  final FhirResourceProvider fhirResourceProvider;

  Future<QuestionnaireModel> _createQuestionnaireModel() async =>
      QuestionnaireModel.fromFhirResourceBundle(
          locale: locale,
          aggregators: aggregators,
          fhirResourceProvider: fhirResourceProvider);

  const QuestionnaireFiller(
      {Key? key,
      required this.locale,
      required this.builder,
      required this.fhirResourceProvider,
      this.aggregators,
      this.onDataAvailable,
      this.onLinkTap,
      this.questionnaireTheme = const FDashQuestionnaireTheme()})
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
  static final _logger = Logger(_QuestionnaireFillerState);

  late final Future<QuestionnaireModel> builderFuture;
  QuestionnaireModel? _questionnaireModel;
  VoidCallback? _onQuestionnaireModelChangeListenerFunction;
  late final QuestionnaireFillerData _questionnaireFillerData;

  @override
  void initState() {
    super.initState();
    builderFuture = widget._createQuestionnaireModel();
  }

  @override
  void dispose() {
    _logger.trace('dispose');

    if (_onQuestionnaireModelChangeListenerFunction != null &&
        _questionnaireModel != null) {
      _questionnaireModel!
          .removeListener(_onQuestionnaireModelChangeListenerFunction!);
      _questionnaireModel = null;
      _onQuestionnaireModelChangeListenerFunction = null;
    }
    super.dispose();
  }

  void _onQuestionnaireModelChange() {
    _logger.trace('_onQuestionnaireModelChange');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _logger.trace('Enter build()');
    return FutureBuilder<QuestionnaireModel>(
        future: builderFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              // This should never happen in our use-case (is for streaming)
              _logger.warn('FutureBuilder is active...');
              return QuestionnaireLoadingIndicator(snapshot);
            case ConnectionState.none:
              return QuestionnaireLoadingIndicator(snapshot);
            case ConnectionState.waiting:
              _logger.debug('FutureBuilder still waiting for data...');
              return QuestionnaireLoadingIndicator(snapshot);
            case ConnectionState.done:
              if (snapshot.hasError) {
                _logger.warn('FutureBuilder hasError');
                return QuestionnaireLoadingIndicator(snapshot);
              }
              if (snapshot.hasData) {
                _logger.debug('FutureBuilder hasData');
                _questionnaireModel = snapshot.data;
                // TODO: There has got to be a more elegant way! Goal is to register the listener exactly once, after the future has completed.
                // Dart has abilities to chain Futures.
                if (_onQuestionnaireModelChangeListenerFunction == null) {
                  _onQuestionnaireModelChangeListenerFunction =
                      () => _onQuestionnaireModelChange();
                  _questionnaireModel!.addListener(
                      _onQuestionnaireModelChangeListenerFunction!);

                  _questionnaireFillerData = QuestionnaireFillerData._(
                      _questionnaireModel!,
                      locale: widget.locale,
                      builder: widget.builder,
                      onLinkTap: widget.onLinkTap,
                      onDataAvailable: widget.onDataAvailable,
                      questionnaireTheme: widget.questionnaireTheme);
                }
                return _questionnaireFillerData;
              }
              throw StateError(
                  'FutureBuilder snapshot has unexpected state: $snapshot');
          }
        });
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  static final _logger = Logger(QuestionnaireFillerData);

  final Locale locale;
  final QuestionnaireModel questionnaireModel;
  final Iterable<QuestionnaireItemModel> questionnaireItemModels;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final void Function(QuestionnaireModel)? onDataAvailable;
  final QuestionnaireTheme questionnaireTheme;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  late final List<GlobalKey<QuestionnaireItemFillerState>> _globalKeys;
  late final int _revision;

  QuestionnaireFillerData._(
    this.questionnaireModel, {
    Key? key,
    required this.locale,
    this.onDataAvailable,
    this.onLinkTap,
    required this.questionnaireTheme,
    required WidgetBuilder builder,
  })  : _revision = questionnaireModel.revision,
        questionnaireItemModels =
            questionnaireModel.orderedQuestionnaireItemModels(),
        _itemFillers = List<QuestionnaireItemFiller?>.filled(
            questionnaireModel.orderedQuestionnaireItemModels().length, null),
        super(key: key, child: Builder(builder: builder)) {
    _logger.trace('constructor _');
    // TODO: This constructor is being invoked from a build() method.
    // GlobalKeys should not be generated within a build() method.
    _globalKeys = questionnaireModel
        .orderedQuestionnaireItemModels()
        .map<GlobalKey<QuestionnaireItemFillerState>>(
            (qim) => GlobalKey(debugLabel: qim.linkId))
        .toList();
    onDataAvailable?.call(questionnaireModel);
  }

  T aggregator<T extends Aggregator>() {
    return questionnaireModel.aggregator<T>();
  }

  /// Requests focus on a [QuestionnaireItemFiller].
  ///
  /// The item filler will be determined as by [itemFillerAt].
  void requestFocus(int index) {
    _logger.trace('requestFocus $index');
    final currentState =
        (itemFillerAt(index).key as GlobalKey<QuestionnaireItemFillerState>?)
            ?.currentState;
    if (currentState == null) {
      _logger.warn('requestFocus $index: currentState == null');
    } else {
      currentState.requestFocus();
    }
  }

  /// Returns a list of all [QuestionnaireItemFiller]s.
  ///
  /// The [QuestionnaireItemFiller]s are ordered based on 'pre-order'.
  ///
  /// see: https://en.wikipedia.org/wiki/Tree_traversal#Pre-order,_NLR
  List<QuestionnaireItemFiller> itemFillers() {
    _logger.trace('itemFillers');
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

  /// Returns the [QuestionnaireItemFiller] at [index].
  ///
  /// The [QuestionnaireItemFiller]s are ordered based on 'pre-order'.
  ///
  /// see: https://en.wikipedia.org/wiki/Tree_traversal#Pre-order,_NLR
  QuestionnaireItemFiller itemFillerAt(int index) {
    _logger.trace('itemFillerAt $index');

    if (_itemFillers[index] == null) {
      _logger.debug('itemFillerAt $index will be created.');
      _itemFillers[index] = questionnaireTheme
          .createQuestionnaireItemFiller(this, index, key: _globalKeys[index]);
    } else {
      _logger.debug('itemFillerAt $index already exists.');
    }

    return _itemFillers[index]!;
  }

  @override
  bool updateShouldNotify(QuestionnaireFillerData oldWidget) {
    final shouldNotify = oldWidget._revision != _revision;
    _logger.debug('updateShouldNotify: $shouldNotify');
    return shouldNotify;
  }
}
