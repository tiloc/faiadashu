import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../logging/logging.dart';
import '../../../model.dart';

/// Model answers which are [Coding]s.
class CodingAnswerModel extends AnswerModel<CodeableConcept, CodeableConcept> {
  // ignore: prefer_collection_literals
  final _answerOptions = LinkedHashMap<String, QuestionnaireAnswerOption>();
  static final _logger = Logger(CodingAnswerModel);

  LinkedHashMap<String, QuestionnaireAnswerOption> get answerOptions =>
      _answerOptions;

  static const openChoiceOther = 'open-choice-other';

  /// Toggles the checkbox with the provided [checkboxValue].
  ///
  /// Used in repeating items.
  CodeableConcept? toggleValue(CodeableConcept? value, String? checkboxValue) {
    _logger.trace('Enter toggledValue $checkboxValue');
    if (checkboxValue == null) {
      return null;
    }
    if ((value == null) || (value.coding == null)) {
      return fromChoiceString(checkboxValue);
    }

    final entryIndex = value.coding!
        .indexWhere((coding) => coding.code?.value == checkboxValue);
    if (entryIndex == -1) {
      _logger.debug('$checkboxValue currently not selected.');
      final enabledCodeableConcept = fromChoiceString(checkboxValue)!;
      final enabledCoding = enabledCodeableConcept.coding!.first;
      if (isExclusive(enabledCoding)) {
        _logger.debug('$checkboxValue isExclusive');
        // The newly enabled checkbox is exclusive, kill all others.
        return enabledCodeableConcept;
      } else {
        _logger.debug('$checkboxValue is not exclusive');
        // Kill all exclusive ones.
        return value.copyWith(
          coding: [
            ...value.coding!.whereNot((coding) => isExclusive(coding)),
            enabledCoding
          ],
        );
      }
    } else {
      _logger.debug('$checkboxValue currently selected.');
      return CodeableConcept(coding: value.coding!..removeAt(entryIndex));
    }
  }

  String? choiceStringFromCoding(Coding? coding) {
    if (coding == null) {
      return null;
    }
    final choiceString =
        (coding.code != null) ? coding.code?.value : coding.display;

    if (choiceString == null) {
      throw QuestionnaireFormatException(
        'Insufficient info for choice string in $coding',
        coding,
      );
    } else {
      return choiceString;
    }
  }

  String? _choiceStringFromCodings(List<Coding>? codings) {
    if (codings == null) {
      return null;
    }

    // TODO: Can it ever be harmful that this is only looking at the first coding?
    final coding = codings.firstOrNull;
    return choiceStringFromCoding(coding);
  }

  /// Extract a string from a [CodeableConcept].
  ///
  /// Can be used as groupValue in checkboxes/radiobuttons, or as a key in maps.
  ///
  /// Throws when [Questionnaire] is malformed.
  ///
  /// Returns null if [codeableConcept] is null
  String? toChoiceString(CodeableConcept? codeableConcept) {
    if (codeableConcept == null) {
      return null;
    }
    return _choiceStringFromCodings(
      ArgumentError.checkNotNull(codeableConcept.coding),
    );
  }

  CodeableConcept? fromChoiceString(String? choiceString) {
    return (choiceString != null)
        ? CodeableConcept(coding: [answerOptions[choiceString]!.valueCoding!])
        : null;
  }

  bool isExclusive(Coding coding) {
    return answerOptions[choiceStringFromCoding(coding)]!
            .extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-optionExclusive',
            )
            ?.valueBoolean
            ?.value ==
        true;
  }

  /// Returns whether the options should be presented as an auto-complete control
  bool get isAutocomplete {
    return !(qi.repeats == Boolean(true)) &&
        (answerOptions.length > 10 || qi.isItemControl('autocomplete'));
  }

  // Take the existing extensions that might contain information about
  // ordinal values and provide them as both ordinalValue and iso21090-CO-value.
  List<FhirExtension>? _createOrdinalExtension(
    List<FhirExtension>? inExtension,
  ) {
    List<FhirExtension>? responseOrdinalExtension;

    final FhirExtension? ordinalExtension = inExtension?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/ordinalValue',
        ) ??
        inExtension?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value',
        );
    if (ordinalExtension != null) {
      responseOrdinalExtension = <FhirExtension>[
        FhirExtension(
          url: FhirUri('http://hl7.org/fhir/StructureDefinition/ordinalValue'),
          valueDecimal: ordinalExtension.valueDecimal,
        ),
        FhirExtension(
          url: FhirUri(
            'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value',
          ),
          valueDecimal: ordinalExtension.valueDecimal,
        ),
      ];
    }

    return responseOrdinalExtension;
  }

  void _addAnswerOption(Coding coding) {
    _answerOptions.addEntries([
      MapEntry<String, QuestionnaireAnswerOption>(
        coding.code!.toString(),
        FDashQuestionnaireAnswerOptionExtensions.fromCoding(
          coding,
          extensionBuilder: (inCoding) =>
              _createOptionPrefixExtension(inCoding.extension_),
          codingExtensionBuilder: (inCoding) =>
              _createOrdinalExtension(inCoding.extension_),
        ),
      )
    ]);
  }

  List<FhirExtension>? _createOptionPrefixExtension(
    List<FhirExtension>? inExtension,
  ) {
    List<FhirExtension>? responseOptionPrefixExtension;

    final FhirExtension? labelExtension = inExtension?.extensionOrNull(
      'http://hl7.org/fhir/StructureDefinition/valueset-label',
    );
    if (labelExtension != null) {
      responseOptionPrefixExtension = <FhirExtension>[
        FhirExtension(
          url: FhirUri(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix',
          ),
          valueString: labelExtension.valueString,
        ),
      ];
    }

    return responseOptionPrefixExtension;
  }

  /// Convert [ValueSet]s or [QuestionnaireAnswerOption]s to normalized [QuestionnaireAnswerOption]s
  void _createAnswerOptions() {
    if (qi.answerValueSet != null) {
      final key = qi.answerValueSet?.value?.toString();
      if (key == null) {
        throw QuestionnaireFormatException(
          'Questionnaire choice item does not specify a key',
          qi,
        );
      }

      questionnaireItemModel.questionnaireModel
          .forEachInValueSet(key, _addAnswerOption, context: qi);
    } else {
      if (qi.answerOption != null) {
        _answerOptions.addEntries(
          qi.answerOption!.map<MapEntry<String, QuestionnaireAnswerOption>>(
            (qao) => MapEntry<String, QuestionnaireAnswerOption>(
              qao.optionCode,
              qao.copyWith(
                valueCoding: (qao.valueCoding != null)
                    ? qao.valueCoding!.copyWith(
                        userSelected: Boolean(true),
                        extension_: _createOrdinalExtension(qao.extension_),
                      )
                    : Coding(
                        // The spec only allows valueCoding, but real-world incl. valueString
                        display: qao.valueString,
                        userSelected: Boolean(true),
                      ),
              ),
            ),
          ),
        );
      }
    }
  }

  late final int minOccurs;
  late final int? maxOccurs;

  CodingAnswerModel(QuestionItemModel responseModel) : super(responseModel) {
    _createAnswerOptions();

    minOccurs = qi.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-minOccurs',
            )
            ?.valueInteger
            ?.value ??
        0;

    maxOccurs = qi.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-maxOccurs',
        )
        ?.valueInteger
        ?.value;
  }

  @override
  String get display => value?.localizedDisplay(locale) ?? AnswerModel.nullText;

  /// Returns whether the choices should be presented horizontally.
  bool get isHorizontal {
    return qi.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation',
            )
            ?.valueCode
            ?.value ==
        'horizontal';
  }

  @override
  String? validateInput(CodeableConcept? inValue) {
    if (inValue == null) {
      return null;
    }

    final int length = inValue.coding?.length ?? 0;

    if (length < minOccurs) {
      return lookupFDashLocalizations(locale).validatorMinOccurs(minOccurs);
    }

    if (maxOccurs != null && length > maxOccurs!) {
      return lookupFDashLocalizations(locale).validatorMaxOccurs(maxOccurs!);
    }
  }

  @override
  QuestionnaireResponseAnswer? get filledAnswer {
    throw UnsupportedError(
      'CodingAnswerModel will always return coding answers.',
    );
  }

  @override
  List<QuestionnaireResponseAnswer>? get filledCodingAnswers {
    if (value == null) {
      return null;
    }

    // TODO(tiloc): Return the order of the codings in the order of the choices?

    // TODO: This is only supporting a single other text.
    final result = (value!.coding?.firstOrNull?.code?.value == openChoiceOther)
        ? [
            QuestionnaireResponseAnswer(
              valueCoding: Coding(display: value!.text),
            )
          ]
        : value!.coding?.map<QuestionnaireResponseAnswer>((coding) {
            // Some answers may only be a display, not have a code
            return coding.code != null
                ? QuestionnaireResponseAnswer(
                    valueCoding: answerOptions[choiceStringFromCoding(coding)]!
                        .valueCoding,
                  )
                : QuestionnaireResponseAnswer(valueCoding: coding);
          }).toList();

    return result;
  }

  @override
  bool get hasCodingAnswers => true;

  @override
  QuestionnaireErrorFlag? get isComplete {
    if (value == null && minOccurs > 0) {
      return QuestionnaireErrorFlag(
        questionnaireItemModel.linkId,
        errorText:
            lookupFDashLocalizations(locale).validatorMinOccurs(minOccurs),
      );
    }

    final validationText = validateInput(value);
    return (validationText == null)
        ? null
        : QuestionnaireErrorFlag(
            questionnaireItemModel.linkId,
            errorText: validationText,
          );
  }

  @override
  bool get isUnanswered => value == null;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    // FIXME: Enable population from multiple answers
/*    final responseItem = responseItemModel.responseItem;

    if (responseItem != null) {
      value = (responseItem.answer != null)
          ? CodeableConcept(
        coding: responseItem.answer
            ?.map(
              (answer) => answerOptions[
          choiceStringFromCoding(answer.valueCoding)]!
              .valueCoding!,
        )
            .toList(),
      )
          : null;
    } */
  }
}
