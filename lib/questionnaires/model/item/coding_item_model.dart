import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logger.dart';
import '../questionnaire_exceptions.dart';
import '../questionnaire_extensions.dart';
import '../questionnaire_location.dart';
import 'item_model.dart';

/// Model answers which are [Coding]s.
class CodingItemModel extends ItemModel<CodeableConcept> {
  // ignore: prefer_collection_literals
  final _answerOptions = LinkedHashMap<String, QuestionnaireAnswerOption>();
  static final _logger = Logger(CodingItemModel);

  LinkedHashMap<String, QuestionnaireAnswerOption> get answerOptions =>
      _answerOptions;

  /// Turn on/off the checkbox with the provided [toggleValue].
  /// Used in repeating items.
  CodeableConcept? toggleValue(CodeableConcept? value, String? toggleValue) {
    _logger.trace('Enter fillToggledValue $toggleValue');
    if (toggleValue == null) {
      return null;
    }
    if ((value == null) || (value.coding == null)) {
      return fromChoiceString(toggleValue);
    }

    final entryIndex =
        value.coding!.indexWhere((coding) => coding.code?.value == toggleValue);
    if (entryIndex == -1) {
      _logger.debug('$toggleValue currently not selected.');
      final enabledCodeableConcept = fromChoiceString(toggleValue)!;
      final enabledCoding = enabledCodeableConcept.coding!.first;
      if (isExclusive(enabledCoding)) {
        _logger.debug('$toggleValue isExclusive');
        // The newly enabled checkbox is exclusive, kill all others.
        return enabledCodeableConcept;
      } else {
        _logger.debug('$toggleValue is not exclusive');
        // Kill all exclusive ones.
        return value.copyWith(coding: [
          ...value.coding!.whereNot((coding) => isExclusive(coding)),
          enabledCoding
        ]);
      }
    } else {
      _logger.debug('$toggleValue currently selected.');
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
          'Insufficient info for choice string in $coding', coding);
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
        ArgumentError.checkNotNull(codeableConcept.coding));
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
                'http://hl7.org/fhir/StructureDefinition/questionnaire-optionExclusive')
            ?.valueBoolean
            ?.value ==
        true;
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
          ))
    ]);
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

  /// Convert [ValueSet]s or [QuestionnaireAnswerOption]s to normalized [QuestionnaireAnswerOption]s
  void _createAnswerOptions() {
    if (qi.answerValueSet != null) {
      final key = qi.answerValueSet?.value?.toString();
      if (key == null) {
        throw QuestionnaireFormatException(
            'Questionnaire choice item does not specify a key', qi);
      }

      location.top.visitValueSet(key, _addAnswerOption, context: qi);
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

  CodingItemModel(QuestionnaireLocation location) : super(location) {
    _createAnswerOptions();
  }

  @override
  String? validate(CodeableConcept? inValue) {}
}
