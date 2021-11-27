// This is a modified version of the "AutoComplete" class from the Flutter SDK.

// The original class is licensed as follows:

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// The referenced LICENSE file is located here: https://github.com/flutter/flutter/blob/master/LICENSE

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../model/item/answer/answer.dart';

/// {@macro flutter.widgets.RawAutocomplete.RawAutocomplete}
///
/// See also:
///
///  * [RawAutocomplete], which is what Autocomplete is built upon, and which
///    contains more detailed examples.
class FDashAutocomplete<T extends Object> extends StatefulWidget {
  /// Creates an instance of [FDashAutocomplete].
  const FDashAutocomplete({
    Key? key,
    this.focusNode,
    required this.optionsBuilder,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.onSelected,
    this.validator,
    this.answerModel,
    this.optionsViewBuilder,
    this.initialValue,
  }) : super(key: key);

  /// {@macro flutter.widgets.RawAutocomplete.displayStringForOption}
  final AutocompleteOptionToString<T> displayStringForOption;

  /// {@macro flutter.widgets.RawAutocomplete.fieldViewBuilder}
  ///

  /// {@macro flutter.widgets.RawAutocomplete.onSelected}
  final AutocompleteOnSelected<T>? onSelected;

  /// {@macro flutter.widgets.RawAutocomplete.optionsBuilder}
  final AutocompleteOptionsBuilder<T> optionsBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewBuilder}
  ///
  /// If not provided, will build a standard Material-style list of results by
  /// default.
  final AutocompleteOptionsViewBuilder<T>? optionsViewBuilder;

  final String? initialValue;

  final FocusNode? focusNode;

  final String? Function(String?)? validator;

  final AnswerModel? answerModel;

  @override
  State<StatefulWidget> createState() => FDashAutocompleteState<T>();
}

class FDashAutocompleteState<T extends Object>
    extends State<FDashAutocomplete<T>> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _defaultFieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return _AutocompleteField(
      initialValue: widget.initialValue,
      answerModel: widget.answerModel,
      focusNode: focusNode,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: (widget.onSelected != null)
          ? RawAutocomplete<T>(
              focusNode: widget.focusNode,
              textEditingController: _textEditingController,
              displayStringForOption: widget.displayStringForOption,
              fieldViewBuilder: _defaultFieldViewBuilder,
              optionsBuilder: widget.optionsBuilder,
              optionsViewBuilder: widget.optionsViewBuilder ??
                  (
                    BuildContext context,
                    AutocompleteOnSelected<T> onSelected,
                    Iterable<T> options,
                  ) {
                    return _AutocompleteOptions<T>(
                      displayStringForOption: widget.displayStringForOption,
                      onSelected: onSelected,
                      options: options,
                    );
                  },
              onSelected: widget.onSelected,
            )
          : TextFormField(
              focusNode: widget.focusNode,
              controller: _textEditingController,
              enabled: false,
            ),
    );
  }
}

// The default Material-style Autocomplete text field.
class _AutocompleteField extends StatefulWidget {
  const _AutocompleteField({
    Key? key,
    this.initialValue,
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
    this.answerModel,
    this.validator,
  }) : super(key: key);

  final FocusNode focusNode;

  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  final String? initialValue;

  final String? Function(String?)? validator;

  final AnswerModel? answerModel;

  @override
  State<StatefulWidget> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<_AutocompleteField> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        filled: true,
        errorText: widget.answerModel?.errorText,
        hintText: FDashLocalizations.of(context).autoCompleteSearchTermInput,
      ),
      onFieldSubmitted: (String value) {
        widget.onFieldSubmitted();
      },
      validator: widget.validator,
    );
  }
}

// The default Material-style Autocomplete options.
class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions({
    Key? key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
  }) : super(key: key);

  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: SizedBox(
          height: 200.0,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);

              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(displayStringForOption(option)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
