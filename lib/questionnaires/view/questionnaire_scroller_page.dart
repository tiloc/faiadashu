import 'dart:math';

import 'package:fhir/r4.dart' show Questionnaire;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resource_provider/resource_provider.dart';
import '../questionnaires.dart';
import 'narrative_drawer.dart';
import 'questionnaire_cover_page.dart';

/// Fill a questionnaire through a vertically scrolling input form.
class QuestionnaireScrollerPage extends StatefulWidget {
  final ExternalResourceProvider questionnaireProvider;
  final Widget? floatingActionButton;
  final List<Widget>? frontMatter;
  final List<Widget>? backMatter;
  final ExternalResourceProvider? questionnaireResponseProvider;
  final ExternalResourceProvider? resourceProvider;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;

  const QuestionnaireScrollerPage(this.questionnaireProvider,
      {this.questionnaireResponseProvider,
      this.resourceProvider,
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
  final ScrollController _listScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  _QuestionnaireScrollerState() : super();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    final offset = _listScrollController.offset;
    // TODO: Allegedly there is a way to get at the scroll offset for paging and lines.
    const pageHeight = 200;
    if (event.logicalKey == LogicalKeyboardKey.pageUp) {
      setState(() {
        _listScrollController.animateTo(max(offset - pageHeight, 0),
            duration: const Duration(milliseconds: 30), curve: Curves.ease);
      });
    } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
      setState(() {
        _listScrollController.animateTo(
            min(offset + pageHeight,
                _listScrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 30),
            curve: Curves.ease);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireFiller(
      widget.questionnaireProvider,
      questionnaireResponseProvider: widget.questionnaireResponseProvider,
      builder: (BuildContext context) {
        final mainMatterLength =
            QuestionnaireFiller.of(context).surveyLocations.length;
        final frontMatterLength = widget.frontMatter?.length ?? 0;
        final backMatterLength = widget.backMatter?.length ?? 0;
        final totalLength =
            frontMatterLength + mainMatterLength + backMatterLength;

        final questionnaire =
            QuestionnaireFiller.of(context).topLocation.questionnaire;

        return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
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
                    _showQuestionnaireInfo(context, questionnaire);
                  },
                ),
              ]),
            ),
            endDrawer: const NarrativeDrawer(),
            floatingActionButton: widget.floatingActionButton,
            body: SafeArea(
                child: RawKeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKey: _handleKeyEvent,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _listScrollController,
                child: ListView.builder(
                    controller: _listScrollController,
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
            )));
      },
      externalResourceProvider: widget.resourceProvider,
      aggregators: widget.aggregators,
      onLinkTap: widget.onLinkTap,
    );
  }

  Future<void> _showQuestionnaireInfo(
      BuildContext context, Questionnaire questionnaire) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Info'),
            content: QuestionnaireCoverPage(questionnaire),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Dismiss'),
              ),
            ],
          );
        });
  }
}
