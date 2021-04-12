import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../logging/logging.dart';
import '../../../../questionnaires/model/questionnaire_extensions.dart';
import '../../../model/item/coding_item_model.dart';
import '../../../questionnaires.dart';
import '../../broken_questionnaire_item.dart';
import '../../xhtml.dart';

/// Answer questions which require code(s) as a response.
///
/// This class uses [CodeableConcept] to model multiple choice and open choice.
/// Future R5 releases of the FHIR standard will likely have a `coding` item type.
class CodingAnswer extends QuestionnaireAnswerFiller {
  const CodingAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _CodingAnswerState();
}

class _CodingAnswerState
    extends QuestionnaireAnswerState<CodeableConcept, CodingAnswer> {
  static final _logger = Logger(_CodingAnswerState);
  late final CodingItemModel _itemModel;

  Object? _initFailure;
  late final TextEditingController? _otherChoiceController;

  String? _validationText;

  static const openChoiceOther = 'open-choice-other';

  _CodingAnswerState();

  @override
  void initState() {
    super.initState();

    try {
      _itemModel = CodingItemModel(location);

      if (widget.location.responseItem != null) {
        initialValue = CodeableConcept(
            coding: widget.location.responseItem!.answer
                ?.map((answer) => _itemModel
                    .answerOptions[
                        _itemModel.choiceStringFromCoding(answer.valueCoding)]!
                    .valueCoding!)
                .toList());
      }
    } catch (exception) {
      _logger.log(
          'Could not initialize ${(CodingAnswer).toString()} for ${widget.location.linkId}',
          error: exception);
      _initFailure = exception;
    }

    if (qi.type == QuestionnaireItemType.open_choice) {
      // TODO: Set initialValue
      _otherChoiceController = TextEditingController();
    }

    _validationText = _itemModel.validate(value);
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    throw UnsupportedError(
        '${(CodingAnswer).toString()} will always return coding answers.');
  }

  @override
  List<QuestionnaireResponseAnswer>? fillCodingAnswers() {
    if (value == null) {
      return null;
    }

    // TODO(tiloc): Return the order of the codings in the order of the choices?

    // TODO: This is only supporting a single other text.
    final result = (value!.coding?.firstOrNull?.code?.value == openChoiceOther)
        ? [
            QuestionnaireResponseAnswer(
                valueCoding: Coding(display: _otherChoiceController!.text))
          ]
        : value!.coding?.map<QuestionnaireResponseAnswer>((coding) {
            // Some answers may only be a display, not have a code
            return coding.code != null
                ? QuestionnaireResponseAnswer(
                    valueCoding: _itemModel
                        .answerOptions[
                            _itemModel.choiceStringFromCoding(coding)]!
                        .valueCoding)
                : QuestionnaireResponseAnswer(valueCoding: coding);
          }).toList();

    return result;
  }

  @override
  bool hasCodingAnswers() {
    return true;
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    return (_initFailure == null)
        ? Text(value?.localizedDisplay(locale) ?? '-')
        : BrokenQuestionnaireItem.fromException(_initFailure!);
  }

  @override
  Widget buildEditable(BuildContext context) {
    if (_initFailure != null) {
      return BrokenQuestionnaireItem.fromException(_initFailure!);
    }

    try {
      if (!(qi.repeats == Boolean(true)) &&
          (_itemModel.answerOptions.length > 10 ||
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
          title: Text(
            '   ',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                decoration: TextDecoration.lineThrough,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.54)),
          ),
          value: null,
          groupValue: _itemModel.toChoiceString(value),
          onChanged: (String? newValue) {
            value = _itemModel.fromChoiceString(newValue);
          }));
    }
    for (final choice in _itemModel.answerOptions.values) {
      final optionPrefix = choice.extension_
          ?.extensionOrNull(
              'http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix')
          ?.valueString;
      final optionPrefixDisplay =
          (optionPrefix != null) ? '$optionPrefix ' : '';
      final optionTitle =
          '$optionPrefixDisplay${choice.localizedDisplay(locale)}';
      final styledOptionTitle = Xhtml.toWidget(
          context, top, optionTitle, choice.valueStringElement?.extension_,
          width: 100, height: 100);

      choices.add(isMultipleChoice
          ? _itemModel.isExclusive(choice.valueCoding!)
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
                        _itemModel.toggleValue(value, choice.optionCode);
                    _validationText = _itemModel.validate(newValue);
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
                        _itemModel.toggleValue(value, choice.optionCode);
                    _validationText = _itemModel.validate(newValue);
                    value = newValue;
                  })
          : RadioListTile<String>(
              title: styledOptionTitle,
              value: choice.optionCode,
              groupValue: _itemModel.toChoiceString(value),
              onChanged: (String? newValue) {
                value = _itemModel.fromChoiceString(newValue);
              }));
    }

    if (qi.type == QuestionnaireItemType.open_choice) {
      choices.add(RadioListTile<String>(
        value: openChoiceOther,
        groupValue: _itemModel.toChoiceString(value),
        onChanged: (String? newValue) {
          value = CodeableConcept(
              coding: [Coding(code: Code(openChoiceOther))],
              text: _otherChoiceController!.text);
        },
        title: TextFormField(
          controller: _otherChoiceController,
          onChanged: (newText) {
            value = (newText.isEmpty)
                ? null
                : CodeableConcept(
                    coding: [Coding(code: Code(openChoiceOther))],
                    text: _otherChoiceController!.text);
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
            Card(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Table(children: [TableRow(children: choices)])),
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
            Card(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: choices,
                )),
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
      initialValue: value?.localizedDisplay(locale),
      displayStringForOption: (answerOption) =>
          answerOption.localizedDisplay(locale),
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<QuestionnaireAnswerOption>.empty();
        }
        return _itemModel.answerOptions.values
            .where((QuestionnaireAnswerOption option) {
          return option
              .localizedDisplay(locale)
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (QuestionnaireAnswerOption selectedOption) {
        value = _itemModel.fromChoiceString(selectedOption.optionCode);
      },
    );
  }
}
