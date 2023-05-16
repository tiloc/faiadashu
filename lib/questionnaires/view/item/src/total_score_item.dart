import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

/// A styled display item for total scores.
///
/// Shows a large, animated score and also supports the Danish
/// sundhed.dk questionnaire-feedback extension.
class TotalScoreItem extends QuestionnaireAnswerFiller {
  TotalScoreItem(
    super.answerModel, {
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _TotalScoreItemState();
}

class _TotalScoreItemState extends State<TotalScoreItem> {
  static final _logger = Logger(_TotalScoreItemState);

  FhirDecimal? calcResult;

  _TotalScoreItemState();

  void _updateCalcResult() {
    calcResult =
        (widget.responseItemModel.firstAnswerModel as NumericalAnswerModel)
            .value
            ?.value;
  }

  @override
  void initState() {
    super.initState();

    _updateCalcResult();

    if (widget.questionnaireItemModel.isCalculated) {
      _logger.debug(
        'Adding listener to ${widget.questionnaireItemModel} for calculated expression',
      );
      widget.responseItemModel.questionnaireResponseModel.valueChangeNotifier
          .addListener(_questionnaireChanged);
    }
  }

  @override
  void dispose() {
    widget.responseItemModel.questionnaireResponseModel.valueChangeNotifier
        .removeListener(_questionnaireChanged);
    super.dispose();
  }

  void _questionnaireChanged() {
    _logger.debug(
      'questionnaireChanged(): ${widget.responseItemModel.nodeUid}',
    );
    if (!mounted) {
      return;
    }

    setState(() {
      _updateCalcResult();
    });
    _logger.debug('calculated result: $calcResult');
  }

  final _nullExtension = FhirExtension();

  /// Return a feedback string according to the Danish eHealth Sundhed DK spec.
  String? findDanishFeedback(int? score) {
    if (score == null) {
      return null;
    }
    final matchExtension =
        widget.questionnaireItemModel.questionnaireItem.extension_?.firstWhere(
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

    return (matchExtension == _nullExtension)
        ? null
        : matchExtension!.extension_!.extensionOrNull('value')!.valueString;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questionnaireItemModel.isTotalScore) {
      final score = calcResult?.value?.round();
      final scoreText = score?.toString() ?? AnswerModel.nullText;
      final feedback = findDanishFeedback(score);

      return Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              FDashLocalizations.of(context).aggregationTotalScoreTitle,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                scoreText,
                key: ValueKey<String>(scoreText),
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: (feedback != null)
                  ? Container(
                      key: ValueKey<String>(feedback),
                      child: HTML.toRichText(context, feedback),
                    )
                  : const SizedBox(
                      height: 16.0,
                      key: ValueKey<String>('no-feedback'),
                    ),
            ),
          ],
        ),
      );
    }

    return const SizedBox(
      height: 16.0,
    );
  }
}
