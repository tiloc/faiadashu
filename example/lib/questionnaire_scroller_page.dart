import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'exhibit_page.dart';

class QuestionnaireScrollerPage extends ExhibitPage {
  late final QuestionnaireLocation top;
  late final Iterable<QuestionnaireLocation> locations;
  late final NarrativeNotifier _narrativeNotifier;
  late final List<Widget> _children;

  static const QuestionnaireItemDecorator _decorator =
      DefaultQuestionnaireItemDecorator();
  QuestionnaireScrollerPage(String instrument, {Key? key}) : super(key: key) {
    top = QuestionnaireLocation(Questionnaire.fromJson(
        json.decode(instrument) as Map<String, dynamic>));

    locations = top.preOrder();

    _narrativeNotifier = NarrativeNotifier(top);

    _children = locations
        .map<Widget>((location) => Center(
            child: QuestionnaireItemWidgetFactory.fromQuestionnaireItem(
                location, _decorator)))
        .toList();
  }

  @override
  Widget buildExhibit(BuildContext context) {
    final double itemHeight =
        MediaQuery.of(context).size.height - kToolbarHeight;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / itemHeight,
        children: [
          ListView(padding: const EdgeInsets.all(8), children: _children),
          ValueListenableBuilder<Narrative>(
            builder: (BuildContext context, Narrative value, Widget? child) {
              print('Narrative: ${value.div}');
              return Card(
                color: Colors.white,
                child: HTML.toRichText(
                    context, '<h2>Narrative</h2><p>${value.div}</p>'),
              );
            },
            valueListenable: _narrativeNotifier,
          ),
        ]);
  }

  @override
  String get title => 'Questionnaire Scroller';
}
