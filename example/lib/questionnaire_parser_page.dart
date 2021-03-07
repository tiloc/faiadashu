import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'exhibit_page.dart';
import 'phq9_instrument.dart';

class QuestionnaireParserPage extends ExhibitPage {
  static const QuestionnaireItemDecorator _decorator = _ItemDecorator();
  const QuestionnaireParserPage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    final locations = QuestionnaireLocation(Questionnaire.fromJson(
            json.decode(Phq9Instrument.phq9Instrument) as Map<String, dynamic>))
        .preOrder();

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: QuestionnaireItemWidgetFactory.fromQuestionnaireItem(
                locations[index], _decorator),
          );
        });
  }

  @override
  String get title => 'Questionnaire Parser';
}

@immutable
class _ItemDecorator extends QuestionnaireItemDecorator {
  const _ItemDecorator();

  @override
  Widget build(BuildContext context, QuestionnaireLocation location,
      {required Widget body}) {
    return ListTile(
      title: Text(location.questionnaireItem.text!,
          style: (location.level == 0)
              ? Theme.of(context).textTheme.headline4
              : Theme.of(context).textTheme.subtitle1),
      subtitle: body,
    );
  }
}
