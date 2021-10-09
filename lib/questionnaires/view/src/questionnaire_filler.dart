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
  final LaunchContext launchContext;

  Future<QuestionnaireModel> _createQuestionnaireModel() async =>
      QuestionnaireModel.fromFhirResourceBundle(
        locale: locale,
        aggregators: aggregators,
        fhirResourceProvider: fhirResourceProvider,
        launchContext: launchContext,
      );

  const QuestionnaireFiller({
    Key? key,
    required this.locale,
    required this.builder,
    required this.fhirResourceProvider,
    required this.launchContext,
    this.aggregators,
    this.onDataAvailable,
    this.onLinkTap,
    this.questionnaireTheme = const QuestionnaireTheme(),
  }) : super(key: key);

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
              _logger.warn('FutureBuilder hasError', error: snapshot.error);
              return QuestionnaireLoadingIndicator(snapshot);
            }
            if (snapshot.hasData) {
              _logger.debug('FutureBuilder hasData');
              _questionnaireModel = snapshot.data;
              // OPTIMIZE: There has got to be a more elegant way? Goal is to register the listener exactly once, after the future has completed.
              if (_onQuestionnaireModelChangeListenerFunction == null) {
                _onQuestionnaireModelChangeListenerFunction =
                    () => _onQuestionnaireModelChange();
                _questionnaireModel!.addListener(
                  _onQuestionnaireModelChangeListenerFunction!,
                );

                _questionnaireFillerData = QuestionnaireFillerData._(
                  _questionnaireModel!,
                  locale: widget.locale,
                  builder: widget.builder,
                  onLinkTap: widget.onLinkTap,
                  onDataAvailable: widget.onDataAvailable,
                  questionnaireTheme: widget.questionnaireTheme,
                );
              }
              return _questionnaireFillerData;
            }
            throw StateError(
              'FutureBuilder snapshot has unexpected state: $snapshot',
            );
        }
      },
    );
  }
}

// OPTIMIZE: Would there be any benefit in making this an InheritedNotifier, listening to the QuestionnaireModel?

class QuestionnaireFillerData extends InheritedWidget {
  static final _logger = Logger(QuestionnaireFillerData);

  final Locale locale;
  final QuestionnaireModel questionnaireModel;
  final Iterable<QuestionnaireItemModel> questionnaireItemModels;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final void Function(QuestionnaireModel)? onDataAvailable;
  final QuestionnaireTheme questionnaireTheme;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  final Map<int, QuestionnaireItemFillerState> _itemFillerStates = {};
  late final int _generation;

  QuestionnaireFillerData._(
    this.questionnaireModel, {
    Key? key,
    required this.locale,
    this.onDataAvailable,
    this.onLinkTap,
    required this.questionnaireTheme,
    required WidgetBuilder builder,
  })  : _generation = questionnaireModel.generation,
        questionnaireItemModels =
            questionnaireModel.orderedQuestionnaireItemModels(),
        _itemFillers = List<QuestionnaireItemFiller?>.filled(
          questionnaireModel.orderedQuestionnaireItemModels().length,
          null,
        ),
        super(key: key, child: Builder(builder: builder)) {
    _logger.trace('constructor _');
    onDataAvailable?.call(questionnaireModel);
  }

  /// INTERNAL USE ONLY: Register a [QuestionnaireItemFillerState].
  void registerQuestionnaireItemFillerState(QuestionnaireItemFillerState qifs) {
    _itemFillerStates[_indexOfLinkId(qifs.linkId)] = qifs;
  }

  /// INTERNAL USE ONLY: Unregister a [QuestionnaireItemFillerState].
  void unregisterQuestionnaireItemFillerState(
    QuestionnaireItemFillerState qifs,
  ) {
    _itemFillerStates.remove(_indexOfLinkId(qifs.linkId));
  }

  int _indexOfLinkId(String linkId) {
    return _itemFillers.indexWhere((qif) => qif?.itemModel.linkId == linkId);
  }

  T aggregator<T extends Aggregator>() {
    return questionnaireModel.aggregator<T>();
  }

  /// Requests focus on a [QuestionnaireItemFiller].
  ///
  /// The item filler will be determined as by [itemFillerAt].
  void requestFocus(int index) {
    _logger.trace('requestFocus $index');
    final itemFillerState = _itemFillerStates[index];
    if (itemFillerState == null) {
      _logger.warn('requestFocus $index: itemFillerState == null');
    } else {
      itemFillerState.requestFocus();
    }
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
      _itemFillers[index] = questionnaireTheme.createQuestionnaireItemFiller(
        this,
        index,
        key: ValueKey<String>(
          'item-filler-${questionnaireItemModels.elementAt(index).linkId}',
        ),
      );
    } else {
      _logger.debug('itemFillerAt $index already exists.');
    }

    return _itemFillers[index]!;
  }

  @override
  bool updateShouldNotify(QuestionnaireFillerData oldWidget) {
    final shouldNotify = oldWidget._generation != _generation;
    _logger.debug('updateShouldNotify: $shouldNotify');
    return shouldNotify;
  }
}
