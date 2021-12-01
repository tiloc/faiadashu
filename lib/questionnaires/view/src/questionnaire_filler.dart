import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

/// Fill a [QuestionnaireResponse] from a [Questionnaire].
///
/// Provides visual components to view a [Questionnaire] and fill a [QuestionnaireResponse].
/// The components are provided as a [List] of [Widget]s of type [QuestionnaireItemFiller].
/// It is up to a higher-level component to present these to the user.
///
/// see: [QuestionnaireScrollerPage]
/// see: [QuestionnaireStepperPage]
class QuestionnaireResponseFiller extends StatefulWidget {
  final Locale locale;
  final WidgetBuilder builder;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final void Function(QuestionnaireResponseModel)? onDataAvailable;
  final QuestionnaireTheme questionnaireTheme;
  final QuestionnaireModelDefaults questionnaireModelDefaults;

  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;

  Future<QuestionnaireResponseModel>
      _createQuestionnaireResponseModel() async =>
          QuestionnaireResponseModel.fromFhirResourceBundle(
            locale: locale,
            aggregators: aggregators,
            fhirResourceProvider: fhirResourceProvider,
            launchContext: launchContext,
            questionnaireModelDefaults: questionnaireModelDefaults,
          );

  const QuestionnaireResponseFiller({
    Key? key,
    required this.locale,
    required this.builder,
    required this.fhirResourceProvider,
    required this.launchContext,
    this.aggregators,
    this.onDataAvailable,
    this.onLinkTap,
    this.questionnaireTheme = const QuestionnaireTheme(),
    this.questionnaireModelDefaults = const QuestionnaireModelDefaults(),
  }) : super(key: key);

  static QuestionnaireFillerData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<QuestionnaireFillerData>();
    assert(result != null, 'No QuestionnaireFillerData found in context');

    return result!;
  }

  @override
  _QuestionnaireResponseFillerState createState() =>
      _QuestionnaireResponseFillerState();
}

class _QuestionnaireResponseFillerState
    extends State<QuestionnaireResponseFiller> {
  static final _logger = Logger(_QuestionnaireResponseFillerState);

  late final Future<QuestionnaireResponseModel> builderFuture;
  QuestionnaireResponseModel? _questionnaireResponseModel;
  VoidCallback? _onQuestionnaireResponseModelChangeListenerFunction;
  // ignore: use_late_for_private_fields_and_variables
  QuestionnaireFillerData? _questionnaireFillerData;

  int _fillerItemCount = -1;

  @override
  void initState() {
    super.initState();
    builderFuture = widget._createQuestionnaireResponseModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _logger.trace('dispose');

    if (_onQuestionnaireResponseModelChangeListenerFunction != null &&
        _questionnaireResponseModel != null) {
      _questionnaireResponseModel!
          .removeListener(_onQuestionnaireResponseModelChangeListenerFunction!);
      _questionnaireResponseModel = null;
      _onQuestionnaireResponseModelChangeListenerFunction = null;
    }
    super.dispose();
  }

  void _onQuestionnaireResponseModelChange() {
    _logger.trace('_onQuestionnaireResponseModelChange');

    final newFillerItems =
        _questionnaireResponseModel!.orderedFillerItemModels();
    final newFillerItemCount = newFillerItems.length;

    if (mounted) {
      setState(() {
        if (_fillerItemCount != newFillerItemCount) {
          _logger
              .debug('Filler item count has changed. Updating filler views.');
          _fillerItemCount = newFillerItemCount;
          _questionnaireFillerData = QuestionnaireFillerData._(
            _questionnaireResponseModel!,
            locale: widget.locale,
            builder: widget.builder,
            onLinkTap: widget.onLinkTap,
            onDataAvailable: widget.onDataAvailable,
            questionnaireTheme: widget.questionnaireTheme,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _logger.trace('Enter build()');

    return FutureBuilder<QuestionnaireResponseModel>(
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
              _questionnaireResponseModel = snapshot.data;

              _fillerItemCount =
                  _questionnaireResponseModel!.orderedFillerItemModels().length;

              // OPTIMIZE: There has got to be a more elegant way? Goal is to register the listener exactly once, after the future has completed.
              if (_onQuestionnaireResponseModelChangeListenerFunction == null) {
                _onQuestionnaireResponseModelChangeListenerFunction =
                    () => _onQuestionnaireResponseModelChange();
                _questionnaireResponseModel!.addListener(
                  _onQuestionnaireResponseModelChangeListenerFunction!,
                );

                _questionnaireFillerData = QuestionnaireFillerData._(
                  _questionnaireResponseModel!,
                  locale: widget.locale,
                  builder: widget.builder,
                  onLinkTap: widget.onLinkTap,
                  onDataAvailable: widget.onDataAvailable,
                  questionnaireTheme: widget.questionnaireTheme,
                );
              }

              return _questionnaireFillerData!;
            }
            throw StateError(
              'FutureBuilder snapshot has unexpected state: $snapshot',
            );
        }
      },
    );
  }
}

// ignore: prefer-single-widget-per-file
class QuestionnaireFillerData extends InheritedWidget {
  static final _logger = Logger(QuestionnaireFillerData);

  final Locale locale;
  final QuestionnaireResponseModel questionnaireResponseModel;
  // TODO: Should this copy exist, or just refer to the qrm as the source of truth?
  final Iterable<FillerItemModel> fillerItemModels;

  final void Function(BuildContext context, Uri url)? onLinkTap;
  final void Function(QuestionnaireResponseModel)? onDataAvailable;
  final QuestionnaireTheme questionnaireTheme;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  final Map<String, QuestionnaireItemFillerState> _itemFillerStates = {};
  late final int _generation;

  QuestionnaireFillerData._(
    this.questionnaireResponseModel, {
    Key? key,
    required this.locale,
    this.onDataAvailable,
    this.onLinkTap,
    required this.questionnaireTheme,
    required WidgetBuilder builder,
  })  : _generation = questionnaireResponseModel.generation,
        fillerItemModels = questionnaireResponseModel.orderedFillerItemModels(),
        _itemFillers = List<QuestionnaireItemFiller?>.filled(
          questionnaireResponseModel.orderedFillerItemModels().length,
          null,
        ),
        super(key: key, child: Builder(builder: builder)) {
    _logger.trace('constructor _');
    onDataAvailable?.call(questionnaireResponseModel);
  }

  /// INTERNAL USE ONLY: Register a [QuestionnaireItemFillerState].
  void registerQuestionnaireItemFillerState(QuestionnaireItemFillerState qifs) {
    _itemFillerStates[qifs.responseUid] = qifs;
  }

  /// INTERNAL USE ONLY: Unregister a [QuestionnaireItemFillerState].
  void unregisterQuestionnaireItemFillerState(
    QuestionnaireItemFillerState qifs,
  ) {
    _itemFillerStates.remove(qifs.responseUid);
  }

  T aggregator<T extends Aggregator>() {
    return questionnaireResponseModel.aggregator<T>();
  }

  /// Requests focus on a [QuestionnaireItemFiller].
  ///
  /// The item filler will be determined as by [itemFillerAt].
  void requestFocus(int index) {
    _logger.trace('requestFocus $index');
    final fillerUid = fillerItemModels.elementAt(index).nodeUid;
    final itemFillerState = _itemFillerStates[fillerUid];
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
        fillerItemModels.elementAt(index),
        key: ValueKey<String>(
          'item-filler-${fillerItemModels.elementAt(index).nodeUid}',
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
