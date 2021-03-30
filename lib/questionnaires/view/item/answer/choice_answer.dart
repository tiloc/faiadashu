import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';
import '../../xhtml.dart';

class ChoiceAnswer extends QuestionnaireAnswerFiller {
  static final logger = Logger(ChoiceAnswer);
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
  static final logger = Logger(_ChoiceAnswerState);
  // ignore: prefer_collection_literals
  final _answerOptions = LinkedHashMap<String, QuestionnaireAnswerOption>();

  _ChoiceAnswerState();

  @override
  void initState() {
    super.initState();

    _createAnswerOptions();

    if (widget.location.responseItem != null) {
      initialValue = _fillValue(
          _choiceStringFromCoding(widget.answerLocation.answer?.valueCoding));
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

    // TODO(tiloc): Return the order of the codings in the order of the choices
    // TODO(tiloc): Support open free text (should always come last?)
    return value!.coding?.map<QuestionnaireResponseAnswer>((coding) {
      // Some answers may only be a display, not have a code
      return coding.code != null
          ? QuestionnaireResponseAnswer(
              valueCoding:
                  _answerOptions[_choiceStringFromCoding(coding)]!.valueCoding)
          : QuestionnaireResponseAnswer(valueCoding: coding);
    }).toList();
  }

  @override
  bool hasChoiceAnswers() {
    return true;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return Text(
        value?.localizedDisplay(Localizations.localeOf(context)) ?? '-');
  }

  @override
  Widget buildEditable(BuildContext context) {
    if (_answerOptions.length < 15) {
      return _buildChoiceAnswers(context);
    } else {
      return _buildLookupAnswers(context);
    }
  }

  CodeableConcept? _fillValue(String? newValue) {
    return (newValue != null)
        ? CodeableConcept(coding: [_answerOptions[newValue]!.valueCoding!])
        : null;
  }

  /// Turn on/off the checkbox with the provided [toggleValue].
  /// Used in repeating items.
  CodeableConcept? _fillToggledValue(String? toggleValue) {
    if (toggleValue == null) {
      return null;
    }
    if ((value == null) || (value!.coding == null)) {
      return _fillValue(toggleValue);
    }

    final entryIndex = value!.coding!
        .indexWhere((coding) => coding.code?.value == toggleValue);
    if (entryIndex == -1) {
      return value!.copyWith(
          coding: [...value!.coding!, ..._fillValue(toggleValue)!.coding!]);
    } else {
      return CodeableConcept(coding: value!.coding!..removeAt(entryIndex));
    }
  }

  // Take the existing extensions that might contain information about
  // ordinal values and convert them from ordinalValue to iso21090-CO-value
  List<FhirExtension>? _createOrdinalExtension(
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

  List<FhirExtension>? _createOptionPrefixExtension(
      List<FhirExtension>? inExtension) {
    List<FhirExtension>? responseOptionPrefixExtension;

    final FhirExtension? labelExtension = inExtension?.extensionOrNull(
        'http://hl7.org/fhir/StructureDefinition/valueset-label');
    if (labelExtension != null) {
      responseOptionPrefixExtension = <FhirExtension>[
        FhirExtension(
            url: FhirUri(
                'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix'),
            valueString: labelExtension.valueString),
      ];
    }

    return responseOptionPrefixExtension;
  }

  String? _choiceStringFromCoding(Coding? coding) {
    if (coding == null) {
      return null;
    }
    final choiceString =
        (coding.code != null) ? coding.code?.value : coding.display;

    if (choiceString == null) {
      throw QuestionnaireFormatException(
          'Insufficient info for choice string in $coding', coding);
    } else {
      return choiceString;
    }
  }

  String? _choiceStringFromCodings(List<Coding>? codings) {
    if (codings == null) {
      return null;
    }

    final coding = codings.firstOrNull;
    return _choiceStringFromCoding(coding);
  }

  /// Extract a string from a [CodeableConcept].
  /// Can be used as groupValue in checkboxes/radiobuttons, or as a key in maps
  /// Throws when Questionnaire is malformed.
  /// Returns null if [codeableConcept] is null
  String? _choiceString(CodeableConcept? codeableConcept) {
    if (codeableConcept == null) {
      return null;
    }
    return _choiceStringFromCodings(
        ArgumentError.checkNotNull(codeableConcept.coding));
  }

  /// Convert [ValueSet]s or [QuestionnaireAnswerOption]s to normalized [QuestionnaireAnswerOption]s
  void _createAnswerOptions() {
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
          : widget.location.top.getValueSet(key);

      if (valueSet == null) {
        if (isValueSetContained) {
          throw QuestionnaireFormatException(
              'Questionnaire does not contain referenced ValueSet $key',
              questionnaire.contained);
        } else {
          throw QuestionnaireFormatException(
              'External ValueSet $key cannot be located.', qi);
        }
      }

      final List<ValueSetContains>? valueSetContains =
          valueSet.expansion?.contains;

      if (valueSetContains != null) {
        // Expansion has preference over includes. They are not additive.
        for (final contains in valueSetContains) {
          _answerOptions.addEntries([
            MapEntry<String, QuestionnaireAnswerOption>(
                contains.code!.toString(),
                QuestionnaireAnswerOption(
                    extension_:
                        _createOptionPrefixExtension(contains.extension_),
                    valueCoding: Coding(
                        system: contains.system,
                        code: contains.code,
                        userSelected: Boolean(true),
                        display: contains.display,
                        extension_:
                            _createOrdinalExtension(contains.extension_))))
          ]);
        }
      } else {
        final List<ValueSetInclude>? valueSetIncludes =
            valueSet.compose?.include;

        if (valueSetIncludes == null) {
          throw QuestionnaireFormatException(
              'Include in ValueSet $key does not exist.', qi);
        }

        for (final valueSetInclude in valueSetIncludes) {
          final List<ValueSetConcept> valueSetConcepts =
              valueSetInclude.concept ?? [];

          if (valueSetConcepts.isEmpty) {
            logger.log('Concepts in ValueSet $key is empty.');
            // TODO: This is hacky, but a start
            // ValueSets may contain references to further included ValueSets.
            final includeUri =
                valueSetInclude.valueSet?.firstOrNull?.value?.toString();
            if (includeUri != null) {
              final includeConcepts = widget.location.top
                  .getValueSet(includeUri)
                  ?.compose
                  ?.include
                  .firstOrNull
                  ?.concept;
              valueSetConcepts.addAll(includeConcepts ?? []);
            }
          }

          for (final concept in valueSetConcepts) {
            _answerOptions.addEntries([
              MapEntry<String, QuestionnaireAnswerOption>(
                  concept.code!.toString(),
                  QuestionnaireAnswerOption(
                      extension_:
                          _createOptionPrefixExtension(concept.extension_),
                      valueCoding: Coding(
                          system: valueSetInclude.system,
                          code: concept.code,
                          userSelected: Boolean(true),
                          display: concept.display,
                          extension_:
                              _createOrdinalExtension(concept.extension_))))
            ]);
          }
        }
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
                        extension_: _createOrdinalExtension(qao.extension_))
                    : Coding(
                        // The spec only allows valueCoding, but real-world incl. valueString
                        display: qao.valueString,
                        userSelected: Boolean(true))))));
      }
    }
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final qi = widget.location.questionnaireItem;
    final isCheckBox = qi.isItemControl('check-box');
    final isMultipleChoice = (qi.repeats?.value ?? isCheckBox) == true;

    final choices = <Widget>[];
    if (!isMultipleChoice) {
      choices.add(RadioListTile<String?>(
          title: Text(
            '---',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          value: null,
          groupValue: _choiceString(value),
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
      final optionTitle =
          '$optionPrefixDisplay${choice.localizedDisplay(Localizations.localeOf(context))}';
      final styledOptionTitle = Xhtml.toWidget(context, widget.location.top,
          optionTitle, choice.valueStringElement?.extension_,
          width: 100, height: 100);

      choices.add(isMultipleChoice
          ? CheckboxListTile(
              title: styledOptionTitle,
              value: value?.coding?.firstWhereOrNull(
                      (coding) => coding.code?.value == choice.optionCode) !=
                  null,
              onChanged: (bool? newValue) {
                value = _fillToggledValue(choice.optionCode);
              })
          : RadioListTile<String>(
              title: styledOptionTitle,
              value: choice.optionCode,
              groupValue: _choiceString(value),
              onChanged: (String? newValue) {
                value = _fillValue(newValue);
              }));
    }

    if (qi.extension_
                ?.extensionOrNull(
                    'http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation')
                ?.valueCode
                ?.value ==
            'horizontal' &&
        MediaQuery.of(context).size.width > 750) {
      return Card(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          child: Table(children: [TableRow(children: choices)]));
    } else {
      return Card(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            children: choices,
          ));
    }
  }

  Widget _buildLookupAnswers(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Autocomplete<QuestionnaireAnswerOption>(
      displayStringForOption: (answerOption) =>
          answerOption.localizedDisplay(locale),
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<QuestionnaireAnswerOption>.empty();
        }
        return _answerOptions.values.where((QuestionnaireAnswerOption option) {
          return option
              .localizedDisplay(locale)
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (QuestionnaireAnswerOption selectedOption) {
        value = _fillValue(selectedOption.optionCode);
      },
    );
  }
}
