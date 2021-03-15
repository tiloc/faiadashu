import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

class QuestionnaireScrollerPage extends StatelessWidget {
  final QuestionnaireTopLocation top;
  final ScrollController _listScrollController = ScrollController();
  final ScrollController _narrativeScrollController = ScrollController();
  QuestionnaireScrollerPage(String instrument, {Key? key})
      : top = QuestionnaireTopLocation.fromQuestionnaire(Questionnaire.fromJson(
            json.decode(instrument) as Map<String, dynamic>)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionnaireFiller(top,
        aggregators: [TotalScoreAggregator(), NarrativeAggregator()],
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
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.7),
                          child: Scrollbar(
                              isAlwaysShown: true,
                              controller: _narrativeScrollController,
                              child: SingleChildScrollView(
                                controller: _narrativeScrollController,
                                child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Builder(
                                        builder: (context) => HTML.toRichText(
                                            context,
                                            '<h2>Narrative</h2><p>${QuestionnaireFiller.of(context).aggregator<NarrativeAggregator>().value.div}</p>'))),
                              )))),
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
