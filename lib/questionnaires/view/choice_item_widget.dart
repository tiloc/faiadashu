import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../util/safe_access_extensions.dart';
import '../questionnaires.dart';

class ChoiceItemAnswer extends QuestionnaireAnswerFiller {
  const ChoiceItemAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _ChoiceItemState();
}

class _ChoiceItemState
    extends QuestionnaireAnswerState<String, ChoiceItemAnswer> {
  _ChoiceItemState();

  @override
  void initState() {
    super.initState();
    if (widget.location.responseItem != null) {
      initialValue = widget
          .location.responseItem!.answer!.first.valueCoding?.code
          .toString();
    }
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() => (value == null)
      ? null
      : QuestionnaireResponseAnswer(valueCoding: _buildCodingByChoice(value));

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  @override
  Widget buildEditable(BuildContext context) {
    return _buildChoiceAnswers(context);
  }

  Coding? _buildCodingByChoice(String? choice) {
    if (choice == null) {
      return null;
    }

    final element = widget.location.questionnaireItem;
    final questionnaire = widget.location.questionnaire;

    if (element.answerValueSet != null) {
      final key = element.answerValueSet!.value!
          .toString()
          .substring(1); // Strip off leading '#'

      final ValueSetInclude? valueSetInclude = (questionnaire.contained
                  ?.firstWhereOrNull((element) => key == element.id?.toString())
              as ValueSet?)
          ?.compose
          ?.include
          .firstOrNull;

      final List<ValueSetConcept>? valueSetConcepts = valueSetInclude?.concept;

      if (valueSetConcepts == null) {
        throw DataFormatException(
            'Questionnaire does not contain referenced ValueSet $key',
            questionnaire);
      }

      for (final concept in valueSetConcepts) {
        if (concept.code!.value == choice) {
          List<FhirExtension>? responseOrdinalExtension;

          final FhirExtension? ordinalExtension = concept.extension_
              ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/ordinalValue');
          if (ordinalExtension != null) {
            responseOrdinalExtension = <FhirExtension>[
              FhirExtension(
                  url: FhirUri(
                      'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value'),
                  valueDecimal: ordinalExtension.valueDecimal),
            ];
          }
          final coding = Coding(
              system: valueSetInclude!.system,
              code: concept.code,
              userSelected: Boolean(true),
              display: concept.display,
              extension_: responseOrdinalExtension);

          return coding;
        }
      }
      throw ArgumentError('ValueSet $key does not contain entry $choice');
    } else {
      for (final option in element.answerOption!) {
        if (option.valueCoding!.code.toString() == choice) {
          final ordinalExtension = option.extension_?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/ordinalValue');
          final responseOrdinalExtension = (ordinalExtension != null)
              ? <FhirExtension>[
                  FhirExtension(
                      url: FhirUri(
                          'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value'),
                      valueDecimal: ordinalExtension.valueDecimal),
                ]
              : null;
          return option.valueCoding!.copyWith(
              userSelected: Boolean(true),
              extension_: responseOrdinalExtension);
        }
      }
      throw ArgumentError('Answer Option does not contain entry $choice');
    }
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final element = widget.location.questionnaireItem;
    final questionnaire = widget.location.questionnaire;

    final choices = <RadioListTile>[];
    choices.add(RadioListTile<String?>(
        title: Text(
          '---',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        value: null,
        groupValue: value,
        onChanged: (String? newValue) {
          value = newValue;
        }));

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
            groupValue: value,
            onChanged: (String? newValue) {
              value = newValue;
            }));
      }
    } else {
      if (element.answerOption != null) {
        for (final choice in element.answerOption!) {
          choices.add(RadioListTile<String>(
              title: Text(choice.safeDisplay,
                  style: Theme.of(context).textTheme.bodyText2),
              value: choice.valueCoding!.code.toString(),
              groupValue: value,
              onChanged: (String? newValue) {
                value = newValue;
              }));
        }
      }
    }

    return Column(
      children: choices,
    );
  }
}
