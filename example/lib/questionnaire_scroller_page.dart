import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

class QuestionnaireScrollerPage extends StatefulWidget {
  final QuestionnaireTopLocation top;
  // TODO(tiloc): Move JSON parsing into background thread and make widget state dependent on its completion
  QuestionnaireScrollerPage(String instrument, {Key? key})
      : top = QuestionnaireTopLocation.fromQuestionnaire(Questionnaire.fromJson(
            json.decode(instrument) as Map<String, dynamic>)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionnaireScrollerState();
}

class _QuestionnaireScrollerState extends State<QuestionnaireScrollerPage> {
  final ScrollController _listScrollController = ScrollController();
  final ScrollController _narrativeScrollController = ScrollController();

  // false = narrative, true = JSON
  bool _drawerMode = false;

  @override
  Widget build(BuildContext context) {
    return QuestionnaireFiller(widget.top,
        aggregators: [
          TotalScoreAggregator(),
          NarrativeAggregator(),
          QuestionnaireResponseAggregator()
        ],
        child: Builder(
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
                  endDrawer: Card(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.7),
                      child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _narrativeScrollController,
                        child: SingleChildScrollView(
                          controller: _narrativeScrollController,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Builder(
                              builder: (context) => SwitchListTile(
                                title: Text(
                                  !_drawerMode
                                      ? 'Narrative'
                                      : 'FHIR R4 QuestionnaireResponse JSON',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                subtitle: !_drawerMode
                                    ? HTML.toRichText(
                                        context,
                                        QuestionnaireFiller.of(context)
                                            .aggregator<NarrativeAggregator>()
                                            .value
                                            .div)
                                    : Text(jsonEncode(QuestionnaireFiller.of(
                                            context)
                                        .aggregator<
                                            QuestionnaireResponseAggregator>()
                                        .aggregate()
                                        ?.toJson())),
                                value: _drawerMode,
                                onChanged: (newState) {
                                  setState(() {
                                    _drawerMode = newState;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    label: const Text('Complete'),
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () {},
                  ),
                  body: Scrollbar(
                    isAlwaysShown: true,
                    controller: _listScrollController,
                    child: ListView.builder(
                        controller: _listScrollController,
                        itemCount: QuestionnaireFiller.of(context)
                            .surveyLocations
                            .length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (BuildContext context, int i) {
                          return QuestionnaireFiller.of(context)
                              .itemFillerAt(i);
                        }),
                  ),
                )));
  }
}
