import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/view/xhtml.dart';

import '../../util/safe_access_extensions.dart';
import '../questionnaires.dart';

class ChoiceAnswer extends QuestionnaireAnswerFiller {
  // This class abuses CodeableConcept to model multiple choice and open choice.

  const ChoiceAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _ChoiceAnswerState();
}

class _ChoiceAnswerState
    extends QuestionnaireAnswerState<CodeableConcept, ChoiceAnswer> {
  _ChoiceAnswerState();

  @override
  void initState() {
    super.initState();
    if (widget.location.responseItem != null) {
      initialValue = _fillValue(
          widget.answerLocation.answer?.valueCoding?.code.toString());
    }
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    throw UnsupportedError('Choice Answer will always return choice answers.');
  }

  @override
  List<QuestionnaireResponseAnswer>? fillChoiceAnswers() {
    if (value == null) {
      return null;
    }

    // TODO(tiloc): Should the order of the codings be in the order of the choices?
    // TODO(tiloc): Support open free text (should always come last?)
    return value!.coding
        ?.map<QuestionnaireResponseAnswer>((coding) =>
            QuestionnaireResponseAnswer(
                valueCoding: _fillCodingByChoice(coding.code!.value)))
        .toList();
  }

  @override
  bool hasChoiceAnswers() {
    return true;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(value?.toString() ?? '');
  }

  @override
  Widget buildEditable(BuildContext context) {
    return _buildChoiceAnswers(context);
  }

  CodeableConcept? _fillValue(String? newValue) {
    return (newValue != null)
        ? CodeableConcept(coding: [Coding(code: Code(newValue))])
        : null;
  }

  /// Turn on/off the checkbox with the provided [toggleValue].
  /// Used in repeating items.
  CodeableConcept? _fillToggledValue(String? toggleValue) {
    if (toggleValue == null) {
      return null;
    }
    if ((value == null) || (value!.coding == null)) {
      return CodeableConcept(coding: [Coding(code: Code(toggleValue))]);
    }

    final entryIndex = value!.coding!
        .indexWhere((coding) => coding.code?.value == toggleValue);
    if (entryIndex == -1) {
      return CodeableConcept(
          coding: [...value!.coding!, Coding(code: Code(toggleValue))]);
    } else {
      return CodeableConcept(coding: value!.coding!..removeAt(entryIndex));
    }
  }

  Coding? _fillCodingByChoice(String? choice) {
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
        throw QuestionnaireFormatException(
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
          // As per the spec there should always be a valueCoding, but SDC examples use valueString
          return (option.valueCoding != null)
              ? option.valueCoding!.copyWith(
                  userSelected: Boolean(true),
                  extension_: responseOrdinalExtension)
              : Coding(display: option.valueString);
        }
      }
      throw ArgumentError('Answer Option does not contain entry $choice');
    }
  }

  Widget? _styledChoice(BuildContext context, QuestionnaireAnswerOption qao) {
    return Xhtml.buildFromExtension(
        context, qao.valueStringElement?.extension_);
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final qi = widget.location.questionnaireItem;
    final questionnaire = widget.location.questionnaire;

    final choices = <Widget>[];
    if ((qi.repeats?.value ?? false) == false) {
      choices.add(RadioListTile<String?>(
          title: Text(
            '---',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          value: null,
          groupValue: value?.firstCode,
          onChanged: (String? newValue) {
            value = _fillValue(newValue);
          }));
    }
    if (qi.answerValueSet != null) {
      final key = qi.answerValueSet?.value?.toString();
      final List<ValueSetConcept>? valueSetConcepts =
          (widget.location.top.findContainedByElementId(key) as ValueSet?)
              ?.compose
              ?.include
              .firstOrNull
              ?.concept;

      if (valueSetConcepts == null) {
        throw QuestionnaireFormatException(
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
            groupValue: value?.firstCode,
            onChanged: (String? newValue) {
              value = _fillValue(newValue);
            }));
      }
    } else {
      if (qi.answerOption != null) {
        for (final choice in qi.answerOption!) {
          final optionPrefix = choice.extension_
              ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix')
              ?.valueString;
          final optionPrefixDisplay =
              (optionPrefix != null) ? '$optionPrefix ' : '';
          final optionTitle = '$optionPrefixDisplay${choice.safeDisplay}';

          choices.add((qi.repeats?.value == true)
              ? CheckboxListTile(
                  title: Text(optionTitle,
                      style: Theme.of(context).textTheme.bodyText2),
                  value: value?.coding?.firstWhereOrNull((coding) =>
                          coding.code?.value == choice.optionCode) !=
                      null,
                  onChanged: (bool? newValue) {
                    value = _fillToggledValue(choice.optionCode);
                  })
              : RadioListTile<String>(
                  title: Text(optionTitle,
                      style: Theme.of(context).textTheme.bodyText2),
                  secondary: _styledChoice(context, choice),
                  value: choice.optionCode,
                  groupValue: value?.firstCode,
                  onChanged: (String? newValue) {
                    value = _fillValue(newValue);
                  }));
        }
      }
    }

    return Column(
      children: choices,
    );
  }
}
