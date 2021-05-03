import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../logging/logging.dart';
import '../../resource_provider/resource_provider.dart';
import '../questionnaires.dart';

/// Fills a [Questionnaire] through a vertically scrolling input form.
///
/// Takes the [QuestionnaireItemFiller]s as provided by the [QuestionnaireFiller]
/// and presents them as a scrolling [ListView].
///
/// A set of mandatory and optional FHIR resources need to be provided through
/// the [fhirResourceProvider]:
/// * (mandatory) [questionnaireResourceUri] - the [Questionnaire]
/// * (mandatory) [subjectResourceUri] - the [Patient]
/// * (optional) [questionnaireResponseResourceUri] - the [QuestionnaireResponse].
/// Will be used to prefill the filler, if present.
class QuestionnaireScrollerPage extends StatefulWidget {
  final Locale? locale;
  final Widget? floatingActionButton;
  final List<Widget>? frontMatter;
  final List<Widget>? backMatter;
  final FhirResourceProvider fhirResourceProvider;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;

  const QuestionnaireScrollerPage(
      {this.locale,
      required this.fhirResourceProvider,
      this.floatingActionButton,
      this.frontMatter,
      this.backMatter = const [
        SizedBox(
          height: 80,
        )
      ],
      this.aggregators,
      this.onLinkTap,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionnaireScrollerState();
}

class _QuestionnaireScrollerState extends State<QuestionnaireScrollerPage> {
  final ItemScrollController _listScrollController = ItemScrollController();
  final FocusNode _focusNode = FocusNode();

  static final _logger = Logger(_QuestionnaireScrollerState);

  _QuestionnaireScrollerState() : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale ?? Localizations.localeOf(context);

    return QuestionnaireFiller(
      fhirResourceProvider: widget.fhirResourceProvider,
      locale: locale,
      builder: (BuildContext context) {
        final questionnaireFiller = QuestionnaireFiller.of(context);

        final mainMatterLength =
            questionnaireFiller.questionnaireItemModels.length;
        final frontMatterLength = widget.frontMatter?.length ?? 0;
        final backMatterLength = widget.backMatter?.length ?? 0;
        final totalLength =
            frontMatterLength + mainMatterLength + backMatterLength;

        final questionnaire =
            questionnaireFiller.questionnaireModel.questionnaire;

        return Localizations.override(
            context: context,
            locale: locale,
            child: Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                title: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    child: Text(
                      questionnaire.title ?? 'Survey',
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.help_outline),
                    onPressed: () {
                      QuestionnaireInformationDialog.showQuestionnaireInfo(
                          context, locale, questionnaire, (context) {
                        setState(() {
                          Navigator.pop(context);
                        });
                      });
                    },
                  ),
                ]),
              ),
              endDrawer: const NarrativeDrawer(),
              floatingActionButton: widget.floatingActionButton,
              body: SafeArea(
                child: ScrollablePositionedList.builder(
                    itemScrollController: _listScrollController,
                    itemCount: totalLength,
                    padding: const EdgeInsets.all(8),
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
                        return QuestionnaireFiller.of(context).itemFillerAt(i);
                      } else if (backMatterIndex != -1) {
                        return widget.backMatter![backMatterIndex];
                      } else if (frontMatterIndex != -1) {
                        return widget.frontMatter![frontMatterIndex];
                      } else {
                        throw StateError('ListView index out of bounds: $i');
                      }
                    }),
              ),
            ));
      },
      aggregators: widget.aggregators,
      onDataAvailable: (questionnaireModel) {
        // TODO: This is not working as expected yet.
        // Locate the first unfilled, answerable item
        final index = questionnaireModel.indexOf(
            (qim) => !qim.isReadOnly && qim.responseItem == null, 0)!;

        _logger.debug('First unfilled response: $index');

        if (index == 0) {
          return;
        }

        // After the model data is loaded, wait until the end of the current frame,
        // and then scroll to the desired location.
        //
        // Rationale: Before the data is loaded the QuestionnaireFiller is still
        // showing progress indicator and no scrolling is possible.
        // During the frame when data is loaded the _listScrollController is not
        // properly attached yet and will throw an exception.
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          final milliseconds = (index < 10) ? 1000 : 1000 + (index - 10) * 100;
          _listScrollController.scrollTo(
              index: index,
              duration: Duration(milliseconds: milliseconds),
              curve: Curves.easeInOutCubic);
        });
      },
      onLinkTap: widget.onLinkTap,
    );
  }
}
