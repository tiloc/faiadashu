import 'package:fhir/r4.dart';

import '../../../../coding/coding.dart';
import '../../../../fhir_types/fhir_types.dart';
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

  bool _addResponseItemToDiv(
    StringBuffer div,
    FillerItemModel fillerItemModel,
  ) {
    if (fillerItemModel is! ResponseItemModel) {return false;}

    final item = fillerItemModel.responseItem;

    if (item == null) {
      return false;
    }

    if (!fillerItemModel.isEnabled) {
      return false;
    }

    bool returnValue = false;

    if (item.text != null) {
      if (fillerItemModel is GroupResponseItemModel) {
        div.write('<h2>${item.text}</h2>');
      } else {
        div.write('<h3>${item.text}</h3>');
      }
      returnValue = true;
    }

    final invalid =
        item.extension_?.dataAbsentReason == dataAbsentReasonAsTextCode;

    if (invalid) {
      div.write(
        '<span style="color:red">${lookupFDashLocalizations(locale).dataAbsentReasonAsTextOutput} ',
      );
    }

    final dataAbsentReason = item.extension_?.dataAbsentReason;
    if (dataAbsentReason == dataAbsentReasonMaskedCode) {
      div.write('<p>***</p>');
      returnValue = true;
    } else if (dataAbsentReason == dataAbsentReasonAskedButDeclinedCode) {
      div.write(
        '<p><i><span style="color:red">X </span>${lookupFDashLocalizations(locale).dataAbsentReasonAskedDeclinedOutput}</i></p>',
      );
      returnValue = true;
    } else {
      if (item.answer != null) {
        final repeatPrefix = (item.answer!.isNotEmpty) ? '• ' : '';
        for (final answer in item.answer!) {
          if (answer.valueString != null) {
            div.write('<p>$repeatPrefix${answer.valueString}</p>');
          } else if (answer.valueDecimal != null) {
            if (fillerItemModel.questionnaireItemModel.isTotalScore) {
              div.write('<h3>${answer.valueDecimal!.format(locale)}</h3>');
            } else {
              div.write(
                '<p>$repeatPrefix${answer.valueDecimal!.format(locale)}</p>',
              );
            }
          } else if (answer.valueQuantity != null) {
            div.write(
              '<p>$repeatPrefix${answer.valueQuantity!.format(locale)}</p>',
            );
          } else if (answer.valueInteger != null) {
            div.write('<p>$repeatPrefix${answer.valueInteger!.value}</p>');
          } else if (answer.valueCoding != null) {
            div.write(
              '<p>- ${answer.valueCoding!.localizedDisplay(locale)}</p>',
            );
          } else if (answer.valueDateTime != null) {
            div.write(
              '<p>$repeatPrefix${answer.valueDateTime!.format(locale)}</p>',
            );
          } else if (answer.valueDate != null) {
            div.write(
              '<p>$repeatPrefix${answer.valueDate!.format(locale)}</p>',
            );
          } else if (answer.valueTime != null) {
            div.write(
              '<p>$repeatPrefix${answer.valueTime!.format(locale)}</p>',
            );
          } else if (answer.valueBoolean != null) {
            div.write(
              '<p>$repeatPrefix${(answer.valueBoolean!.value!) ? '[X]' : '[ ]'}</p>',
            );
          } else if (answer.valueUri != null) {
            div.write('<p>$repeatPrefix${answer.valueUri.toString()}</p>');
          } else {
            div.write('<p>$repeatPrefix${answer.toString()}</p>');
          }
          returnValue = true;
        }
      }
    }
    if (invalid) {
      div.write('</span>');
    }

    return returnValue;
  }

  Narrative _generateNarrative(
      QuestionnaireResponseModel questionnaireResponseModel) {
    final languageTag = locale.toLanguageTag();
    final div = StringBuffer(
      '<div xmlns="http://www.w3.org/1999/xhtml" lang="$languageTag" xml:lang="$languageTag">',
    );

    bool generated = false;

    for (final itemModel
        in questionnaireResponseModel.orderedFillerItemModels()) {
      generated = generated | _addResponseItemToDiv(div, itemModel);
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
