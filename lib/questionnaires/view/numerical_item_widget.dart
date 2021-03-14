import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class NumericalItemAnswer extends QuestionnaireAnswerFiller {
  const NumericalItemAnswer(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);

  @override
  State<NumericalItemAnswer> createState() => _NumericalItemState();
}

class _NumericalItemState
    extends QuestionnaireAnswerState<Decimal, NumericalItemAnswer> {
  _NumericalItemState();

  @override
  void initState() {
    super.initState();
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
      value = widget.location.responseItem!.answer!.first.valueDecimal ??
          widget.location.responseItem!.answer!.first.valueQuantity?.value;
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
    return TextFormField(
      decoration:
          InputDecoration(labelText: widget.location.questionnaireItem.text),
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
