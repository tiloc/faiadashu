import 'package:fhir/r4.dart';

import '../../../coding/data_absent_reasons.dart';
import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logging.dart';
import '../../questionnaires.dart';
import 'aggregator.dart';

/// Create a narrative from the responses to a [Questionnaire].
class NarrativeAggregator extends Aggregator<Narrative> {
  static final _logger = Logger(NarrativeAggregator);

  // Revision of topLocation when _narrative was calculated
  int _revision = -1;
  // Cached narrative
  Narrative? _narrative;

  static final emptyNarrative = Narrative(
      div: '<div xmlns="http://www.w3.org/1999/xhtml"></div>',
      status: NarrativeStatus.empty);

  NarrativeAggregator()
      : super(NarrativeAggregator.emptyNarrative, autoAggregate: false);

  @override
  void init(QuestionnaireTopLocation topLocation) {
    super.init(topLocation);

    _revision = -1;
    _narrative = value;
  }

  bool _addResponseItemToDiv(StringBuffer div, QuestionnaireLocation location) {
    final item = location.responseItem;

    if (item == null) {
      return false;
    }

    if (!location.enabled) {
      return false;
    }

    bool returnValue = false;

    if (item.text != null) {
      if (location.questionnaireItem.type == QuestionnaireItemType.group) {
        div.write('<h2>${item.text}</h2>');
      } else {
        div.write('<h3>${item.text}:</h3>');
      }
      returnValue = true;
    }

    final invalid =
        item.extension_?.dataAbsentReason == DataAbsentReason.asTextCode;

    if (invalid) {
      div.write('<span style="color:red">[AS TEXT] ');
    }

    final dataAbsentReason = item.extension_?.dataAbsentReason;
    if (dataAbsentReason == DataAbsentReason.maskedCode) {
      div.write('<p>***</p>');
      returnValue = true;
    } else if (dataAbsentReason == DataAbsentReason.askedButDeclinedCode) {
      div.write(
          '<p><i><span style="color:red">X </span>Declined to answer</i></p>');
      returnValue = true;
    } else {
      if (item.answer != null) {
        for (final answer in item.answer!) {
          if (answer.valueString != null) {
            div.write('<p>${answer.valueString}</p>');
          } else if (answer.valueDecimal != null) {
            if (location.isCalculatedExpression) {
              div.write('<h3>${answer.valueDecimal!.format(locale)}</h3>');
            } else {
              div.write('<p>${answer.valueDecimal!.format(locale)}</p>');
            }
          } else if (answer.valueQuantity != null) {
            div.write('<p>${answer.valueQuantity!.format(locale)}</p>');
          } else if (answer.valueInteger != null) {
            div.write('<p>${answer.valueInteger!.value}</p>');
          } else if (answer.valueCoding != null) {
            div.write(
                '<p>- ${answer.valueCoding!.localizedDisplay(locale)}</p>');
          } else if (answer.valueDateTime != null) {
            div.write('<p>${answer.valueDateTime!.format(locale)}</p>');
          } else if (answer.valueDate != null) {
            div.write('<p>${answer.valueDate!.format(locale)}</p>');
          } else if (answer.valueTime != null) {
            div.write('<p>${answer.valueTime!.format(locale)}</p>');
          } else if (answer.valueBoolean != null) {
            div.write(
                '<p>${(answer.valueBoolean!.value!) ? '[X]' : '[ ]'}</p>');
          } else if (answer.valueUri != null) {
            div.write('<p>${answer.valueUri.toString()}</p>');
          } else {
            div.write('<p>${answer.toString()}</p>');
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

  Narrative _generateNarrative(QuestionnaireLocation topLocation) {
    final div = StringBuffer('<div xmlns="http://www.w3.org/1999/xhtml">');

    bool generated = false;

    for (final location in topLocation.preOrder()) {
      generated = generated | _addResponseItemToDiv(div, location);
    }
    div.write('</div>');
    div.write('<p>&nbsp;</p>');

    return Narrative(
        div: div.toString(),
        status: generated ? NarrativeStatus.generated : NarrativeStatus.empty);
  }

  @override
  Narrative? aggregate({bool notifyListeners = false}) {
    _logger.debug(
        '$this.aggregate (topRev: ${topLocation.revision}, rev: $_revision)');
    if (topLocation.revision == _revision) {
      _logger.debug('Regurgitating narrative revision $_revision');
      return _narrative;
    }
    // Manually invoke the update, because the order matters and enableWhen calcs need to come after answer value updates.
    topLocation.updateEnableWhen(
        notifyListeners:
            false); // Setting this to true might result in endless refresh and stack overflow
    _narrative = _generateNarrative(topLocation);
    _revision = topLocation.revision;
    if (notifyListeners) {
      value = _narrative!;
    }
    return _narrative;
  }
}
