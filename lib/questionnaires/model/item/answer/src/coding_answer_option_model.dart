import 'dart:ui';

import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/r4.dart';

class CodingAnswerOptionModel {
  final String uid;

  final QuestionnaireItemModel questionnaireItemModel;

  final Coding? coding;

  /// The styled text representation of the option during user-interaction.
  final RenderingString optionText;

  /// The text representation that should fill the `display` field of the [Coding]
  /// during FHIR response creation. Can differ from [plainText] when the
  /// `choiceColumn` extension is used.
  final String forDisplay;

  final ItemMediaModel? itemMedia;

  bool get hasMedia => itemMedia != null;

  final FhirDecimal? fhirOrdinalValue;
  final RenderingString? optionPrefix;
  final bool isExclusive;

  bool matches(String? otherCode) {
    return (otherCode != null) &&
        (otherCode == coding?.code?.value || optionText.plainText == otherCode);
  }

  CodingAnswerOptionModel._({
    required this.uid,
    required this.questionnaireItemModel,
    required this.optionText,
    required this.forDisplay,
    this.itemMedia,
    this.coding,
    this.fhirOrdinalValue,
    this.optionPrefix,
    this.isExclusive = false,
  });

  factory CodingAnswerOptionModel.fromValueSetCoding(
    String uid,
    Locale locale,
    QuestionnaireItemModel questionnaireItemModel,
    Coding coding,
  ) {
    final extensions = coding.extension_;
    final plainOptionPrefix = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/valueset-label',
        )
        ?.valueString;

    final optionPrefix = (plainOptionPrefix != null)
        ? RenderingString.fromText(plainOptionPrefix)
        : null;

    final ordinalValue = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/ordinalValue',
        )
        ?.valueDecimal;

    RenderingString optionText;
    String forDisplay;

    final choiceColumns = _findChoiceColumns(questionnaireItemModel);
    if (choiceColumns == null) {
      final plainText = coding.localizedDisplay(locale);
      optionText = RenderingString.fromText(
        plainText,
        extensions: coding.displayElement?.extension_,
      );
      forDisplay = plainText;
    } else {
      final plainText =
          _createMultiColumn(coding, locale, questionnaireItemModel);
      optionText = RenderingString.fromText(plainText);
      forDisplay = _createForDisplay(coding, locale, questionnaireItemModel);
    }

    return CodingAnswerOptionModel._(
      uid: uid,
      questionnaireItemModel: questionnaireItemModel,
      coding: coding,
      fhirOrdinalValue: ordinalValue,
      optionPrefix: optionPrefix,
      optionText: optionText,
      forDisplay: forDisplay,
    );
  }

  factory CodingAnswerOptionModel.fromQuestionnaireAnswerOption(
    String uid,
    Locale locale,
    QuestionnaireItemModel questionnaireItemModel,
    QuestionnaireAnswerOption qao,
  ) {
    final extensions = qao.extension_;
    final coding = qao.valueCoding;

    final mediaAttachment = qao.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemAnswerMedia',
        )
        ?.valueAttachment;

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

    final plainOptionPrefix = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix',
        )
        ?.valueString;

    final optionPrefix = (plainOptionPrefix != null)
        ? RenderingString.fromText(plainOptionPrefix)
        : null;

    RenderingString optionText;
    String forDisplay;

    if (coding != null) {
      final choiceColumns = _findChoiceColumns(questionnaireItemModel);
      if (choiceColumns == null) {
        final plainText = coding.localizedDisplay(locale);
        final xhtmlExtensions = coding.displayElement?.extension_;
        forDisplay = plainText;
        optionText = RenderingString.fromText(
          plainText,
          extensions: xhtmlExtensions,
        );
      } else {
        final plainText =
            _createMultiColumn(coding, locale, questionnaireItemModel);
        forDisplay = _createForDisplay(coding, locale, questionnaireItemModel);
        optionText = RenderingString.fromText(
          plainText,
        );
      }
    } else {
      // The spec only allows valueCoding, but valueString occurs in the real world
      final valueString = qao.valueString;
      if (valueString == null) {
        throw QuestionnaireFormatException(
          '$qao specifies neither valueCode nor valueString.',
        );
      }
      final plainText = valueString;
      final xhtmlExtensions = qao.valueStringElement?.extension_;
      forDisplay = plainText;
      optionText = RenderingString.fromText(
        plainText,
        extensions: xhtmlExtensions,
      );
    }

    final itemMedia = ItemMediaModel.fromAttachment(
      mediaAttachment,
      mediaProvider:
          questionnaireItemModel.questionnaireModel.fhirResourceProvider,
      altText: optionText,
    );

    return CodingAnswerOptionModel._(
      uid: uid,
      questionnaireItemModel: questionnaireItemModel,
      coding: coding,
      optionText: optionText,
      forDisplay: forDisplay,
      fhirOrdinalValue: ordinalValue,
      isExclusive: isExclusive,
      optionPrefix: optionPrefix,
      itemMedia: itemMedia,
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
    final ordinalExtension = _createOrdinalExtension();
    final codingExtensions = ordinalExtension;
    final coding = this.coding;

    // TODO: Emit XHTML

    return coding != null
        ? coding.copyWith(
            extension_: (codingExtensions.isNotEmpty) ? codingExtensions : null,
            userSelected: FhirBoolean(true),
          )
        : Coding(
            display: forDisplay,
            userSelected: FhirBoolean(true),
          );
  }

  static List<FhirExtension>? _findChoiceColumns(
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    final choiceColumns = questionnaireItemModel.questionnaireItem.extension_
        ?.where(
          (extension) =>
              extension.url ==
              FhirUri(
                'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-choiceColumn',
              ),
        )
        .toList(growable: false);

    if (choiceColumns == null || choiceColumns.isEmpty) {
      return null;
    }

    return choiceColumns;
  }

  static const displayForDisplayPath = 'display';
  static const codeForDisplayPath = 'code';

  static String _findForDisplayPath(
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    final itemControlExtension =
        questionnaireItemModel.questionnaireItem.itemControl;
    if (itemControlExtension == null) {
      return displayForDisplayPath;
    }

    final choiceColumns = _findChoiceColumns(questionnaireItemModel);
    if (choiceColumns == null) {
      return displayForDisplayPath;
    }

    final forDisplayColumn = choiceColumns.firstWhere(
      (choiceColumnExt) =>
          choiceColumnExt.extension_
              ?.extensionOrNull('forDisplay')
              ?.valueBoolean ==
          FhirBoolean(true),
    );

    final forDisplayPath =
        forDisplayColumn.extension_?.extensionOrNull('path')?.valueString;

    return forDisplayPath ?? displayForDisplayPath;
  }

  static String _createForCodingPath(
    String path,
    Coding coding,
    Locale locale,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    if (path == displayForDisplayPath) {
      return coding.localizedDisplay(locale);
    } else if (path == codeForDisplayPath) {
      final code = coding.code?.value;
      if (code == null) {
        throw QuestionnaireFormatException(
          '$coding does not have a code for choiceColumn.',
          questionnaireItemModel,
        );
      }

      return code;
    } else {
      // TODO: Support further possibilities
      return coding.localizedDisplay(locale);
    }
  }

  static String _createMultiColumn(
    Coding coding,
    Locale locale,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    final choiceColumns = _findChoiceColumns(questionnaireItemModel);

    if (choiceColumns == null) {
      throw StateError('Missing choice columns.');
    }

    final outputs = choiceColumns.map<String>((ext) {
      final path = ext.extension_?.extensionOrNull('path')?.valueString;
      if (path != null) {
        return _createForCodingPath(
          path,
          coding,
          locale,
          questionnaireItemModel,
        );
      } else {
        throw QuestionnaireFormatException(
          'column choice is lacking path',
          ext,
        );
      }
    });

    return outputs.join(' — ');
  }

  static String _createForDisplay(
    Coding coding,
    Locale locale,
    QuestionnaireItemModel questionnaireItemModel,
  ) {
    final forDisplayPath = _findForDisplayPath(questionnaireItemModel);

    return _createForCodingPath(
      forDisplayPath,
      coding,
      locale,
      questionnaireItemModel,
    );
  }
}
