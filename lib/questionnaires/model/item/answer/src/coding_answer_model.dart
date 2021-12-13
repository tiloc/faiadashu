import 'package:collection/collection.dart';
import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';

/// Model answers which are [Coding]s.
class CodingAnswerModel extends AnswerModel<Set<String>, Set<String>> {
  final _answerOptions = <String, CodingAnswerOptionModel>{};
  static final _logger = Logger(CodingAnswerModel);

  Iterable<CodingAnswerOptionModel> get answerOptions => _answerOptions.values;

  int get numberOfOptions => _answerOptions.length;

  String? openText;

  /// Returns an answer option by its [uid].
  ///
  /// Throws if it doesn't exist.
  CodingAnswerOptionModel answerOptionByUid(String uid) {
    final answerOption = _answerOptions[uid];
    if (answerOption == null) {
      throw StateError('CodingAnswerModel does not contain option $uid');
    }

    return answerOption;
  }

  /// Returns an answer option by its [uid].
  ///
  /// Returns null if it doesn't exist.
  CodingAnswerOptionModel? answerOptionByUidOrNull(String? uid) =>
      (uid != null) ? _answerOptions[uid] : null;

  CodingAnswerOptionModel? get singleSelection {
    return answerOptionByUidOrNull(singleSelectionUid);
  }

  String? get singleSelectionUid {
    final value = this.value;
    if (value == null) {
      return null;
    }

    if (value.length != 1) {
      throw StateError('Selection has ${value.length} elements. Expected 1.');
    }

    return value.first;
  }

  bool isSelected(String uid) => value?.contains(uid) ?? false;

  String? get exclusiveSelectionUid {
    final value = this.value;

    if (value == null) {
      return null;
    }

    final exclusiveSelection =
        value.where((uid) => answerOptionByUid(uid).isExclusive);
    if (exclusiveSelection.isEmpty) {
      return null;
    }

    if (exclusiveSelection.length != 1) {
      throw StateError(
        '${exclusiveSelection.length} exclusive options selected.',
      );
    }

    return exclusiveSelection.first;
  }

  Set<String>? selectOption(String? uid) {
    return uid == null ? null : {uid};
  }

  /// Toggles the checkbox with the provided [checkboxValue].
  ///
  /// Used in repeating items.
  Set<String>? toggleOption(String uid) {
    _logger.trace('Enter toggledValue $uid');

    final value = this.value;

    if (value == null) {
      return {uid};
    }

    final toggledOption = answerOptionByUid(uid);

    if (toggledOption.isExclusive) {
      return {uid};
    }

    final newSet = Set.of(value);

    if (newSet.contains(uid)) {
      newSet.remove(uid);
    } else {
      newSet.removeWhere((uid) => answerOptionByUid(uid).isExclusive);
      newSet.add(uid);
    }

    return newSet;
  }

  /// Is this answer equal to a given coding?
  ///
  /// Implements the semantics as specified for enabledWhen
  bool equalsCoding(Coding? coding) {
    return value?.any(
          (uid) => _answerOptions[uid]?.coding?.match(coding) ?? false,
        ) ??
        false;
  }

  /// Returns whether the options should be presented as an auto-complete control
  bool get isAutocomplete => qi.isItemControl('autocomplete');

  bool get isDropdown => qi.isItemControl('drop-down');

  bool get isRadioButton => qi.isItemControl('radio-button');

  bool get isCheckbox => qi.isItemControl('check-box');

  RenderingString get openLabel => RenderingString.fromText(
        qi.extension_
                ?.extensionOrNull(
                  'http://hl7.org/fhir/uv/sdc/StructureDefinition/questionnaire-sdc-openLabel',
                )
                ?.valueString ??
            lookupFDashLocalizations(locale).fillerOpenCodingOtherLabel,
      );

  String _nextOptionUid() => _answerOptions.length.toString();

  void _addAnswerOptionFromValueSetCoding(Coding coding) {
    final uid = _nextOptionUid();
    final optionModel = CodingAnswerOptionModel.fromValueSetCoding(
      uid,
      locale,
      questionnaireItemModel,
      coding,
    );
    _answerOptions[uid] = optionModel;
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

      questionnaireItemModel.questionnaireModel.forEachInValueSet(
        key,
        _addAnswerOptionFromValueSetCoding,
        context: qi,
      );
    } else {
      final qiAnswerOptions = qi.answerOption;

      if (qiAnswerOptions != null) {
        for (final answerOption in qiAnswerOptions) {
          final uid = _nextOptionUid();
          final optionModel =
              CodingAnswerOptionModel.fromQuestionnaireAnswerOption(
            uid,
            locale,
            questionnaireItemModel,
            answerOption,
          );
          _answerOptions[uid] = optionModel;
        }
      }
    }

    if (qi.type == QuestionnaireItemType.open_choice) {
      final optionModel = CodingAnswerOptionModel.fromOpenChoice(
        questionnaireItemModel,
        openLabel,
      );
      _answerOptions[optionModel.uid] = optionModel;
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
  RenderingString get display {
    final value = this.value;
    if (value == null || value.isEmpty) {
      return RenderingString.nullText;
    }

    final xhtmlStrings = value.map<RenderingString>((uid) {
      return uid != CodingAnswerOptionModel.openChoiceCode
          ? answerOptionByUid(uid).optionText
          : RenderingString.fromText(openText ?? AnswerModel.nullText);
    });

    // TODO: Localized or themed separator character?

    return xhtmlStrings.concatenateXhtml('; ');
  }

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
  String? validateInput(Set<String>? inValue) {
    if (inValue == null) {
      return null;
    }

    final int length = inValue.length;

    if (length < minOccurs) {
      return lookupFDashLocalizations(locale).validatorMinOccurs(minOccurs);
    }

    if (maxOccurs != null && length > maxOccurs!) {
      return lookupFDashLocalizations(locale).validatorMaxOccurs(maxOccurs!);
    }
  }

  @override
  QuestionnaireResponseAnswer? createFhirAnswer(
    List<QuestionnaireResponseItem>? items,
  ) {
    throw UnsupportedError(
      'CodingAnswerModel will always return coding answers.',
    );
  }

  @override
  List<QuestionnaireResponseAnswer>? createFhirCodingAnswers(
    List<QuestionnaireResponseItem>? items,
  ) {
    final value = this.value;

    if (value == null) {
      return null;
    }

    final responses = value.map<QuestionnaireResponseAnswer>((uid) {
      if (uid != CodingAnswerOptionModel.openChoiceCode) {
        final answerOption = answerOptionByUid(uid);
        final answerExtensions = <FhirExtension>[
          if (answerOption.hasMedia)
            FhirExtension(
              url: FhirUri(
                'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemAnswerMedia',
              ),
              valueAttachment: answerOption.mediaAttachment,
            ),
        ];

        return QuestionnaireResponseAnswer(
          extension_: (answerExtensions.isNotEmpty) ? answerExtensions : null,
          valueCoding: answerOption.createFhirCoding(),
          item: items,
        );
      } else {
        return QuestionnaireResponseAnswer(
          valueCoding: Coding(display: openText),
          item: items,
        );
      }
    }).toList(growable: false);

    return responses;
  }

  @override
  bool get hasCodingAnswers => true;

  @override
  String? get isComplete {
    if (value == null && minOccurs > 0) {
      return lookupFDashLocalizations(locale).validatorMinOccurs(minOccurs);
    }

    final validationText = validateInput(value);

    return (validationText == null) ? null : validationText;
  }

  @override
  bool get isUnanswered => value == null;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    throw UnimplementedError('populate not implemented.');
  }

  @override
  void populateCodingAnswers(List<QuestionnaireResponseAnswer>? answers) {
    if (answers == null) {
      return;
    }

    final popSet = <String>{};
    for (final answer in answers) {
      final matchCode = answer.valueCoding?.code?.value ??
          answer.valueCoding?.display ??
          answer.valueString;

      // TODO: Currently not possible, due to open-choice
/*      if (matchCode == null) {
        throw QuestionnaireFormatException(
          'QuestionnaireResponseAnswer $answer requires either a valueCoding or a valueString.',
        );
      }
*/

      final matchingOption = answerOptions
          .firstWhereOrNull((answerOption) => answerOption.matches(matchCode));

      if (matchingOption != null) {
        popSet.add(matchingOption.uid);
      } else {
        popSet.add(CodingAnswerOptionModel.openChoiceCode);
        openText = answer.valueCoding?.display ?? answer.valueString;
      }
    }

    value = (popSet.isNotEmpty) ? popSet : null;
  }
}
