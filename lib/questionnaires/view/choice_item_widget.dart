import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../util/safe_access_extensions.dart';
import '../questionnaires.dart';

// TODO(tiloc): How to properly model "repeats" here? Technically this is a single control with numerous answers + open-choice texts
// Maybe have a dedicated ResponseFiller for this? or pimp up AnswerLocation to support multiple answers?
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
      initialValue = widget.answerLocation.answer?.valueCoding?.code.toString();
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

  // TODO(tiloc): Return the entire QuestionnaireResponseAnswer
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
        if (option.optionCode == choice) {
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
          // TODO(tiloc) this could also be a valueString. Bang-op is wrong!
          return option.valueCoding!.copyWith(
              userSelected: Boolean(true),
              extension_: responseOrdinalExtension);
        }
      }
      throw ArgumentError('Answer Option does not contain entry $choice');
    }
  }

  Widget? _styledChoice(BuildContext context, QuestionnaireAnswerOption qao) {
    final xhtml = qao.valueStringElement?.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/rendering-xhtml')
        ?.valueString;
    if (xhtml == null) {
      return null;
    }
    const imgBase64Prefix = "<img src='data:image/png;base64,";
    if (xhtml.startsWith(imgBase64Prefix)) {
      final base64String =
          xhtml.substring(imgBase64Prefix.length, xhtml.length - "'/>".length);
      return Image.memory(base64.decode(base64String));
    } else {
      return HTML.toRichText(context, xhtml);
    }
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final element = widget.location.questionnaireItem;
    final questionnaire = widget.location.questionnaire;

    final choices = <Widget>[];
    if (element.repeats?.value == false) {
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
    }
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
          final optionPrefix = choice.extension_
              ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix')
              ?.valueString;
          final optionPrefixDisplay =
              (optionPrefix != null) ? '$optionPrefix ' : '';
          final optionTitle = '$optionPrefixDisplay${choice.safeDisplay}';

          choices.add((element.repeats?.value == true)
              ? CheckboxListTile(
                  title: Text(optionTitle,
                      style: Theme.of(context).textTheme.bodyText2),
                  value: true, // TODO(tiloc): Much work to do here...
                  onChanged: (bool? newValue) {})
              : RadioListTile<String>(
                  title: Text(optionTitle,
                      style: Theme.of(context).textTheme.bodyText2),
                  secondary: _styledChoice(context, choice),
                  value: choice.optionCode,
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
