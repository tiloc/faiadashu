import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'questionnaire_item_widget.dart';

class NumericalItemWidget extends QuestionnaireItemWidget {
  const NumericalItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);

  @override
  State<StatefulWidget> createState() => _NumericalItemState();
}

class _NumericalItemState
    extends QuestionnaireItemState<Decimal, NumericalItemWidget> {
  _NumericalItemState() : super(null);

  @override
  void initState() {
    super.initState();
    if (widget.location.responseItem != null) {
      value = widget.location.responseItem!.answer!.first.valueDecimal ??
          widget.location.responseItem!.answer!.first.valueQuantity?.value;
    }
    if (widget.location.isTotalScore) {
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
  Widget buildBodyReadOnly(BuildContext context) {
    if (widget.location.isTotalScore) {
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

    return const Text('Read-only Numerical');
  }

  @override
  Widget buildBodyEditable(BuildContext context) {
    return Text(widget.location.questionnaireItem.text!);
  }

  @override
  QuestionnaireResponseItem createResponse() {
    // TODO: implement createResponse
    throw UnimplementedError();
  }
}
