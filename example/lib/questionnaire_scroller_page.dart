import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'exhibit_page.dart';

class QuestionnaireScrollerPage extends ExhibitPage {
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
  Widget buildExhibit(BuildContext context) {
    final double itemHeight =
        MediaQuery.of(context).size.height - kToolbarHeight;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return QuestionnaireFiller(top,
        child: Builder(
            builder: (BuildContext context) => GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: itemWidth / itemHeight,
                    children: [
                      ListView.builder(
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
                      Card(
                        color: Colors.white,
                        child: HTML.toRichText(context,
                            '<h2>Narrative</h2><p>${nAgg.value.div}</p>'),
                      )
                    ])));
  }

  @override
  String get title => 'Questionnaire Scroller';
}
