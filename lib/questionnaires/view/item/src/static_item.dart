import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../fhir_types/fhir_types_extensions.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

class StaticItem extends QuestionnaireAnswerFiller {
  StaticItem(
      QuestionnaireResponseFillerState responseFillerState, int answerIndex,
      {Key? key})
      : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _StaticItemState();
}

class _StaticItemState extends State<StaticItem> {
  static final _logger = Logger(_StaticItemState);

  Decimal? calcResult;

  _StaticItemState();

  @override
  void initState() {
    super.initState();

    // TODO: This should go into a model.
    calcResult =
        widget.itemModel.responseItem?.answer?.firstOrNull?.valueDecimal ??
            widget.itemModel.responseItem?.answer?.first.valueQuantity?.value;

    if (widget.itemModel.isCalculatedExpression) {
      _logger.debug(
          'Adding listener to ${widget.itemModel} for calculated expression');
      widget.itemModel.questionnaireModel
          .addListener(() => _questionnaireChanged());
    }
  }

  void _questionnaireChanged() {
    _logger.debug('questionnaireChanged(): ${widget.itemModel.responseItem}');
    if (widget.itemModel.responseItem != null) {
      setState(() {
        calcResult =
            widget.itemModel.responseItem!.answer?.firstOrNull?.valueDecimal ??
                widget.itemModel.responseItem!.answer?.firstOrNull
                    ?.valueQuantity?.value;
      });
      _logger.debug('calculated result: $calcResult');
    }
  }

  final _nullExtension = FhirExtension();

  /// Return a feedback string according to the Danish eHealth Sundhed DK spec.
  String? findDanishFeedback(int? score) {
    if (score == null) {
      return null;
    }
    final matchExtension =
        widget.itemModel.questionnaireItem.extension_?.firstWhere((ext) {
      return (ext.url?.value.toString() ==
              'http://ehealth.sundhed.dk/fhir/StructureDefinition/ehealth-questionnaire-feedback') &&
          (ext.extension_!.extensionOrNull('min')!.valueInteger!.value! <=
              score) &&
          (ext.extension_!.extensionOrNull('max')!.valueInteger!.value! >=
              score);
    }, orElse: () => _nullExtension);

    if (matchExtension == _nullExtension) {
      return null;
    } else {
      return matchExtension!.extension_!.extensionOrNull('value')!.valueString;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemModel.isCalculatedExpression) {
      final score = calcResult?.value?.round();
      final feedback = findDanishFeedback(score);
      return Center(
          child: Column(children: [
        const SizedBox(height: 32),
        Text(
          'Total Score',
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          score?.toString() ?? '0',
          style: Theme.of(context).textTheme.headline1,
        ),
        if (feedback != null) HTML.toRichText(context, feedback),
      ]));
    }

    return const SizedBox(
      height: 16.0,
    );
  }
}
