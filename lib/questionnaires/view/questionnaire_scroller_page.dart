import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../questionnaires.dart';
import 'narrative_drawer.dart';

/// Fill a questionnaire through a vertically scrolling input form.
class QuestionnaireScrollerPage extends StatefulWidget {
  final String loaderParam;

  const QuestionnaireScrollerPage.fromAsset(this.loaderParam, {Key? key})
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
    return QuestionnaireFiller.fromAsset(widget.loaderParam,
        child: Builder(
            // TODO: Can this Builder be hidden inside the QuestionnaireFiller for extra ease of use? First attempt failed.
            builder: (BuildContext context) => Scaffold(
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
                  title: Text(QuestionnaireFiller.of(context)
                          .topLocation
                          .questionnaire
                          .title ??
                      'Survey'),
                ),
                endDrawer: const NarrativeDrawer(),
                floatingActionButton: FloatingActionButton.extended(
                  label: const Text('Complete'),
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {},
                ),
                body: RawKeyboardListener(
                  autofocus: true,
                  focusNode: _focusNode,
                  onKey: _handleKeyEvent,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _listScrollController,
                    child: ListView.builder(
                        controller: _listScrollController,
                        itemCount: QuestionnaireFiller.of(context)
                                .surveyLocations
                                .length +
                            1,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int i) {
                          if (i <
                              QuestionnaireFiller.of(context)
                                  .surveyLocations
                                  .length) {
                            return QuestionnaireFiller.of(context)
                                .itemFillerAt(i);
                          } else {
                            // TODO: Allow adding a different final element
                            // Give some extra scrolling-space at the bottom.
                            // Otherwise Complete button overlaps final element.
                            return const SizedBox(
                              height: 80,
                            );
                          }
                        }),
                  ),
                ))));
  }
}
