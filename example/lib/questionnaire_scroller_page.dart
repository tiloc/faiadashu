import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'exhibit_page.dart';

class QuestionnaireScrollerPage extends ExhibitPage {
  late final QuestionnaireLocation top;
  late final Iterable<QuestionnaireLocation> locations;

  static const QuestionnaireItemDecorator _decorator =
      DefaultQuestionnaireItemDecorator();
  QuestionnaireScrollerPage(String instrument, {Key? key}) : super(key: key) {
    top = QuestionnaireLocation(Questionnaire.fromJson(
        json.decode(instrument) as Map<String, dynamic>));

    locations = top.preOrder();
  }

  @override
  Widget buildExhibit(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: QuestionnaireItemWidgetFactory.fromQuestionnaireItem(
                locations.elementAt(index), _decorator),
          );
        });
  }

  @override
  String get title => 'Questionnaire Scroller';
}
