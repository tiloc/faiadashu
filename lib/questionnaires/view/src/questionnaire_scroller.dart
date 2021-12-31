import 'dart:math';

import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// Fills a [Questionnaire] through a vertically scrolling input form.
///
/// Takes the [QuestionnaireItemFiller]s as provided by the [QuestionnaireResponseFiller]
/// and presents them as a scrolling [ListView].
///
/// The [scaffoldBuilder] is used to build a wrapper around the list.
///
/// A set of mandatory and optional FHIR resources need to be provided through
/// the [fhirResourceProvider]:
/// * (mandatory) [questionnaireResourceUri] - the [Questionnaire]
/// * (optional) [questionnaireResponseResourceUri] - the [QuestionnaireResponse].
/// Will be used to prefill the filler, if present.
///
/// The [launchContext] is used to provide:
/// * (mandatory) - the [Patient]
///
/// See: [QuestionnaireScrollerPage] for a [QuestionnaireScroller] which already
/// wraps the list in a ready-made [Scaffold], incl. some commonly used buttons.
class QuestionnaireScroller extends StatefulWidget {
  final Locale? locale;
  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final QuestionnairePageScaffoldBuilder scaffoldBuilder;
  final QuestionnaireTheme questionnaireTheme;
  final QuestionnaireModelDefaults questionnaireModelDefaults;

  final void Function(QuestionnaireResponseModel?)?
      onQuestionnaireResponseChanged;

  const QuestionnaireScroller({
    this.locale,
    required this.scaffoldBuilder,
    required this.fhirResourceProvider,
    required this.launchContext,
    this.aggregators,
    this.onLinkTap,
    this.questionnaireTheme = const QuestionnaireTheme(),
    this.questionnaireModelDefaults = const QuestionnaireModelDefaults(),
    this.onQuestionnaireResponseChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuestionnaireScrollerState();
  }
}

class _QuestionnaireScrollerState extends State<QuestionnaireScroller> {
  QuestionnaireResponseModel? _questionnaireResponseModel;
  final ItemScrollController _listScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  BuildContext? _belowFillerContext;

  // What is the desired position to scroll to?
  int _focusIndex = -1;

  bool _isLoaded = false;

  // Has the scroller already been scrolled once to the desired position?
  bool _isPositioned = false;

  // Has the focus already been placed?
  bool _isFocussed = false;

  static final _logger = Logger(_QuestionnaireScrollerState);

  _QuestionnaireScrollerState() : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleChangedQuestionnaireResponse() {
    widget.onQuestionnaireResponseChanged?.call(_questionnaireResponseModel);
  }

  /// Scrolls to a position for a [FillerItemModel].
  ///
  /// The item will also be focussed.
  void scrollToItem(FillerItemModel fillerItemModel) {
    if (_questionnaireResponseModel == null) {
      _logger.info(
        'Trying to scroll before QuestionnaireModel is loaded. Ignoring.',
      );

      return;
    }

    final index = _questionnaireResponseModel!
        .indexOfFillerItem((fim) => fim == fillerItemModel);

    scrollTo(index!);
  }

  /// Scrolls to a position as conveyed by an [index].
  ///
  /// The item will also be focussed.
  void scrollTo(int index) {
    if (!_listScrollController.isAttached) {
      _logger.info(
        'Trying to scroll before ListScrollController is attached. Ignoring.',
      );

      return;
    }

    _isFocussed = false;
    _focusIndex = index;

    _itemPositionsListener.itemPositions
        .addListener(_focusWhileScrollingPositionListener);

    // Psychology 101: The farther we scroll, the longer we take.
    int currentPosition = 0;
    try {
      currentPosition = _itemPositionsListener.itemPositions.value.first.index;
    } catch (_) {}

    final distance = (currentPosition < index)
        ? index - currentPosition
        : currentPosition - index;

    final scrollDuration = max(1000, 1000 + (distance - 10) * 100);

    // Scroll the item's top-edge into the top 30% of the screen.
    const topThirtyPercent = 0.3;

    _listScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: scrollDuration),
      curve: Curves.easeInOutCubic,
      alignment: topThirtyPercent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale ?? Localizations.localeOf(context);

    return QuestionnaireResponseFiller(
      fhirResourceProvider: widget.fhirResourceProvider,
      launchContext: widget.launchContext,
      locale: locale,
      questionnaireTheme: widget.questionnaireTheme,
      questionnaireModelDefaults: widget.questionnaireModelDefaults,
      builder: (BuildContext context) {
        _belowFillerContext = context;
        final questionnaireFiller = QuestionnaireResponseFiller.of(context);

        final totalLength = questionnaireFiller.fillerItemModels.length;

        _logger.trace(
          'Scroll position: ${_itemPositionsListener.itemPositions.value}',
        );

        return Localizations.override(
          context: context,
          locale: locale,
          child: widget.scaffoldBuilder.build(
            context,
            setStateCallback: (fn) {
              setState(fn);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                const edgeInsets = 8.0;
                const twice = 2;

                return ScrollablePositionedList.builder(
                  itemScrollController: _listScrollController,
                  itemPositionsListener: _itemPositionsListener,
                  itemCount: totalLength,
                  padding: const EdgeInsets.all(edgeInsets),
                  minCacheExtent: 200, // Allow tabbing to prev/next items
                  itemBuilder: (BuildContext context, int i) {
                    return Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth:
                                widget.questionnaireTheme.maxItemWidth.clamp(
                              constraints.minWidth,
                              constraints.maxWidth - twice * edgeInsets,
                            ),
                          ),
                          child: QuestionnaireResponseFiller.of(context)
                              .itemFillerAt(i),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
      aggregators: widget.aggregators,
      onDataAvailable: (questionnaireResponseModel) {
        if (_isPositioned) {
          return;
        }

        // Upon initial load: Locate the first unanswered or invalid question
        if (!_isLoaded) {
          _isLoaded = true;

          _questionnaireResponseModel = questionnaireResponseModel;

          if (widget.onQuestionnaireResponseChanged != null) {
            // TODO: Ideally an initial state should be broadcast, but this is leading to exceptions for UI updates/setState.
            //            _handleChangedQuestionnaireResponse();

            // FIXME: What is this listening for???
            _questionnaireResponseModel?.valueChangeNotifier
                .addListener(_handleChangedQuestionnaireResponse);
          }

          // Listen for new invalid items and then scroll to the first one.
          questionnaireResponseModel.invalidityNotifier.addListener(() {
            final invalidNodes =
                questionnaireResponseModel.invalidityNotifier.value;

            if (invalidNodes == null) {
              return;
            }

            final firstInvalidUid = invalidNodes.keys.first;
            final firstInvalidItem = questionnaireResponseModel
                .fillerItemModelByUid(firstInvalidUid);
            if (firstInvalidItem != null) {
              scrollToItem(firstInvalidItem);
            }
          });

          _focusIndex = questionnaireResponseModel.indexOfFillerItem(
            (fim) =>
                fim is QuestionItemModel && (fim.isUnanswered || fim.isInvalid),
          )!;

          if (_focusIndex == -1) {
            // When all questions are answered then focus on the first field that can be filled by a human.
            _focusIndex = questionnaireResponseModel.indexOfFillerItem(
              (fim) => !fim.questionnaireItemModel.isReadOnly,
            )!;
          }
        }

        if (_focusIndex <= 0) {
          return;
        }

        _logger.debug(
          'Focussing item# $_focusIndex - ${questionnaireResponseModel.itemFillerModelAt(_focusIndex)}',
        );

        _itemPositionsListener.itemPositions
            .addListener(_initialPositionListener);
      },
      onLinkTap: widget.onLinkTap,
    );
  }

  void _initialPositionListener() {
    // This is one-time only
    _itemPositionsListener.itemPositions
        .removeListener(_initialPositionListener);

    _logger.trace(
      'Scroll positions are: ${_itemPositionsListener.itemPositions.value}',
    );

    _isPositioned = true;

    // Item could be visible, but in an undesirable position, e.g.
    // at the bottom of the display. Make sure it is in the top third of screen.
    final isItemVisible = _itemPositionsListener.itemPositions.value.any(
      (element) =>
          element.index == _focusIndex && element.itemLeadingEdge < 0.35,
    );

    _logger.debug('Item $_focusIndex already visible: $isItemVisible');

    if (isItemVisible) {
      _requestFocus();

      return;
    }

    // After the model data is loaded, wait until the end of the current frame,
    // and then scroll to the desired location.
    //
    // Rationale: Before the data is loaded the QuestionnaireFiller is still
    // showing progress indicator and no scrolling is possible.
    // On the first frame after data is loaded the _listScrollController is not
    // properly attached yet and will throw an exception.
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      scrollTo(_focusIndex);
    });
  }

  /// Listens to item visibility until focus item is visible, then focuses it.
  void _focusWhileScrollingPositionListener() {
    _logger.trace(
      'Focussing - Scroll positions are: ${_itemPositionsListener.itemPositions.value}',
    );

    final isItemVisible = _itemPositionsListener.itemPositions.value
        .any((element) => element.index == _focusIndex);

    _logger.debug('Item $_focusIndex is visible: $isItemVisible');

    if (!isItemVisible) {
      return; // Not there yet...
    } else {
      _itemPositionsListener.itemPositions
          .removeListener(_focusWhileScrollingPositionListener);
      _requestFocus();
    }
  }

  void _requestFocus() {
    if (_belowFillerContext == null) {
      _logger.warn('Attempt to request focus before first build. Ignoring.');
    }

    if (!_isFocussed) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        QuestionnaireResponseFiller.of(_belowFillerContext!)
            .requestFocus(_focusIndex);
      });

      _isFocussed = true;
    }
  }
}
