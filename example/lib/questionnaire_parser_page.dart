import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaire_location.dart';

import 'exhibit_page.dart';
import 'phq9_instrument.dart';

class QuestionnaireParserPage extends ExhibitPage {
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
          return SizedBox(
            height: 30,
            child: Center(child: Text('Location ${locations[index]}')),
          );
        });
  }

  @override
  String get title => 'Questionnaire Parser';
}
