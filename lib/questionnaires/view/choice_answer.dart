import 'dart:collection';
import 'dart:developer' as developer;

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/valueset/fhir_valueset.dart';
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
  // ignore: prefer_collection_literals
  final _answerOptions = LinkedHashMap<String, QuestionnaireAnswerOption>();

  _ChoiceAnswerState();

  @override
  void initState() {
    super.initState();

    _buildAnswerOptions();

    if (widget.location.responseItem != null) {
      // TODO: Use _answerOptions
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

    return _answerOptions[choice]!.valueCoding;
  }

  Widget? _styledChoice(BuildContext context, QuestionnaireAnswerOption qao) {
    return Xhtml.buildFromExtension(
        context, qao.valueStringElement?.extension_);
  }

  // Take the existing extensions that might contain information about
  // ordinal values and convert them from ordinalValue to iso21090-CO-value
  List<FhirExtension>? _buildOrdinalExtension(
      List<FhirExtension>? inExtension) {
    List<FhirExtension>? responseOrdinalExtension;

    final FhirExtension? ordinalExtension = inExtension?.extensionOrNull(
        'http://hl7.org/fhir/StructureDefinition/ordinalValue');
    if (ordinalExtension != null) {
      responseOrdinalExtension = <FhirExtension>[
        FhirExtension(
            url: FhirUri(
                'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value'),
            valueDecimal: ordinalExtension.valueDecimal),
      ];
    }

    return responseOrdinalExtension;
  }

  /// Convert [ValueSet]s or [QuestionnaireAnswerOption]s to normalized [QuestionnaireAnswerOption]s
  void _buildAnswerOptions() {
    final qi = widget.location.questionnaireItem;
    final questionnaire = widget.location.questionnaire;

    if (qi.answerValueSet != null) {
      final key = qi.answerValueSet?.value?.toString();
      if (key == null) {
        throw QuestionnaireFormatException(
            'Questionnaire choice item does not specify a key', qi);
      }
      final isValueSetContained = key.startsWith('#');
      final ValueSet? valueSet = isValueSetContained
          ? widget.location.top.findContainedByElementId(key) as ValueSet?
          : FhirValueSet.getValueSet(key);

      if (valueSet == null) {
        throw QuestionnaireFormatException(
            isValueSetContained
                ? 'Questionnaire does not contain referenced ValueSet $key'
                : 'External ValueSet $key cannot be located.',
            questionnaire);
      }

      final ValueSetInclude? valueSetInclude =
          valueSet.compose?.include.firstOrNull;

      if (valueSetInclude == null) {
        throw QuestionnaireFormatException(
            'Include in ValueSet $key does not exist.', qi);
      }

      final List<ValueSetConcept> valueSetConcepts =
          valueSetInclude.concept ?? [];

      if (valueSetConcepts.isEmpty) {
        developer.log('Concepts in ValueSet $key is empty.',
            level: LogLevel.warn);
      }

      for (final concept in valueSetConcepts) {
        _answerOptions.addEntries([
          MapEntry<String, QuestionnaireAnswerOption>(
              concept.code!.toString(),
              QuestionnaireAnswerOption(
                  valueCoding: Coding(
                      system: valueSetInclude.system,
                      code: concept.code,
                      userSelected: Boolean(true),
                      display: concept.display,
                      extension_: _buildOrdinalExtension(concept.extension_))))
        ]);
      }
    } else {
      if (qi.answerOption != null) {
        _answerOptions.addEntries(qi.answerOption!.map<
            MapEntry<String, QuestionnaireAnswerOption>>((qao) => MapEntry<
                String, QuestionnaireAnswerOption>(
            qao.optionCode,
            qao.copyWith(
                valueCoding: (qao.valueCoding != null)
                    ? qao.valueCoding!.copyWith(
                        userSelected: Boolean(true),
                        extension_: _buildOrdinalExtension(qao.extension_))
                    : Coding(
                        // The spec only allows valueCoding, but real-world incl. valueString
                        display: qao.valueString,
                        userSelected: Boolean(true))))));
      }
    }
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final qi = widget.location.questionnaireItem;

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
    for (final choice in _answerOptions.values) {
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
              value: value?.coding?.firstWhereOrNull(
                      (coding) => coding.code?.value == choice.optionCode) !=
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

    return Column(
      children: choices,
    );
  }
}
