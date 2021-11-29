import 'package:fhir/r4.dart';

import '../../../../coding/coding.dart';
import '../../../../l10n/l10n.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

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

    if (itemModel is GroupItemModel) {
      if ((usageMode == usageModeDisplayNonEmptyCode ||
              usageMode == usageModeCaptureDisplayNonEmptyCode) &&
          itemModel.isUnanswered) {
        return false;
      }

      if (itemText != null) {
        div.write('<h2>${itemText.xhtmlText}</h2>');

        return true;
      } else {
        return false;
      }
    } else if (itemModel is DisplayItemModel) {
      if (itemText != null) {
        div.write('<p>${itemText.xhtmlText}</p>');

        return true;
      } else {
        return false;
      }
    }

    if (itemModel is! QuestionItemModel) {
      throw ArgumentError('Expecting QuestionItemModel', 'itemModel');
    }

    return _addQuestionItemToDiv(div, itemModel, itemText);
  }

  bool _addQuestionItemToDiv(
    StringBuffer div,
    QuestionItemModel itemModel,
    XhtmlString? itemText,
  ) {
    final usageMode = itemModel.questionnaireItemModel.usageMode;
    if ((usageMode == usageModeDisplayNonEmptyCode ||
            usageMode == usageModeCaptureDisplayNonEmptyCode) &&
        itemModel.isUnanswered) {
      return false;
    }

    if (itemText != null) {
      div.write('<h3>${itemText.xhtmlText}</h3>');
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
          itemModel.questionnaireItemModel.isRepeating ? '• ' : '';
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
          div.write(
            '<p>$repeatPrefix${answerModel.display.xhtmlTextWithMedia}</p>',
          );
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
