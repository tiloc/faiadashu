import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

class QuestionnaireScrollerPage extends StatelessWidget {
  final QuestionnaireLocation top;
  late final NarrativeAggregator nAgg;
  static const QuestionnaireItemDecorator _decorator =
      DefaultQuestionnaireItemDecorator();
  QuestionnaireScrollerPage(String instrument, {Key? key})
      : top = QuestionnaireLocation(Questionnaire.fromJson(
            json.decode(instrument) as Map<String, dynamic>)),
        super(key: key) {
    // TODO(tiloc): Would there be any benefit in registering the aggregators with the top location?
    // TODO(tiloc): This entire sequence looks clunky.
    TotalScoreAggregator(top);
    nAgg = NarrativeAggregator(top);
    top.aggregate();
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireFiller(top,
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
                    color: Colors.white,
                    child: HTML.toRichText(
                        context, '<h2>Narrative</h2><p>${nAgg.value.div}</p>'),
                  ),
                  body: ListView.builder(
                      itemCount:
                          QuestionnaireFiller.of(context).preOrder.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (BuildContext context, int i) {
                        return QuestionnaireItemWidgetFactory
                            .fromQuestionnaireItem(
                                QuestionnaireFiller.of(context)
                                    .preOrder
                                    .elementAt(i),
                                _decorator);
                      }),
                )));
  }
}
