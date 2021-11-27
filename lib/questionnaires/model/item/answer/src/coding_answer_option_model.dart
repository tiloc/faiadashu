import 'dart:ui';

import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

import '../../../../../fhir_types/fhir_types.dart';

class CodingAnswerOptionModel {
  static const openChoiceCode = 'x-faiadashu-open-choice';

  final String uid;

  final Coding? coding;
  final String plainText;
  final List<FhirExtension>? xhtmlExtensions;
  final Decimal? fhirOrdinalValue;
  final String? optionPrefix;
  final bool isExclusive;

  bool matches(String? otherCode) {
    return (otherCode != null) &&
        (otherCode == coding?.code?.value || plainText == otherCode);
  }

  CodingAnswerOptionModel._({
    required this.uid,
    required this.plainText,
    this.xhtmlExtensions,
    this.coding,
    this.fhirOrdinalValue,
    this.optionPrefix,
    this.isExclusive = false,
  });

  factory CodingAnswerOptionModel.fromOpenChoice(String openLabel) {
    return CodingAnswerOptionModel._(
      uid: openChoiceCode,
      plainText: openLabel,
      isExclusive: true,
    );
  }

  factory CodingAnswerOptionModel.fromValueSetCoding(
    String uid,
    Locale locale,
    Coding coding,
  ) {
    final extensions = coding.extension_;
    final optionPrefix = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/valueset-label',
        )
        ?.valueString;

    final ordinalValue = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/ordinalValue',
        )
        ?.valueDecimal;

    final plainText = coding.localizedDisplay(locale);
    final xhtmlExtensions = coding.displayElement?.extension_;

    return CodingAnswerOptionModel._(
      uid: uid,
      coding: coding,
      fhirOrdinalValue: ordinalValue,
      optionPrefix: optionPrefix,
      plainText: plainText,
      xhtmlExtensions: xhtmlExtensions,
    );
  }

  factory CodingAnswerOptionModel.fromQuestionnaireAnswerOption(
    String uid,
    Locale locale,
    QuestionnaireAnswerOption qao,
  ) {
    final extensions = qao.extension_;
    final ordinalValue = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/ordinalValue',
        )
        ?.valueDecimal;

    final isExclusive = extensions
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-optionExclusive',
            )
            ?.valueBoolean
            ?.value ==
        true;

    final optionPrefix = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix',
        )
        ?.valueString;

    String plainText;
    List<FhirExtension>? xhtmlExtensions;
    final valueCoding = qao.valueCoding;
    if (valueCoding != null) {
      plainText = valueCoding.localizedDisplay(locale);
      xhtmlExtensions = valueCoding.displayElement?.extension_;
    } else {
      // The spec only allows valueCoding, but valueString occurs in the real world
      final valueString = qao.valueString;
      if (valueString == null) {
        throw QuestionnaireFormatException(
          '$qao specifies neither valueCode nor valueString.',
        );
      }
      plainText = valueString;
      xhtmlExtensions = qao.valueStringElement?.extension_;
    }

    return CodingAnswerOptionModel._(
      uid: uid,
      coding: qao.valueCoding,
      plainText: plainText,
      xhtmlExtensions: xhtmlExtensions,
      fhirOrdinalValue: ordinalValue,
      isExclusive: isExclusive,
      optionPrefix: optionPrefix,
    );
  }

  // Provide the ordinalValue as both ordinalValue and iso21090-CO-value.
  List<FhirExtension> _createOrdinalExtension() {
    List<FhirExtension> responseOrdinalExtension = [];
    final ordinalValue = fhirOrdinalValue;

    if (ordinalValue != null) {
      responseOrdinalExtension = <FhirExtension>[
        FhirExtension(
          url: FhirUri('http://hl7.org/fhir/StructureDefinition/ordinalValue'),
          valueDecimal: ordinalValue,
        ),
        FhirExtension(
          url: FhirUri(
            'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value',
          ),
          valueDecimal: ordinalValue,
        ),
      ];
    }

    return responseOrdinalExtension;
  }

  Coding createFhirCoding() {
    if (uid != openChoiceCode) {
      final ordinalExtension = _createOrdinalExtension();
      final codingExtensions = ordinalExtension;
      final coding = this.coding;

      // TODO: Emit XHTML

      return coding != null
          ? coding.copyWith(
              extension_:
                  (codingExtensions.isNotEmpty) ? codingExtensions : null,
            )
          : Coding(display: plainText);
    } else {
      throw StateError('open text option cannot create FHIR Coding.');
    }
  }
}
