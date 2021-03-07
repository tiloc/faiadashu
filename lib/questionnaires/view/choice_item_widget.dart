import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'questionnaire_item_widget.dart';

class ChoiceItemWidget extends QuestionnaireItemWidget {
  const ChoiceItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _ChoiceItemState();
}

class _ChoiceItemState extends QuestionnaireItemState {
  String? _choiceSelection;

  _ChoiceItemState();

  @override
  Widget buildBody(BuildContext context) {
    return _buildChoiceAnswers(widget.location, context);
  }

  Widget _buildChoiceAnswers(
      QuestionnaireLocation location, BuildContext context) {
    final element = location.questionnaireItem;
    final questionnaire = location.questionnaire;

    final choices = <RadioListTile>[];
    if (element.answerValueSet != null) {
      final key = element.answerValueSet!.value!
          .toString()
          .substring(1); // Strip off leading '#'
      final List<ValueSetConcept>? valueSetConcepts = (questionnaire.contained
                  ?.firstWhereOrNull((element) => key == element.id?.toString())
              as ValueSet?)
          ?.compose
          ?.include
          .firstOrNull
          ?.concept;

      if (valueSetConcepts == null) {
        throw DataFormatException(
            'Questionnaire does not contain referenced ValueSet $key',
            questionnaire);
      }

      for (final concept in valueSetConcepts) {
        choices.add(RadioListTile<String>(
            title: Text(
              concept.display!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            value: concept.code!.toString(),
            groupValue: _choiceSelection,
            onChanged: (String? value) {
              setState(() {
                _choiceSelection = value;
              });
            }));
      }
    } else {
      if (element.answerOption != null) {
        for (final choice in element.answerOption!) {
          choices.add(RadioListTile<String>(
              title: Text(choice.safeDisplay,
                  style: Theme.of(context).textTheme.bodyText2),
              value: choice.valueCoding!.code.toString(),
              groupValue: _choiceSelection,
              onChanged: (String? value) {
                setState(() {
                  _choiceSelection = value;
                });
              }));
        }
      }
    }

    return Column(
      children: choices,
    );
  }
}
