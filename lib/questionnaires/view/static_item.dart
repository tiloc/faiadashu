import 'dart:developer' as developer;

import 'package:fhir/primitive_types/decimal.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../../util/safe_access_extensions.dart';
import '../questionnaires.dart';

class StaticItem extends QuestionnaireAnswerFiller {
  const StaticItem(
      QuestionnaireLocation location, AnswerLocation answerLocation,
      {Key? key})
      : super(location, answerLocation, key: key);
  @override
  State<StatefulWidget> createState() => _StaticItemState();
}

class _StaticItemState extends QuestionnaireAnswerState {
  // Bypass the regular 'value' field, as this has too many side-effects for a pure output widget.
  Decimal? calcResult;

  _StaticItemState();

  @override
  void initState() {
    super.initState();

    if (widget.location.responseItem != null) {
      calcResult = widget.location.responseItem!.answer!.first.valueDecimal ??
          widget.location.responseItem!.answer!.first.valueQuantity?.value;
    }

    if (widget.location.isCalculatedExpression) {
      developer.log(
          'Adding listener to ${widget.location} for calculated expression');
      widget.location.top.addListener(() => _questionnaireChanged());
    }
  }

  void _questionnaireChanged() {
    developer.log('questionnaireChanged(): ${widget.location.responseItem}',
        level: 500);
    if (widget.location.responseItem != null) {
      setState(() {
        calcResult =
            widget.location.responseItem!.answer?.firstOrNull?.valueDecimal ??
                widget.location.responseItem!.answer?.firstOrNull?.valueQuantity
                    ?.value;
      });
      developer.log('calculated result: $calcResult', level: 700);
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
          calcResult?.value?.round().toString() ?? '0',
          style: Theme.of(context).textTheme.headline1,
        ),
      ]));
    }

    return const SizedBox(
      height: 16.0,
    );
  }

  @override
  QuestionnaireResponseAnswer? fillAnswer() {
    // Not required for a static item
    throw UnimplementedError();
  }

  @override
  Widget buildEditable(BuildContext context) {
    // Not required for a read-only item
    throw UnimplementedError();
  }
}
