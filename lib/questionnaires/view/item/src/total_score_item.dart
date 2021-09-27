import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../l10n/l10n.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

/// A styled display item for total scores.
///
/// Shows a large, animated score and also supports the Danish
/// sundhed.dk questionnaire-feedback extension.
class TotalScoreItem extends QuestionnaireAnswerFiller {
  TotalScoreItem(
    QuestionnaireResponseFillerState responseFillerState,
    int answerIndex, {
    Key? key,
  }) : super(responseFillerState, answerIndex, key: key);
  @override
  State<StatefulWidget> createState() => _TotalScoreItemState();
}

class _TotalScoreItemState extends State<TotalScoreItem> {
  static final _logger = Logger(_TotalScoreItemState);

  Decimal? calcResult;

  _TotalScoreItemState();

  @override
  void initState() {
    super.initState();

    // TODO: This should go into a model.
    calcResult =
        widget.itemModel.responseItem?.answer?.firstOrNull?.valueDecimal ??
            widget.itemModel.responseItem?.answer?.first.valueQuantity?.value;

    if (widget.itemModel.isCalculated) {
      _logger.debug(
        'Adding listener to ${widget.itemModel} for calculated expression',
      );
      widget.itemModel.questionnaireModel.addListener(_questionnaireChanged);
    }
  }

  @override
  void dispose() {
    widget.itemModel.questionnaireModel.removeListener(_questionnaireChanged);
    super.dispose();
  }

  void _questionnaireChanged() {
    _logger.debug('questionnaireChanged(): ${widget.itemModel.responseItem}');
    if (!mounted) {
      return;
    }
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
        widget.itemModel.questionnaireItem.extension_?.firstWhere(
      (ext) {
        return (ext.url?.value.toString() ==
                'http://ehealth.sundhed.dk/fhir/StructureDefinition/ehealth-questionnaire-feedback') &&
            (ext.extension_!.extensionOrNull('min')!.valueInteger!.value! <=
                score) &&
            (ext.extension_!.extensionOrNull('max')!.valueInteger!.value! >=
                score);
      },
      orElse: () => _nullExtension,
    );

    if (matchExtension == _nullExtension) {
      return null;
    } else {
      return matchExtension!.extension_!.extensionOrNull('value')!.valueString;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemModel.isTotalScore) {
      final score = calcResult?.value?.round();
      final scoreText = score?.toString() ?? AnswerModel.nullText;
      final feedback = findDanishFeedback(score);
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              FDashLocalizations.of(context).aggregationTotalScoreTitle,
              style: Theme.of(context).textTheme.headline3,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                scoreText,
                key: ValueKey<String>(scoreText),
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            if (feedback != null) HTML.toRichText(context, feedback),
          ],
        ),
      );
    }

    return const SizedBox(
      height: 16.0,
    );
  }
}
