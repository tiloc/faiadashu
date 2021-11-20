import 'package:collection/collection.dart';
import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../../fhir_types/fhir_types.dart';
import '../../../../questionnaires.dart';

/// Answer questions which require code(s) as a response.
///
/// This class uses [CodeableConcept] to model multiple choice and open choice.
///
/// R5 release of the FHIR standard will have a `coding` item type.
class CodingAnswerFiller extends QuestionnaireAnswerFiller {
  CodingAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);
  @override
  State<StatefulWidget> createState() => _CodingAnswerState();
}

class _CodingAnswerState extends QuestionnaireAnswerFillerState<CodeableConcept,
    CodingAnswerFiller, CodingAnswerModel> {
  late final TextEditingController? _otherChoiceController;

  String? _errorText;

  String? get errorText => _errorText ?? answerModel.errorText;

  _CodingAnswerState();

  @override
  void postInitState() {
    if (qi.type == QuestionnaireItemType.open_choice) {
      // TODO: Set initialValue
      _otherChoiceController = TextEditingController();
    }

    _errorText = answerModel.validateInput(value);
  }

  @override
  Widget buildInputControl(BuildContext context) {
    try {
      return answerModel.isAutocomplete ||
              answerModel.answerOptions.length >
                  questionnaireTheme.autoCompleteThreshold
          ? _buildAutocompleteAnswers(context)
          : _buildChoiceAnswers(context);
    } catch (exception) {
      return BrokenQuestionnaireItem.fromException(exception);
    }
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final choices = _createChoices(context);

    return answerModel.isHorizontal &&
            MediaQuery.of(context).size.width >
                questionnaireTheme.horizontalCodingBreakpoint
        ? _HorizontalCodingChoices(
            firstFocusNode: firstFocusNode,
            choices: choices,
            errorText: errorText,
          )
        : _VerticalCodingChoices(
            firstFocusNode: firstFocusNode,
            answerModel: answerModel,
            errorText: errorText,
            choices: choices,
          );
  }

  Widget _buildAutocompleteAnswers(BuildContext context) {
    return FDashAutocomplete<QuestionnaireAnswerOption>(
      focusNode: firstFocusNode,
      initialValue: value?.localizedDisplay(locale),
      displayStringForOption: (answerOption) =>
          answerOption.localizedDisplay(locale),
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<QuestionnaireAnswerOption>.empty();
        }

        return answerModel.answerOptions.values
            .where((QuestionnaireAnswerOption option) {
          return option
              .localizedDisplay(locale)
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (answerModel.isEnabled)
          ? (QuestionnaireAnswerOption selectedOption) {
              value = answerModel.fromChoiceString(selectedOption.optionCode);
            }
          : null,
    );
  }

  List<Widget> _createChoices(BuildContext context) {
    final isCheckBox = qi.isItemControl('check-box');
    final isMultipleChoice = qi.repeats?.value ?? isCheckBox;
    final isShowingNull = questionnaireTheme.showNullAnswerOption;

    final choices = <Widget>[];

    if (!isMultipleChoice) {
      if (isShowingNull) {
        choices.add(
          RadioListTile<String?>(
            title: const NullDashText(),
            value: null,
            groupValue: answerModel.toChoiceString(value),
            onChanged: (answerModel.isEnabled)
                ? (String? newValue) {
                    value = answerModel.fromChoiceString(newValue);
                  }
                : null,
          ),
        );
      }
    }
    for (final choice in answerModel.answerOptions.values) {
      final optionPrefix = choice.extension_
          ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix',
          )
          ?.valueString;
      final optionPrefixDisplay =
          (optionPrefix != null) ? '$optionPrefix ' : '';
      final optionTitle =
          '$optionPrefixDisplay${choice.localizedDisplay(locale)}';
      final styledOptionTitle = Xhtml.toWidget(
        context,
        answerModel.responseItemModel.questionnaireItemModel.questionnaireModel,
        optionTitle,
        choice.valueStringElement?.extension_,
        width: 100,
        height: 100,
      );

      choices.add(
        isMultipleChoice
            ? answerModel.isExclusive(choice.valueCoding!)
                ? Focus(
                    child: RadioListTile<String>(
                      title: styledOptionTitle,
                      groupValue: choice.optionCode,
                      value: value?.coding
                              ?.firstWhereOrNull(
                                (coding) =>
                                    coding.code?.value == choice.optionCode,
                              )
                              ?.code
                              ?.value ??
                          '',
                      onChanged: (answerModel.isEnabled)
                          ? (_) {
                              Focus.of(context).requestFocus();
                              final newValue = answerModel.toggleValue(
                                value,
                                choice.optionCode,
                              );
                              _errorText = answerModel.validateInput(newValue);
                              value = newValue;
                            }
                          : null,
                    ),
                  )
                : Focus(
                    child: CheckboxListTile(
                      title: styledOptionTitle,
                      value: value?.coding?.firstWhereOrNull(
                            (coding) => coding.code?.value == choice.optionCode,
                          ) !=
                          null,
                      onChanged: (answerModel.isEnabled)
                          ? (bool? newValue) {
                              Focus.of(context).requestFocus();
                              final newValue = answerModel.toggleValue(
                                value,
                                choice.optionCode,
                              );
                              _errorText = answerModel.validateInput(newValue);
                              value = newValue;
                            }
                          : null,
                    ),
                  )
            : Focus(
                child: RadioListTile<String>(
                  title: styledOptionTitle,
                  value: choice.optionCode,
                  // allows value to be set to null on repeat tap
                  toggleable: true,
                  groupValue: answerModel.toChoiceString(value),
                  onChanged: (answerModel.isEnabled)
                      ? (String? newValue) {
                          Focus.of(context).requestFocus();
                          value = answerModel.fromChoiceString(newValue);
                        }
                      : null,
                ),
              ),
      );
    }

    if (qi.type == QuestionnaireItemType.open_choice) {
      choices.add(
        Focus(
          child: RadioListTile<String>(
            value: CodingAnswerModel.openChoiceOther,
            groupValue: answerModel.toChoiceString(value),
            onChanged: (answerModel.isEnabled)
                ? (String? newValue) {
                    Focus.of(context).requestFocus();
                    value = CodeableConcept(
                      coding: [
                        Coding(code: Code(CodingAnswerModel.openChoiceOther)),
                      ],
                      text: _otherChoiceController!.text,
                    );
                  }
                : null,
            title: TextFormField(
              controller: _otherChoiceController,
              enabled: answerModel.isEnabled,
              onChanged: (newText) {
                value = (newText.isEmpty)
                    ? null
                    : CodeableConcept(
                        coding: [
                          Coding(code: Code(CodingAnswerModel.openChoiceOther)),
                        ],
                        text: _otherChoiceController!.text,
                      );
              },
            ),
            secondary:
                Text(FDashLocalizations.of(context).fillerOpenCodingOtherLabel),
          ),
        ),
      );
    }

    return choices;
  }
}

class _VerticalCodingChoices extends StatelessWidget {
  const _VerticalCodingChoices({
    Key? key,
    required this.firstFocusNode,
    required this.answerModel,
    required this.errorText,
    required this.choices,
  }) : super(key: key);

  final FocusNode firstFocusNode;
  final CodingAnswerModel answerModel;
  final String? errorText;
  final List<Widget> choices;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          focusNode: firstFocusNode,
          child: Card(
            shape: (firstFocusNode.hasFocus && answerModel.isEnabled)
                ? RoundedRectangleBorder(
                    side: BorderSide(
                      color: (errorText == null)
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.error,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  )
                : null,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: choices,
            ),
          ),
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).errorColor),
          ),
      ],
    );
  }
}

class _HorizontalCodingChoices extends StatelessWidget {
  const _HorizontalCodingChoices({
    Key? key,
    required this.firstFocusNode,
    required this.choices,
    required this.errorText,
  }) : super(key: key);

  final FocusNode firstFocusNode;
  final List<Widget> choices;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          focusNode: firstFocusNode,
          child: Card(
            shape: (firstFocusNode.hasFocus)
                ? RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  )
                : null,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Table(children: [TableRow(children: choices)]),
          ),
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).errorColor),
          ),
      ],
    );
  }
}
