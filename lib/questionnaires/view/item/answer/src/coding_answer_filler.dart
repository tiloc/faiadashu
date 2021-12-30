import 'package:faiadashu/faiadashu.dart';
import 'package:flutter/material.dart';

/// Answer questions which require code(s) as a response.
class CodingAnswerFiller extends QuestionnaireAnswerFiller {
  CodingAnswerFiller(
    QuestionResponseItemFillerState responseFillerState,
    AnswerModel answerModel, {
    Key? key,
  }) : super(responseFillerState, answerModel, key: key);
  @override
  State<StatefulWidget> createState() => _CodingAnswerState();
}

class _CodingAnswerState extends QuestionnaireAnswerFillerState<OptionsOrString,
    CodingAnswerFiller, CodingAnswerModel> {
  late final TextEditingController? _openStringController;

  _CodingAnswerState();

  @override
  void postInitState() {
    if (answerModel.isOptionsOrString) {
      // TODO: Add support for multiple open strings.
      final openStrings = answerModel.value?.openStrings;
      final initialOpenString = openStrings != null ? openStrings.first : '';
      _openStringController = TextEditingController(text: initialOpenString);
    }
  }

  @override
  Widget buildInputControl(BuildContext context) {
    final errorText = answerModel.displayErrorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCodingControl(context),
        if (answerModel.isOptionsOrString) _buildOpenStringsControl(context),
        if (errorText != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
            child: Text(
              errorText,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Theme.of(context).errorColor),
            ),
          ),
      ],
    );
  }

  Widget _buildCodingControl(BuildContext context) {
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
        answerModel.value = OptionsOrString.fromSelectionsAndStrings(
          answerModel.selectOption(uid),
          answerModel.value?.openStrings,
        );
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
                answerModel: answerModel,
                choices: choices,
              )
            : _VerticalCodingChoices(
                firstFocusNode: firstFocusNode,
                answerModel: answerModel,
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
      onSelected: (answerModel.isControlEnabled)
          ? (CodingAnswerOptionModel selectedOption) {
              answerModel.value = OptionsOrString.fromSelectionsAndStrings(
                answerModel.selectOption(selectedOption.uid),
                answerModel.value?.openStrings,
              );
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
            onChanged: (answerModel.isControlEnabled)
                ? (String? newValue) {
                    answerModel.value =
                        OptionsOrString.fromSelectionsAndStrings(
                      answerModel.selectOption(newValue),
                      answerModel.value?.openStrings,
                    );
                  }
                : null,
          ),
        );
      }
    }
    for (final answerOption in answerModel.answerOptions) {
      final styledOptionTitle =
          _createStyledOption(context, answerModel, answerOption);

      choices.add(
        isMultipleChoice
            ? answerOption.isExclusive
                ? Focus(
                    child: RadioListTile<String>(
                      title: styledOptionTitle,
                      groupValue: answerModel.exclusiveSelectionUid,
                      value: answerOption.uid,
                      onChanged: (answerModel.isControlEnabled)
                          ? (_) {
                              Focus.of(context).requestFocus();
                              final newValue = answerModel.toggleOption(
                                answerOption.uid,
                              );
                              answerModel.value =
                                  OptionsOrString.fromSelectionsAndStrings(
                                newValue,
                                answerModel.value?.openStrings,
                              );
                            }
                          : null,
                    ),
                  )
                : Focus(
                    child: CheckboxListTile(
                      title: styledOptionTitle,
                      value: answerModel.isSelected(answerOption.uid),
                      onChanged: (answerModel.isControlEnabled)
                          ? (bool? newValue) {
                              Focus.of(context).requestFocus();
                              final newValue = answerModel.toggleOption(
                                answerOption.uid,
                              );
                              answerModel.value =
                                  OptionsOrString.fromSelectionsAndStrings(
                                newValue,
                                answerModel.value?.openStrings,
                              );
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
                  onChanged: (answerModel.isControlEnabled)
                      ? (String? newValue) {
                          Focus.of(context).requestFocus();
                          answerModel.value =
                              OptionsOrString.fromSelectionsAndStrings(
                            answerModel.selectOption(newValue),
                            answerModel.value?.openStrings,
                          );
                        }
                      : null,
                ),
              ),
      );
    }

    return choices;
  }

  Widget _buildOpenStringsControl(BuildContext context) {
    return Row(
      children: [
        Xhtml.fromRenderingString(
          context,
          answerModel.openLabel,
          defaultTextStyle: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: TextFormField(
            controller: _openStringController,
            enabled: answerModel.isControlEnabled,
            onChanged: (newText) {
              answerModel.value = OptionsOrString.fromSelectionsAndStrings(
                answerModel.value?.selectedOptions,
                newText.isNotEmpty ? [newText] : null,
              );
            },
            decoration: InputDecoration(
              // Empty error texts triggers red border, but showing text would result in a duplicate.
              errorStyle:
                  const TextStyle(height: 0, color: Color.fromARGB(0, 0, 0, 0)),

              errorText: answerModel.displayErrorText,
            ),
          ),
        ),
      ],
    );
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
  final styledOptionTitle = Xhtml.fromRenderingString(
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
      onChanged: answerModel.isControlEnabled ? onChanged : null,
      focusNode: firstFocusNode,
      items: dropdownItems,
      decoration: InputDecoration(
        // Empty error texts triggers red border, but showing text would result in a duplicate.
        errorStyle:
            const TextStyle(height: 0, color: Color.fromARGB(0, 0, 0, 0)),
        errorText: answerModel.displayErrorText,
      ),
    );
  }
}

class _VerticalCodingChoices extends StatelessWidget {
  const _VerticalCodingChoices({
    Key? key,
    required this.firstFocusNode,
    required this.answerModel,
    required this.choices,
  }) : super(key: key);

  final FocusNode firstFocusNode;
  final CodingAnswerModel answerModel;
  final List<Widget> choices;

  @override
  Widget build(BuildContext context) {
    final hasError = answerModel.displayErrorText != null;
    final decoTheme = Theme.of(context).inputDecorationTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          focusNode: firstFocusNode,
          child: Card(
            shape: (firstFocusNode.hasFocus)
                ? hasError
                    ? decoTheme.focusedErrorBorder
                    : decoTheme.focusedBorder
                : hasError
                    ? decoTheme.errorBorder
                    : answerModel.isControlEnabled
                        ? decoTheme.enabledBorder
                        : decoTheme.disabledBorder,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: choices,
            ),
          ),
        ),
      ],
    );
  }
}

class _HorizontalCodingChoices extends StatelessWidget {
  const _HorizontalCodingChoices({
    Key? key,
    required this.firstFocusNode,
    required this.answerModel,
    required this.choices,
  }) : super(key: key);

  final FocusNode firstFocusNode;
  final CodingAnswerModel answerModel;
  final List<Widget> choices;

  @override
  Widget build(BuildContext context) {
    final hasError = answerModel.displayErrorText != null;

    final decoTheme = Theme.of(context).inputDecorationTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          focusNode: firstFocusNode,
          child: Card(
            shape: (firstFocusNode.hasFocus)
                ? hasError
                    ? decoTheme.focusedErrorBorder
                    : decoTheme.focusedBorder
                : hasError
                    ? decoTheme.errorBorder
                    : answerModel.isControlEnabled
                        ? decoTheme.enabledBorder
                        : decoTheme.disabledBorder,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Table(children: [TableRow(children: choices)]),
          ),
        ),
      ],
    );
  }
}
