import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../questionnaires.dart';

class NumericalAnswer extends QuestionnaireAnswerFiller {
  const NumericalAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);

  @override
  State<NumericalAnswer> createState() => _NumericalAnswerState();
}

class _NumericalAnswerState
    extends QuestionnaireAnswerState<Decimal, NumericalAnswer> {
  late final TextInputFormatter _numberInputFormatter;
  late final NumberFormat _numberFormat;

  _NumericalAnswerState();

  @override
  void initState() {
    super.initState();
    // TODO: Build a number format based on item and SDC properties.
    _numberFormat = NumberFormat('############.0##');

    _numberInputFormatter =
        TextInputFormatter.withFunction((oldValue, newValue) {
      try {
        _numberFormat.parse(newValue.text);
        return newValue;
      } catch (_) {
        return oldValue;
      }
    });

    if (widget.location.responseItem != null) {
      initialValue = widget.location.responseItem!.answer!.first.valueDecimal ??
          widget.location.responseItem!.answer!.first.valueQuantity?.value;
    }
    if (widget.location.isCalculatedExpression) {
      widget.location.top.addListener(() => _questionnaireChanged());
    }
  }

  void _questionnaireChanged() {
    if (widget.location.responseItem != null) {
      value = widget.answerLocation.answer?.valueDecimal ??
          widget.answerLocation.answer?.valueQuantity?.value;
    }
  }

  @override
  Widget buildReadOnly(BuildContext context) {
    if (widget.location.isCalculatedExpression) {
      return Center(
          child: Column(children: [
        const SizedBox(height: 32),
        Text(
          'Total Score',
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          value?.value?.round().toString() ?? '0',
          style: Theme.of(context).textTheme.headline1,
        ),
      ]));
    }

    return Text(value.toString());
  }

  @override
  Widget buildEditable(BuildContext context) {
    // TODO(tiloc): Do not hardcode . as separator
    return TextFormField(
      decoration:
          InputDecoration(labelText: widget.location.questionnaireItem.text),
      inputFormatters: [_numberInputFormatter],
      keyboardType: TextInputType.number,
      onChanged: (content) {
        value = Decimal(content);
      },
    );
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() =>
      QuestionnaireResponseAnswer(valueDecimal: value);
}
