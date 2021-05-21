import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../questionnaires/model/questionnaire_extensions.dart';
import '../../../model/item/answer/coding_answer_model.dart';
import '../../../questionnaires.dart';
import '../../broken_questionnaire_item.dart';
import '../../xhtml.dart';
import 'null_dash_text.dart';

/// Answer questions which require code(s) as a response.
///
/// This class uses [CodeableConcept] to model multiple choice and open choice.
///
/// Future R5 releases of the FHIR standard will likely have a `coding` item type.
class CodingAnswerFiller extends QuestionnaireAnswerFiller {
  CodingAnswerFiller(
      QuestionnaireResponseFillerState responseFillerState, int answerIndex,
      {Key? key})
      : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _CodingAnswerState();
}

class _CodingAnswerState extends QuestionnaireAnswerState<CodeableConcept,
    CodingAnswerFiller, CodingAnswerModel> {
  late final TextEditingController? _otherChoiceController;

  String? _validationText;

  _CodingAnswerState();

  @override
  void postInitState() {
    if (qi.type == QuestionnaireItemType.open_choice) {
      // TODO: Set initialValue
      _otherChoiceController = TextEditingController();
    }

    _validationText = answerModel.validate(value);
  }

  @override
  Widget buildEditable(BuildContext context) {
    try {
      if (!(qi.repeats == Boolean(true)) &&
          (answerModel.answerOptions.length > 10 ||
              qi.isItemControl('autocomplete'))) {
        return _buildLookupAnswers(context);
      } else {
        return _buildChoiceAnswers(context);
      }
    } catch (exception) {
      return BrokenQuestionnaireItem.fromException(exception);
    }
  }

  Widget _buildChoiceAnswers(BuildContext context) {
    final isCheckBox = qi.isItemControl('check-box');
    final isMultipleChoice = (qi.repeats?.value ?? isCheckBox) == true;

    final choices = <Widget>[];
    if (!isMultipleChoice) {
      choices.add(RadioListTile<String?>(
          title: const NullDashText(),
          value: null,
          groupValue: answerModel.toChoiceString(value),
          onChanged: (String? newValue) {
            value = answerModel.fromChoiceString(newValue);
          }));
    }
    for (final choice in answerModel.answerOptions.values) {
      final optionPrefix = choice.extension_
          ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix')
          ?.valueString;
      final optionPrefixDisplay =
          (optionPrefix != null) ? '$optionPrefix ' : '';
      final optionTitle =
          '$optionPrefixDisplay${choice.localizedDisplay(locale)}';
      final styledOptionTitle = Xhtml.toWidget(
          context,
          itemModel.questionnaireModel,
          optionTitle,
          choice.valueStringElement?.extension_,
          width: 100,
          height: 100);

      choices.add(isMultipleChoice
          ? answerModel.isExclusive(choice.valueCoding!)
              ? RadioListTile<String>(
                  title: styledOptionTitle,
                  groupValue: choice.optionCode,
                  value: value?.coding
                          ?.firstWhereOrNull((coding) =>
                              coding.code?.value == choice.optionCode)
                          ?.code
                          ?.value ??
                      '',
                  onChanged: (_) {
                    final newValue =
                        answerModel.toggleValue(value, choice.optionCode);
                    _validationText = answerModel.validate(newValue);
                    value = newValue;
                  },
                )
              : CheckboxListTile(
                  title: styledOptionTitle,
                  value: value?.coding?.firstWhereOrNull((coding) =>
                          coding.code?.value == choice.optionCode) !=
                      null,
                  onChanged: (bool? newValue) {
                    final newValue =
                        answerModel.toggleValue(value, choice.optionCode);
                    _validationText = answerModel.validate(newValue);
                    value = newValue;
                  })
          : RadioListTile<String>(
              title: styledOptionTitle,
              value: choice.optionCode,
              groupValue: answerModel.toChoiceString(value),
              onChanged: (String? newValue) {
                value = answerModel.fromChoiceString(newValue);
              }));
    }

    if (qi.type == QuestionnaireItemType.open_choice) {
      choices.add(RadioListTile<String>(
        value: CodingAnswerModel.openChoiceOther,
        groupValue: answerModel.toChoiceString(value),
        onChanged: (String? newValue) {
          value = CodeableConcept(
              coding: [Coding(code: Code(CodingAnswerModel.openChoiceOther))],
              text: _otherChoiceController!.text);
        },
        title: TextFormField(
          controller: _otherChoiceController,
          onChanged: (newText) {
            value = (newText.isEmpty)
                ? null
                : CodeableConcept(coding: [
                    Coding(code: Code(CodingAnswerModel.openChoiceOther))
                  ], text: _otherChoiceController!.text);
          },
        ),
        secondary: const Text('Other'),
      ));
    }

    if (qi.extension_
                ?.extensionOrNull(
                    'http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation')
                ?.valueCode
                ?.value ==
            'horizontal' &&
        MediaQuery.of(context).size.width > 750) {
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
                            width: 2.0),
                        borderRadius: BorderRadius.circular(4.0))
                    : null,
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Table(children: [TableRow(children: choices)]),
              ),
            ),
            if (_validationText != null)
              Text(
                _validationText!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).errorColor),
              )
          ]);
    } else {
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
                            width: 2.0),
                        borderRadius: BorderRadius.circular(4.0))
                    : null,
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: choices,
                ),
              ),
            ),
            if (_validationText != null)
              Text(
                _validationText!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).errorColor),
              )
          ]);
    }
  }

  Widget _buildLookupAnswers(BuildContext context) {
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
      onSelected: (QuestionnaireAnswerOption selectedOption) {
        value = answerModel.fromChoiceString(selectedOption.optionCode);
      },
    );
  }
}
