import 'package:faiadashu/coding/coding.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';

/// Create a narrative from the responses to a [Questionnaire].
class NarrativeAggregator extends Aggregator<Narrative> {
  static final _logger = Logger(NarrativeAggregator);

  // Generation of QuestionnaireResponseModel when _narrative was calculated
  int _generation = -1;
  // Cached narrative
  Narrative? _narrative;

  static final emptyNarrative = Narrative(
    div: '<div xmlns="http://www.w3.org/1999/xhtml"></div>',
    status: NarrativeStatus.empty,
  );

  NarrativeAggregator()
      : super(NarrativeAggregator.emptyNarrative, autoAggregate: false);

  @override
  void init(QuestionnaireResponseModel questionnaireResponseModel) {
    super.init(questionnaireResponseModel);

    _generation = -1;
    _narrative = value;
  }

  bool _addFillerItemToDiv(
    StringBuffer div,
    FillerItemModel itemModel,
  ) {
    if (itemModel.questionnaireItemModel.isHidden || itemModel.isNotEnabled) {
      return false;
    }

    final usageMode = itemModel.questionnaireItemModel.usageMode;

    if (usageMode == usageModeCaptureCode) {
      return false;
    }

    final itemText = itemModel.questionnaireItemModel.text;
    final prefix = itemModel.prefix;

    final prefixedItemText = (prefix != null)
        ? (itemText != null)
            ? '${prefix.xhtmlText} ${itemText.xhtmlText}'
            : null
        : (itemText != null)
            ? itemText.xhtmlText
            : null;

    final itemMedia = itemModel.questionnaireItemModel.itemMedia;

    if (itemModel is GroupItemModel) {
      if ((usageMode == usageModeDisplayNonEmptyCode ||
              usageMode == usageModeCaptureDisplayNonEmptyCode) &&
          itemModel.isUnanswered) {
        return false;
      }

      if (prefixedItemText != null) {
        div.write('<h2>$prefixedItemText</h2>');

        return true;
      } else {
        return false;
      }
    } else if (itemModel is DisplayItemModel) {
      if (prefixedItemText != null) {
        div.write('<p>$prefixedItemText</p>');

        return true;
      } else {
        return false;
      }
    }

    if (itemModel is! QuestionItemModel) {
      throw ArgumentError('Expecting QuestionItemModel', 'itemModel');
    }

    return _addQuestionItemToDiv(div, itemModel, prefixedItemText, itemMedia);
  }

  bool _addQuestionItemToDiv(
    StringBuffer div,
    QuestionItemModel itemModel,
    String? prefixedItemText,
    ItemMediaModel? itemMedia,
  ) {
    final usageMode = itemModel.questionnaireItemModel.usageMode;
    if ((usageMode == usageModeDisplayNonEmptyCode ||
            usageMode == usageModeCaptureDisplayNonEmptyCode) &&
        itemModel.isUnanswered) {
      return false;
    }

    if (prefixedItemText != null) {
      div.write('<h3>$prefixedItemText</h3>');
    }

    // TODO: What is the preference? Inline with item text, or emit underneath?
    if (itemMedia != null) {
      div.write(itemMedia.toXhtml());
    }

    if (itemModel.isUnanswered) {
      div.write('<p>&mdash;</p>');

      return true;
    }

    final dataAbsentReason = itemModel.dataAbsentReason;

    final invalid = dataAbsentReason == dataAbsentReasonAsTextCode;

    if (invalid) {
      div.write(
        '<span style="color:red">${lookupFDashLocalizations(locale).dataAbsentReasonAsTextOutput} ',
      );
    }

    if (dataAbsentReason == dataAbsentReasonMaskedCode) {
      div.write('<p>***</p>');
    } else if (dataAbsentReason == dataAbsentReasonAskedButDeclinedCode) {
      div.write(
        '<p><i><span style="color:red">X </span>${lookupFDashLocalizations(locale).dataAbsentReasonAskedDeclinedOutput}</i></p>',
      );
    } else {
      final filledAnswers = itemModel.answeredAnswerModels;

      final repeatPrefix =
          itemModel.questionnaireItemModel.questionnaireItem.repeats?.value ??
                  false
              ? '• '
              : '';
      for (final answerModel in filledAnswers) {
        if (answerModel is NumericalAnswerModel) {
          if (itemModel.questionnaireItemModel.isTotalScore) {
            div.write('<h3>${answerModel.display.xhtmlText}</h3>');
          } else {
            div.write(
              '<p>$repeatPrefix${answerModel.display.xhtmlText}</p>',
            );
          }
        } else {
          // Output of answer option media for coding items
          if (answerModel is CodingAnswerModel) {
            final displayItems = answerModel.toDisplay();
            for (final displayItem in displayItems) {
              div.write(
                '<p>$repeatPrefix${displayItem.xhtmlText}</p>',
              );
            }
          } else {
            div.write(
              '<p>$repeatPrefix${answerModel.display.xhtmlText}</p>',
            );
          }
        }
      }
    }
    if (invalid) {
      div.write('</span>');
    }

    return true;
  }

  Narrative _generateNarrative(
    QuestionnaireResponseModel questionnaireResponseModel,
  ) {
    final languageTag = locale.toLanguageTag();
    final div = StringBuffer(
      '<div xmlns="http://www.w3.org/1999/xhtml" lang="$languageTag" xml:lang="$languageTag">',
    );

    bool generated = false;

    for (final itemModel
        in questionnaireResponseModel.orderedFillerItemModels()) {
      generated = generated | _addFillerItemToDiv(div, itemModel);
    }
    div.write('<p>&nbsp;</p>');
    div.write('</div>');

    return Narrative(
      div: div.toString(),
      status: generated ? NarrativeStatus.generated : NarrativeStatus.empty,
    );
  }

  @override
  Narrative? aggregate({bool notifyListeners = false}) {
    _logger.debug(
      '$this.aggregate (Model Generation: ${questionnaireResponseModel.generation}, Narrative Generation: $_generation)',
    );
    if (questionnaireResponseModel.generation == _generation) {
      _logger.debug('Regurgitating narrative generation $_generation');

      return _narrative;
    }
    // Manually invoke the update, because the order matters and enableWhen calcs need to come after answer value updates.
    questionnaireResponseModel.updateEnabledItems(
      notifyListeners: false,
    ); // Setting this to true might result in endless refresh and stack overflow
    _narrative = _generateNarrative(questionnaireResponseModel);
    _generation = questionnaireResponseModel.generation;
    if (notifyListeners) {
      value = _narrative!;
    }

    return _narrative;
  }
}
