import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../logging/logging.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

// TODO: Some calculations regarding focus + front matter maybe currently off.

/// Fills a [Questionnaire] through a vertically scrolling input form.
///
/// Takes the [QuestionnaireItemFiller]s as provided by the [QuestionnaireFiller]
/// and presents them as a scrolling [ListView].
///
/// The [scaffoldBuilder] is used to build a wrapper around the list.
///
/// A set of mandatory and optional FHIR resources need to be provided through
/// the [fhirResourceProvider]:
/// * (mandatory) [questionnaireResourceUri] - the [Questionnaire]
/// * (mandatory) [subjectResourceUri] - the [Patient]
/// * (optional) [questionnaireResponseResourceUri] - the [QuestionnaireResponse].
/// Will be used to prefill the filler, if present.
///
/// See: [QuestionnaireScrollerPage] for a [QuestionnaireScroller] which already
/// wraps the list in a ready-made [Scaffold], incl. some commonly used buttons.
class QuestionnaireScroller extends StatefulWidget {
  final Locale? locale;
  final List<Widget>? frontMatter;
  final List<Widget>? backMatter;
  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final QuestionnairePageScaffoldBuilder scaffoldBuilder;
  final QuestionnaireTheme questionnaireTheme;

  const QuestionnaireScroller({
    this.locale,
    required this.scaffoldBuilder,
    required this.fhirResourceProvider,
    required this.launchContext,
    this.frontMatter,
    this.backMatter,
    this.aggregators,
    this.onLinkTap,
    this.questionnaireTheme = const QuestionnaireTheme(),
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionnaireScrollerState();
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

  /// Scrolls to a position as conveyed by a [QuestionnaireErrorFlag].
  ///
  /// The item will also be focussed.
  void scrollToErrorFlag(QuestionnaireErrorFlag errorFlag) {
    if (_questionnaireResponseModel == null) {
      _logger.info(
        'Trying to scroll before QuestionnaireModel is loaded. Ignoring.',
      );
      return;
    }

    final index = _questionnaireResponseModel!
        .indexOfFillerItem((fim) => fim.responseUid == errorFlag.responseUid);

    if (index == -1) {
      _logger.warn(
        'Error Flag with invalid responseUId: ${errorFlag.responseUid}',
      );
      return;
    }

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

    final milliseconds = (distance < 10) ? 1000 : 1000 + (distance - 10) * 100;

    _listScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeInOutCubic,
      alignment: 0.3,
    ); // Scroll the item's top-edge into the top 30% of the screen.
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale ?? Localizations.localeOf(context);

    return QuestionnaireFiller(
      fhirResourceProvider: widget.fhirResourceProvider,
      launchContext: widget.launchContext,
      locale: locale,
      questionnaireTheme: widget.questionnaireTheme,
      builder: (BuildContext context) {
        _belowFillerContext = context;
        final questionnaireFiller = QuestionnaireFiller.of(context);

        final mainMatterLength = questionnaireFiller.fillerItemModels.length;
        final frontMatterLength = widget.frontMatter?.length ?? 0;
        final backMatterLength = widget.backMatter?.length ?? 0;
        final totalLength =
            frontMatterLength + mainMatterLength + backMatterLength;

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
            child: ScrollablePositionedList.builder(
              itemScrollController: _listScrollController,
              itemPositionsListener: _itemPositionsListener,
              itemCount: totalLength,
              padding: const EdgeInsets.all(8),
              minCacheExtent: 200, // Allow tabbing to prev/next items
              itemBuilder: (BuildContext context, int i) {
                final frontMatterIndex = (i < frontMatterLength) ? i : -1;
                final mainMatterIndex = (i >= frontMatterLength &&
                        i < (frontMatterLength + mainMatterLength))
                    ? (i - frontMatterLength)
                    : -1;
                final backMatterIndex =
                    (i >= (frontMatterLength + mainMatterLength) &&
                            i < totalLength)
                        ? (i - (frontMatterLength + mainMatterLength))
                        : -1;
                if (mainMatterIndex != -1) {
                  return QuestionnaireFiller.of(context)
                      .itemFillerAt(mainMatterIndex);
                } else if (backMatterIndex != -1) {
                  return widget.backMatter![backMatterIndex];
                } else if (frontMatterIndex != -1) {
                  return widget.frontMatter![frontMatterIndex];
                } else {
                  throw StateError('ListView index out of bounds: $i');
                }
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

          // Listen for new error flags and then scroll to the first one.
          questionnaireResponseModel.errorFlags.addListener(() {
            final markers = questionnaireResponseModel.errorFlags.value;
            if (markers != null) {
              scrollToErrorFlag(markers.first);
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
        QuestionnaireFiller.of(_belowFillerContext!).requestFocus(_focusIndex);
      });

      _isFocussed = true;
    }
  }
}

/// A [QuestionnaireScroller] with a scaffold.
///
/// Fills up the entire page, provides default navigation, help button.
class QuestionnaireScrollerPage extends QuestionnaireScroller {
  QuestionnaireScrollerPage({
    Locale? locale,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
    Widget? floatingActionButton,
    List<Widget>? persistentFooterButtons,
    List<Widget>? frontMatter,
    List<Widget>? backMatter = const [
      SizedBox(
        height: 80,
      )
    ],
    List<Aggregator<dynamic>>? aggregators,
    void Function(BuildContext context, Uri url)? onLinkTap,
    QuestionnaireTheme questionnaireTheme = const QuestionnaireTheme(),
    Key? key,
  }) : super(
          locale: locale,
          scaffoldBuilder: DefaultQuestionnairePageScaffoldBuilder(
            // Progress can only be shown instead of a FAB
            floatingActionButton: floatingActionButton ??
                (questionnaireTheme.showProgress
                    ? Builder(
                        builder: (context) =>
                            const QuestionnaireFillerCircularProgress(),
                      )
                    : null),
            persistentFooterButtons: persistentFooterButtons,
          ),
          fhirResourceProvider: fhirResourceProvider,
          launchContext: launchContext,
          frontMatter: frontMatter,
          backMatter: backMatter,
          aggregators: aggregators,
          onLinkTap: onLinkTap,
          questionnaireTheme: questionnaireTheme,
          key: key,
        );
}
