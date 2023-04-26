import 'package:faiadashu/faiadashu.dart';
import 'package:flutter/material.dart';

/// Answer questions which require code(s) as a response.
class CodingAnswerFiller extends QuestionnaireAnswerFiller {
  CodingAnswerFiller(
    super.answerModel, {
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _CodingAnswerState();
}

class _CodingAnswerState extends QuestionnaireAnswerFillerState<OptionsOrString,
    CodingAnswerFiller, CodingAnswerModel> {
  _CodingAnswerState();

  @override
  Widget createInputControl() {
    return _CodingInputControl(
      answerModel,
      focusNode: firstFocusNode,
    );
  }

  @override
  // ignore: no-empty-block
  void postInitState() {
    // Intentionally do nothing
  }
}

class _CodingInputControl extends AnswerInputControl<CodingAnswerModel> {
  const _CodingInputControl(
    CodingAnswerModel answerModel, {
    Key? key,
    FocusNode? focusNode,
  }) : super(
          answerModel,
          key: key,
          focusNode: focusNode,
        );

  @override
  Widget build(BuildContext context) {
    final errorText = answerModel.displayErrorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCodingControl(context),
        if (answerModel.isOptionsOrString) _OpenStringInputControl(answerModel),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
          child: Text(
            errorText ?? '',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }

  Widget _buildCodingControl(BuildContext context) {
    // Only checkbox choices currently support repeating answers.
    if (qi.repeats?.value ?? false) {
      return _createChoiceAnswers();
    }

    final questionnaireTheme = QuestionnaireTheme.of(context);

    final isSmartAutoComplete =
        answerModel.numberOfOptions > questionnaireTheme.autoCompleteThreshold;

    // Large numbers of responses require auto-complete control
    if (answerModel.isAutocomplete || isSmartAutoComplete) {
      return _CodingAutoComplete(
        answerModel,
        focusNode: focusNode,
      );
    }

    if (answerModel.isCheckbox || answerModel.isRadioButton) {
      return _createChoiceAnswers();
    }

    // Explicitly specified drop-down
    if (answerModel.isDropdown) {
      return _createDropdownAnswers();
    }

    // No explicitly specified control, let the theme decide.
    switch (questionnaireTheme.codingControlPreference) {
      case CodingControlPreference.compact:
        return _createDropdownAnswers();
      case CodingControlPreference.expanded:
        return _createChoiceAnswers();
    }
  }

  Widget _createDropdownAnswers() {
    return _CodingDropdown(
      answerModel,
      focusNode: focusNode,
    );
  }

  Widget _createChoiceAnswers() {
    return _CodingChoices(
      answerModel,
      focusNode: focusNode,
    );
  }
}

class _StyledOption extends StatefulWidget {
  final CodingAnswerModel answerModel;
  final CodingAnswerOptionModel optionModel;

  const _StyledOption(
    this.answerModel,
    this.optionModel, {
    super.key,
  });

  @override
  _StyledOptionState createState() => _StyledOptionState();
}

class _StyledOptionState extends State<_StyledOption> {
  late Widget _cachedChild;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cachedChild = _createStyledOption(context);
  }

  Widget _createStyledOption(
    BuildContext context,
  ) {
    final optionModel = widget.optionModel;
    final answerModel = widget.answerModel;

    if (optionModel.hasMedia) {
      final mediaWidget = ItemMediaImage.fromItemMedia(
        optionModel.itemMedia,
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
      questionnaireModel: answerModel
          .responseItemModel.questionnaireItemModel.questionnaireModel,
      imageWidth: 100,
      imageHeight: 100,
      key: ValueKey<String>(
        '${answerModel.nodeUid}-option-${optionModel.optionText.plainText}-title',
      ),
    );

    return styledOptionTitle;
  }

  @override
  Widget build(BuildContext context) {
    return _cachedChild;
  }
}

class _CheckboxChoice extends StatelessWidget {
  final CodingAnswerOptionModel answerOption;
  final CodingAnswerModel answerModel;

  const _CheckboxChoice(this.answerModel, this.answerOption, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: CheckboxListTile(
        title: _StyledOption(
          answerModel,
          answerOption,
        ),
        subtitle: answerOption.isExclusive
            ? Text(FDashLocalizations.of(context).fillerExclusiveOptionLabel)
            : null,
        value: answerModel.isSelected(answerOption.uid),
        onChanged: (answerModel.isControlEnabled)
            ? (bool? newValue) {
                Focus.of(context).requestFocus();
                final newValue = answerModel.toggleOption(
                  answerOption.uid,
                );
                answerModel.value = OptionsOrString.fromSelectionsAndStrings(
                  newValue,
                  answerModel.value?.openStrings,
                );
              }
            : null,
      ),
    );
  }
}

class _NullRadioChoice extends StatelessWidget {
  final CodingAnswerModel answerModel;

  const _NullRadioChoice(this.answerModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String?>(
      title: const NullDashText(),
      value: null,
      groupValue: answerModel.singleSelectionUid,
      onChanged: (answerModel.isControlEnabled)
          ? (String? newValue) {
              answerModel.value = OptionsOrString.fromSelectionsAndStrings(
                answerModel.selectOption(newValue),
                answerModel.value?.openStrings,
              );
            }
          : null,
    );
  }
}

class _RadioChoice extends StatelessWidget {
  final CodingAnswerOptionModel answerOption;
  final CodingAnswerModel answerModel;

  const _RadioChoice(this.answerModel, this.answerOption, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: RadioListTile<String>(
        title: _StyledOption(
          answerModel,
          answerOption,
        ),
        value: answerOption.uid,
        // allows value to be set to null on repeat tap
        toggleable: true,
        groupValue: answerModel.singleSelectionUid,
        onChanged: (answerModel.isControlEnabled)
            ? (String? newValue) {
                Focus.of(context).requestFocus();
                answerModel.value = OptionsOrString.fromSelectionsAndStrings(
                  answerModel.selectOption(newValue),
                  answerModel.value?.openStrings,
                );
              }
            : null,
      ),
    );
  }
}

class _CodingDropdown extends AnswerInputControl<CodingAnswerModel> {
  const _CodingDropdown(
    CodingAnswerModel answerModel, {
    Key? key,
    FocusNode? focusNode,
  }) : super(
          answerModel,
          key: key,
          focusNode: focusNode,
        );

  @override
  Widget build(BuildContext context) {
    final dropdownItems = [
      if (answerModel.hasNullOption)
        const DropdownMenuItem<String>(
          child: NullDashText(),
        ),
      ...answerModel.answerOptions
          .map<DropdownMenuItem<String>>((answerOption) {
        return DropdownMenuItem<String>(
          value: answerOption.uid,
          child: _StyledOption(answerModel, answerOption),
        );
      }),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: answerModel.singleSelectionUid,
        onTap: () {
          focusNode?.requestFocus();
        },
        onChanged: answerModel.isControlEnabled
            ? (uid) {
                answerModel.value = OptionsOrString.fromSelectionsAndStrings(
                  answerModel.selectOption(uid),
                  answerModel.value?.openStrings,
                );
              }
            : null,
        focusNode: focusNode,
        items: dropdownItems,
        decoration: InputDecoration(
          // Empty error texts triggers red border, but showing text would result in a duplicate.
          errorStyle:
              const TextStyle(height: 0, color: Color.fromARGB(0, 0, 0, 0)),
          errorText: answerModel.displayErrorText,
        ),
      ),
    );
  }
}

class _VerticalCodingChoices extends AnswerInputControl<CodingAnswerModel> {
  const _VerticalCodingChoices(
    CodingAnswerModel answerModel,
    this.choices, {
    Key? key,
    FocusNode? focusNode,
  }) : super(
          answerModel,
          key: key,
          focusNode: focusNode,
        );

  final List<Widget> choices;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CodingChoiceDecorator(
          answerModel,
          focusNode: focusNode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: choices,
          ),
        ),
      ],
    );
  }
}

class _CodingChoices extends AnswerInputControl<CodingAnswerModel> {
  late final List<Widget> _choices;

  _CodingChoices(
    CodingAnswerModel answerModel, {
    Key? key,
    FocusNode? focusNode,
  }) : super(
          answerModel,
          focusNode: focusNode,
          key: key,
        ) {
    _choices = _createChoices();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        return answerModel.isHorizontal &&
                constraints.maxWidth >
                    QuestionnaireTheme.of(context).horizontalCodingBreakpoint
            ? _HorizontalCodingChoices(
                answerModel,
                _choices,
                focusNode: focusNode,
              )
            : _VerticalCodingChoices(
                answerModel,
                _choices,
                focusNode: focusNode,
              );
      },
    );
  }

  List<Widget> _createChoices() {
    final isCheckBox = qi.isItemControl('check-box');
    final isMultipleChoice = qi.repeats?.value ?? isCheckBox;
    final isShowingNull = answerModel.hasNullOption;

    final choices = <Widget>[];

    if (!isMultipleChoice) {
      if (isShowingNull) {
        choices.add(
          _NullRadioChoice(answerModel),
        );
      }
    }
    for (final answerOption in answerModel.answerOptions) {
      choices.add(
        isMultipleChoice
            ? _CheckboxChoice(answerModel, answerOption)
            : _RadioChoice(answerModel, answerOption),
      );
    }

    return choices;
  }
}

class _HorizontalCodingChoices extends AnswerInputControl<CodingAnswerModel> {
  const _HorizontalCodingChoices(
    CodingAnswerModel answerModel,
    this.choices, {
    Key? key,
    FocusNode? focusNode,
  }) : super(
          answerModel,
          focusNode: focusNode,
          key: key,
        );

  final List<Widget> choices;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CodingChoiceDecorator(
          answerModel,
          focusNode: focusNode,
          child: Row(
            children: choices.map<Widget>(
              (choice) {
                return choice is _NullRadioChoice
                    ? SizedBox(width: 96, child: choice)
                    : Expanded(child: choice);
              },
            ).toList(growable: false),
          ),
        ),
      ],
    );
  }
}

class _CodingChoiceDecorator extends StatelessWidget {
  final AnswerModel answerModel;
  final FocusNode? focusNode;
  final Widget? child;

  const _CodingChoiceDecorator(
    this.answerModel, {
    this.focusNode,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      child: AnimatedBuilder(
        animation: Focus.of(context),
        builder: (context, child) {
          final hasError = answerModel.displayErrorText != null;
          final decoTheme = Theme.of(context).inputDecorationTheme;

          // TODO: Return something borderless when filled = true
          return Card(
            shape: Focus.of(context).hasFocus
                ? hasError
                    ? decoTheme.focusedErrorBorder
                    : decoTheme.focusedBorder
                : hasError
                    ? decoTheme.errorBorder
                    : answerModel.isControlEnabled
                        ? decoTheme.enabledBorder
                        : decoTheme.disabledBorder,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class _CodingAutoComplete extends AnswerInputControl<CodingAnswerModel> {
  const _CodingAutoComplete(
    CodingAnswerModel answerModel, {
    Key? key,
    FocusNode? focusNode,
  }) : super(
          answerModel,
          key: key,
          focusNode: focusNode,
        );

  Widget _fieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return _FDashAutocompleteField(
      answerModel: answerModel,
      focusNode: focusNode,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      focusNode: focusNode,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Autocomplete<CodingAnswerOptionModel>(
          fieldViewBuilder: _fieldViewBuilder,
          initialValue: TextEditingValue(
            text: answerModel.singleSelection?.optionText.plainText ?? '',
          ),
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
        ),
      ),
    );
  }
}

/// Input field for a single open string.
class _OpenStringInputControl extends StatefulWidget {
  final CodingAnswerModel answerModel;

  const _OpenStringInputControl(this.answerModel, {Key? key}) : super(key: key);

  @override
  _OpenStringInputControlState createState() => _OpenStringInputControlState();
}

class _OpenStringInputControlState extends State<_OpenStringInputControl> {
  final TextEditingController _openStringController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _openStringController.text =
        widget.answerModel.value?.openStrings?.first ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final answerModel = widget.answerModel;

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

class _FDashAutocompleteField extends StatelessWidget {
  const _FDashAutocompleteField({
    Key? key,
    required this.answerModel,
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final AnswerModel answerModel;

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        onFieldSubmitted();
      },
      decoration: InputDecoration(
        errorText: answerModel.displayErrorText,
        hintText: FDashLocalizations.of(context).autoCompleteSearchTermInput,
      ),
    );
  }
}
