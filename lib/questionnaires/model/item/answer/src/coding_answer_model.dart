import 'package:collection/collection.dart';
import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';

/// Model answers which are [Coding]s.
///
/// R5 release of the FHIR SDC IG will have a `coding` item type,
/// and model the "open-ness" through the `answerConstraint`.
///
/// This model is already modelling this methodology for R4.
class CodingAnswerModel extends AnswerModel<OptionsOrString, OptionsOrString> {
  final _answerOptions = <String, CodingAnswerOptionModel>{};
  static final _logger = Logger(CodingAnswerModel);

  Iterable<CodingAnswerOptionModel> get answerOptions => _answerOptions.values;

  int get numberOfOptions => _answerOptions.length;

  bool get hasOpenStrings {
    final value = this.value;
    final openStrings = value?.openStrings;

    return value != null && openStrings != null && openStrings.isNotEmpty;
  }

  bool get hasNullOption => questionnaireItemModel
      .questionnaireModel.questionnaireModelDefaults.implicitNullOption;

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
    final selectedOptions = value?.selectedOptions;
    if (selectedOptions == null) {
      return null;
    }

    if (selectedOptions.length != 1) {
      throw StateError(
        'Selection has ${selectedOptions.length} elements. Expected 1.',
      );
    }

    return selectedOptions.first;
  }

  bool isSelected(String uid) => value?.selectedOptions?.contains(uid) ?? false;

  String? get exclusiveSelectionUid {
    final selectedOptions = value?.selectedOptions;

    if (selectedOptions == null) {
      return null;
    }

    final exclusiveSelection =
        selectedOptions.where((uid) => answerOptionByUid(uid).isExclusive);
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
  /// For repeating items, all exclusivity rules are evaluated.
  /// For non-repeating items, the selected item is selected, and all others
  /// are de-selected.
  Set<String>? toggleOption(String uid) {
    _logger.trace('Enter toggledValue $uid');

    final isSingleChoiceExclusive =
        !(questionnaireItemModel.questionnaireItem.repeats?.value ?? false);
    if (isSingleChoiceExclusive) {
      return {uid};
    }

    final selectedOptions = value?.selectedOptions;

    if (selectedOptions == null) {
      return {uid};
    }

    final toggledOption = answerOptionByUid(uid);

    if (toggledOption.isExclusive) {
      return {uid};
    }

    final newSet = Set.of(selectedOptions);

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
    return value?.selectedOptions?.any(
          (uid) => _answerOptions[uid]?.coding?.match(coding) ?? false,
        ) ??
        false;
  }

  /// Returns whether the options should be presented as an auto-complete control
  bool get isAutocomplete => qi.isItemControl('autocomplete');

  bool get isDropdown => qi.isItemControl('drop-down');

  bool get isRadioButton => qi.isItemControl('radio-button');

  bool get isCheckbox => qi.isItemControl('check-box');

  bool get isOptionsOrString => qi.type == QuestionnaireItemType.open_choice;

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
  }

  final int minOccurs;
  final int? maxOccurs;

  CodingAnswerModel(super.responseModel)
      : minOccurs = responseModel.questionnaireItem.extension_
                ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/questionnaire-minOccurs',
                )
                ?.valueInteger
                ?.value ??
            0,
        maxOccurs = responseModel.questionnaireItem.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-maxOccurs',
            )
            ?.valueInteger
            ?.value {
    _createAnswerOptions();
  }

  Iterable<RenderingString> toDisplay({bool includeMedia = true}) {
    final value = this.value;
    if (value == null) {
      return [RenderingString.nullText];
    }

    final renderingStrings =
        (value.selectedOptions?.map<RenderingString>((uid) {
                  final answerOption = answerOptionByUid(uid);

                  return includeMedia && answerOption.hasMedia
                      ? RenderingString.fromText(
                          answerOption.optionText.plainText,
                          xhtmlText: answerOption.itemMedia!.toXhtml(),
                        )
                      : answerOption.optionText;
                }) ??
                <RenderingString>[])
            .followedBy(
      value.openStrings?.map<RenderingString>(
            (openString) => RenderingString.fromText(openString),
          ) ??
          <RenderingString>[],
    );

    if (renderingStrings.isEmpty) {
      return [RenderingString.nullText];
    }

    return renderingStrings;
  }

  @override
  RenderingString get display {
    final value = this.value;
    if (value == null) {
      return RenderingString.nullText;
    }

    final renderingStrings = (value.selectedOptions?.map<RenderingString>(
              (uid) => answerOptionByUid(uid).optionText,
            ) ??
            <RenderingString>[])
        .followedBy(
      value.openStrings?.map<RenderingString>(
            (openString) => RenderingString.fromText(openString),
          ) ??
          <RenderingString>[],
    );

    if (renderingStrings.isEmpty) {
      return RenderingString.nullText;
    }

    // TODO: Localized or themed separator character?
    return renderingStrings.concatenateXhtml('; ');
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
  String? validateInput(OptionsOrString? inValue) {
    return validateValue(inValue);
  }

  @override
  String? validateValue(OptionsOrString? inValue) {
    if (inValue == null) {
      return null;
    }

    final selectedOptionsCount = inValue.selectedOptions?.length ?? 0;
    final openStringsCount = inValue.openStrings?.length ?? 0;

    final int totalCount = selectedOptionsCount + openStringsCount;

    if (!(questionnaireItemModel.questionnaireItem.repeats?.value ?? false)) {
      if (totalCount != 1) {
        return lookupFDashLocalizations(locale)
            .validatorSingleSelectionOrSingleOpenString(openLabel.plainText);
      }
    }

    if (totalCount < minOccurs) {
      return lookupFDashLocalizations(locale).validatorMinOccurs(minOccurs);
    }

    final maxOccurs = this.maxOccurs;
    if (maxOccurs != null && totalCount > maxOccurs) {
      return lookupFDashLocalizations(locale).validatorMaxOccurs(maxOccurs);
    }

    return null;
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
    final optionResponses =
        value?.selectedOptions?.map<QuestionnaireResponseAnswer>((uid) {
              final answerOption = answerOptionByUid(uid);
              final answerExtensions = <FhirExtension>[
                if (answerOption.hasMedia)
                  FhirExtension(
                    url: FhirUri(
                      'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemAnswerMedia',
                    ),
                    valueAttachment: answerOption.itemMedia?.attachment,
                  ),
              ];

              return QuestionnaireResponseAnswer(
                extension_:
                    (answerExtensions.isNotEmpty) ? answerExtensions : null,
                valueCoding: answerOption.createFhirCoding(),
                item: items,
              );
            }) ??
            <QuestionnaireResponseAnswer>[];

    // Add openStrings
    final openStringResponses = value?.openStrings?.map(
          (openString) => QuestionnaireResponseAnswer(
            valueString: openString,
            item: items,
          ),
        ) ??
        <QuestionnaireResponseAnswer>[];

    final allResponses = optionResponses.followedBy(openStringResponses);

    return allResponses.isNotEmpty
        ? allResponses.toList(growable: false)
        : null;
  }

  @override
  bool get hasCodingAnswers => true;

  @override
  bool get isEmpty => value == null;

  @override
  void populate(QuestionnaireResponseAnswer answer) {
    throw UnimplementedError('populate not implemented.');
  }

  void populateFromCodings(
    Iterable<Coding> codings,
    Iterable<String> openStrings,
  ) {
    final selectedOptions = <String>{};
    for (final coding in codings) {
      final matchCode = coding.code?.value ?? coding.display;

      final matchingOption = answerOptions
          .firstWhereOrNull((answerOption) => answerOption.matches(matchCode));

      if (matchingOption != null) {
        selectedOptions.add(matchingOption.uid);
      } else {
        _logger.warn(
          'initial.valueCoding $coding at ${responseItemModel.nodeUid} does not match any answer option.',
        );
      }
    }

    value =
        OptionsOrString.fromSelectionsAndStrings(selectedOptions, openStrings);
  }

  @override
  void populateCodingAnswers(List<QuestionnaireResponseAnswer>? answers) {
    if (answers == null) {
      // TODO: Should this rather result in an empty (value = null) answer?
      return;
    }

    final openStrings = <String>[];

    final selectedOptions = <String>{};
    for (final answer in answers) {
      final matchCode = answer.valueCoding?.code?.value ??
          answer.valueCoding?.display ??
          answer.valueString;

      final matchingOption = answerOptions
          .firstWhereOrNull((answerOption) => answerOption.matches(matchCode));

      if (matchingOption != null) {
        selectedOptions.add(matchingOption.uid);
      } else {
        final newOpenString = answer.valueCoding?.display ?? answer.valueString;
        if (newOpenString != null) {
          openStrings.add(newOpenString);
        }
      }
    }

    value =
        OptionsOrString.fromSelectionsAndStrings(selectedOptions, openStrings);
  }
}

/// DTO to hold selected options and/or open free-text strings.
///
/// Modeled according to the FHIR R5 answerConstraint of the same name.
class OptionsOrString {
  final Set<String>? selectedOptions;
  final Iterable<String>? openStrings;

  const OptionsOrString._(this.selectedOptions, this.openStrings);

  static OptionsOrString? fromSelectionsAndStrings(
    Set<String>? selectedOptions,
    Iterable<String>? openStrings,
  ) {
    if ((selectedOptions == null || selectedOptions.isEmpty) &&
        (openStrings == null || openStrings.isEmpty)) {
      return null;
    }

    return OptionsOrString._(
      (selectedOptions?.isEmpty ?? true) ? null : selectedOptions,
      (openStrings?.isEmpty ?? true) ? null : openStrings,
    );
  }

  @override
  String toString() {
    return 'Options: $selectedOptions, Open: $openStrings';
  }
}
