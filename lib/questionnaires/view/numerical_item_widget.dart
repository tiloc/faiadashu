import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/model/total_score_notifier.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'questionnaire_item_widget.dart';

class NumericalItemWidget extends QuestionnaireItemWidget {
  final TotalScoreNotifier? _totalScoreNotifier;

  NumericalItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : _totalScoreNotifier =
            (location.isTotalScore) ? TotalScoreNotifier(location) : null,
        super(location, decorator, key: key);

  @override
  State<StatefulWidget> createState() => _NumericalItemState();
}

class _NumericalItemState
    extends QuestionnaireItemState<Decimal, NumericalItemWidget> {
  _NumericalItemState() : super(null);

  @override
  Widget buildBodyReadOnly(BuildContext context) {
    if (widget.location.isTotalScore) {
      return ValueListenableBuilder<Decimal?>(
        builder: (BuildContext context, Decimal? value, Widget? child) {
          return Center(
              child: Column(children: [
            const SizedBox(height: 32),
            Text(
              'Total Score',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              value!.value!.round().toString(),
              style: Theme.of(context).textTheme.headline1,
            ),
          ]));
        },
        valueListenable: widget._totalScoreNotifier!,
      );
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
