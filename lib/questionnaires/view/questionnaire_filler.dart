import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../logging/logging.dart';
import '../../resource_provider/resource_provider.dart';
import '../questionnaires.dart';

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
      this.onLinkTap})
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

  void _onTopChange() {
    _logger.trace('_onTopChange');
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
                // TODO: There has got to be a more elegant way! Goal is to register the lister exactly once, after the future has completed.
                // Dart has abilities to chain Futures.
                if (_onQuestionnaireModelChangeListenerFunction == null) {
                  _onQuestionnaireModelChangeListenerFunction =
                      () => _onTopChange();
                  _questionnaireModel!.addListener(
                      _onQuestionnaireModelChangeListenerFunction!);
                }
                return QuestionnaireFillerData._(
                  _questionnaireModel!,
                  locale: widget.locale,
                  builder: widget.builder,
                  onLinkTap: widget.onLinkTap,
                  onDataAvailable: widget.onDataAvailable,
                );
              }
              throw StateError(
                  'FutureBuilder snapshot has unexpected state: $snapshot');
          }
        });
  }
}

class QuestionnaireFillerData extends InheritedWidget {
  final Locale locale;
  final QuestionnaireModel questionnaireModel;
  final Iterable<QuestionnaireItemModel> questionnaireItemModels;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final void Function(QuestionnaireModel)? onDataAvailable;
  late final List<QuestionnaireItemFiller?> _itemFillers;
  late final int _revision;

  QuestionnaireFillerData._(
    this.questionnaireModel, {
    Key? key,
    required this.locale,
    this.onDataAvailable,
    this.onLinkTap,
    required WidgetBuilder builder,
  })   : _revision = questionnaireModel.revision,
        questionnaireItemModels =
            questionnaireModel.orderedQuestionnaireItemModels(),
        _itemFillers = List<QuestionnaireItemFiller?>.filled(
            questionnaireModel.orderedQuestionnaireItemModels().length, null),
        super(key: key, child: Builder(builder: builder)) {
    onDataAvailable?.call(questionnaireModel);
  }

  T aggregator<T extends Aggregator>() {
    return questionnaireModel.aggregator<T>();
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
        questionnaireItemModels.elementAt(index));

    return _itemFillers[index]!;
  }

  @override
  bool updateShouldNotify(QuestionnaireFillerData oldWidget) {
    return oldWidget._revision != _revision;
  }
}
