import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import '../../util/safe_access_extensions.dart';
import 'questionnaire_item_widget.dart';

class ChoiceItemWidget extends QuestionnaireItemWidget {
  const ChoiceItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _ChoiceItemState();
}

class _ChoiceItemState
    extends QuestionnaireItemState<String, ChoiceItemWidget> {
  _ChoiceItemState() : super(null);

  @override
  void initState() {
    super.initState();
    if (widget.location.responseItem != null) {
      value = widget.location.responseItem!.answer!.first.valueCoding?.code
          .toString();
    }
  }

  @override
  QuestionnaireResponseItem createResponse() {
    return QuestionnaireResponseItem(
        linkId: widget.location.linkId,
        text: widget.location.questionnaireItem.text,
        answer: [
          QuestionnaireResponseAnswer(valueCoding: _buildCodingByChoice(value))
        ]);
  }

  @override
  Widget buildBodyReadOnly(BuildContext context) {
    return Text(value ?? '');
  }

  @override
  Widget buildBodyEditable(BuildContext context) {
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
