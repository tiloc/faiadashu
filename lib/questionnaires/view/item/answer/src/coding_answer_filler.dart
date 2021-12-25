import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Answer questions which require code(s) as a response.
///
/// R5 release of the FHIR standard will have a `coding` item type,
/// and model the "openness" in a separate extension.
class CodingAnswerFiller extends QuestionnaireAnswerFiller {
  CodingAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);
  @override
  State<StatefulWidget> createState() => _CodingAnswerState();
}

class _CodingAnswerState extends QuestionnaireAnswerFillerState<Set<String>,
    CodingAnswerFiller, CodingAnswerModel> {
  late final TextEditingController? _openTextController;

  _CodingAnswerState();

  @override
  void postInitState() {
    if (qi.type == QuestionnaireItemType.open_choice) {
      _openTextController = TextEditingController(text: answerModel.openText);
    }
  }

  @override
  Widget buildInputControl(BuildContext context) {
    try {
      // Only checkbox choices currently support repeating answers.
      if (qi.repeats?.value ?? false) {
        return _buildChoiceAnswers(context);
      }

      final isSmartAutoComplete = answerModel.numberOfOptions >
          questionnaireTheme.autoCompleteThreshold;

      // Large numbers of responses require auto-complete control
      if (answerModel.isAutocomplete || isSmartAutoComplete) {
        return _buildAutocompleteAnswers(context);
      }

      if (answerModel.isCheckbox || answerModel.isRadioButton) {
        return _buildChoiceAnswers(context);
      }

      // Explicitly specified drop-down
      if (answerModel.isDropdown) {
        return _buildDropdownAnswers(context);
      }

      // No explicitly specified control, let the theme decide.
      switch (questionnaireTheme.codingControlPreference) {
        case CodingControlPreference.compact:
          return _buildDropdownAnswers(context);
        case CodingControlPreference.expanded:
          return _buildChoiceAnswers(context);
      }
    } catch (exception) {
      return BrokenQuestionnaireItem.fromException(exception);
    }
  }

  Widget _buildDropdownAnswers(BuildContext context) {
    return _CodingDropdown(
      questionnaireTheme: questionnaireTheme,
      firstFocusNode: firstFocusNode,
      locale: locale,
      answerModel: answerModel,
      errorText: answerModel.displayErrorText,
      onChanged: (uid) {
        answerModel.value = answerModel.selectOption(uid);
      },
    );
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final choices = _createChoices(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return answerModel.isHorizontal &&
                constraints.maxWidth >
                    questionnaireTheme.horizontalCodingBreakpoint
            ? _HorizontalCodingChoices(
                firstFocusNode: firstFocusNode,
                choices: choices,
                errorText: answerModel.displayErrorText,
              )
            : _VerticalCodingChoices(
                firstFocusNode: firstFocusNode,
                answerModel: answerModel,
                errorText: answerModel.displayErrorText,
                choices: choices,
              );
      },
    );
  }

  Widget _buildAutocompleteAnswers(BuildContext context) {
    return FDashAutocomplete<CodingAnswerOptionModel>(
      focusNode: firstFocusNode,
      answerModel: answerModel,
      initialValue: answerModel.singleSelection?.optionText.plainText,
      displayStringForOption: (answerOption) =>
          answerOption.optionText.plainText,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<CodingAnswerOptionModel>.empty();
        }

        return answerModel.answerOptions
            .where((CodingAnswerOptionModel option) {
          return option.optionText.plainText
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (answerModel.isEnabled)
          ? (CodingAnswerOptionModel selectedOption) {
              answerModel.value = answerModel.selectOption(selectedOption.uid);
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
            groupValue: answerModel.singleSelectionUid,
            onChanged: (answerModel.isEnabled)
                ? (String? newValue) {
                    answerModel.value = answerModel.selectOption(newValue);
                  }
                : null,
          ),
        );
      }
    }
    for (final answerOption in answerModel.answerOptions) {
      final styledOptionTitle =
          _createStyledOption(context, answerModel, answerOption);

      if (answerOption.uid == CodingAnswerOptionModel.openChoiceCode) {
        continue;
      }

      choices.add(
        isMultipleChoice
            ? answerOption.isExclusive
                ? Focus(
                    child: RadioListTile<String>(
                      title: styledOptionTitle,
                      groupValue: answerModel.exclusiveSelectionUid,
                      value: answerOption.uid,
                      onChanged: (answerModel.isEnabled)
                          ? (_) {
                              Focus.of(context).requestFocus();
                              final newValue = answerModel.toggleOption(
                                answerOption.uid,
                              );
                              answerModel.value = newValue;
                            }
                          : null,
                    ),
                  )
                : Focus(
                    child: CheckboxListTile(
                      title: styledOptionTitle,
                      value: answerModel.isSelected(answerOption.uid),
                      onChanged: (answerModel.isEnabled)
                          ? (bool? newValue) {
                              Focus.of(context).requestFocus();
                              final newValue = answerModel.toggleOption(
                                answerOption.uid,
                              );
                              answerModel.value = newValue;
                            }
                          : null,
                    ),
                  )
            : Focus(
                child: RadioListTile<String>(
                  title: styledOptionTitle,
                  value: answerOption.uid,
                  // allows value to be set to null on repeat tap
                  toggleable: true,
                  groupValue: answerModel.singleSelectionUid,
                  onChanged: (answerModel.isEnabled)
                      ? (String? newValue) {
                          Focus.of(context).requestFocus();
                          answerModel.value =
                              answerModel.selectOption(newValue);
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
            value: CodingAnswerOptionModel.openChoiceCode,
            groupValue: (answerModel.value
                        ?.contains(CodingAnswerOptionModel.openChoiceCode) ??
                    false)
                ? CodingAnswerOptionModel.openChoiceCode
                : null,
            onChanged: (answerModel.isEnabled)
                ? (String? newValue) {
                    Focus.of(context).requestFocus();
                    answerModel.value = answerModel
                        .selectOption(CodingAnswerOptionModel.openChoiceCode);
                  }
                : null,
            title: TextFormField(
              controller: _openTextController,
              enabled: answerModel.isEnabled,
              onChanged: (newText) {
                answerModel.openText = newText;
                answerModel.value = answerModel
                    .selectOption(CodingAnswerOptionModel.openChoiceCode);
              },
            ),
            secondary: Xhtml.fromXhtmlString(
              context,
              answerModel.openLabel,
            ),
          ),
        ),
      );
    }

    return choices;
  }
}

Widget _createStyledOption(
  BuildContext context,
  CodingAnswerModel answerModel,
  CodingAnswerOptionModel optionModel,
) {
  if (optionModel.hasMedia) {
    final mediaWidget = ItemMediaImage.fromAnswerOption(
      optionModel,
      key: ValueKey<String>(
        '${answerModel.nodeUid}-option-${optionModel.optionText.plainText}-media',
      ),
    );
    if (mediaWidget != null) {
      return mediaWidget;
    }
    // continue if widget generation failed for any reason...
  }

  final optionPrefix = optionModel.optionPrefix;
  final optionText = optionModel.optionText;

  final optionTitle = <RenderingString>[
    if (optionPrefix != null) optionPrefix,
    optionText,
  ].concatenateXhtml(' ', '&nbsp;');
  final styledOptionTitle = Xhtml.fromXhtmlString(
    context,
    optionTitle,
    questionnaireModel:
        answerModel.responseItemModel.questionnaireItemModel.questionnaireModel,
    imageWidth: 100,
    imageHeight: 100,
    key: ValueKey<String>(
      '${answerModel.nodeUid}-option-${optionModel.optionText.plainText}-title',
    ),
  );

  return styledOptionTitle;
}

class _CodingDropdown extends StatelessWidget {
  const _CodingDropdown({
    Key? key,
    required this.firstFocusNode,
    required this.questionnaireTheme,
    required this.locale,
    required this.answerModel,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final FocusNode firstFocusNode;
  final QuestionnaireTheme questionnaireTheme;
  final Locale locale;
  final CodingAnswerModel answerModel;
  final String? errorText;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    final dropdownItems = [
      if (questionnaireTheme.showNullAnswerOption)
        const DropdownMenuItem<String>(
          child: NullDashText(),
        ),
      ...answerModel.answerOptions
          .map<DropdownMenuItem<String>>((answerOption) {
        return DropdownMenuItem<String>(
          value: answerOption.uid,
          child: _createStyledOption(context, answerModel, answerOption),
        );
      }),
    ];

    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: answerModel.singleSelectionUid,
      onTap: () {
        firstFocusNode.requestFocus();
      },
      onChanged: answerModel.isEnabled ? onChanged : null,
      focusNode: firstFocusNode,
      items: dropdownItems,
      decoration: InputDecoration(errorText: answerModel.displayErrorText),
    );
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
    final errorText = this.errorText;

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
            errorText,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Theme.of(context).errorColor),
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
