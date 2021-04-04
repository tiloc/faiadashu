import 'dart:ui';

import 'package:fhir/r4.dart';

import '../../coding/null_flavor.dart';
import '../../fhir_types/fhir_types_extensions.dart';
import '../../logging/logging.dart';
import '../questionnaires.dart';
import 'aggregator.dart';

/// Create a narrative from the responses to a [Questionnaire].
/// Updates immediately after responses have changed.
class NarrativeAggregator extends Aggregator<Narrative> {
  static final logger = Logger(NarrativeAggregator);

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

  static bool _addResponseItemToDiv(
      StringBuffer div, QuestionnaireLocation location, Locale locale) {
    final item = location.responseItem;

    if (item == null) {
      return false;
    }

    if (!location.enabled) {
      return false;
    }

    final level = location.level;

    bool returnValue = false;

    final invalid = location.responseItem!.extension_?.nullFlavorCode ==
        NullFlavor.invalidCode;

    if (invalid) {
      div.write('<div style="color:red">');
    }

    if (item.text != null) {
      div.write('<h${level + 2}>${item.text}</h${level + 2}>');
      returnValue = true;
    }

    if (item.extension_?.nullFlavorCode != NullFlavor.maskedCode) {
      // TODO(tiloc): Create further extensions for formatting
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
            div.write('<p>${answer.valueCoding!.localizedDisplay(locale)}</p>');
          } else if (answer.valueDateTime != null) {
            div.write('<p>${answer.valueDateTime!.format(locale)}</p>');
          } else if (answer.valueDate != null) {
            div.write('<p>${answer.valueDate!.format(locale)}</p>');
          } else if (answer.valueTime != null) {
            div.write('<p>${answer.valueTime!.format(locale)}</p>');
          } else if (answer.valueBoolean != null) {
            div.write(
                '<p>${(answer.valueBoolean!.value!) ? '[X]' : '[ ]'}</p>');
          } else {
            div.write('<p>${answer.toString()}</p>');
          }
          returnValue = true;
        }
      }
    } else {
      div.write('<p>***</p>');
    }
    if (invalid) {
      div.write('</div>');
    }
    return returnValue;
  }

  static Narrative _generateNarrative(
      QuestionnaireLocation topLocation, Locale locale) {
    final div = StringBuffer('<div xmlns="http://www.w3.org/1999/xhtml">');

    bool generated = false;

    for (final location in topLocation.preOrder()) {
      generated = generated | _addResponseItemToDiv(div, location, locale);
    }
    div.write('</div>');
    return Narrative(
        div: div.toString(),
        status: generated ? NarrativeStatus.generated : NarrativeStatus.empty);
  }

  @override
  Narrative? aggregate(Locale? locale, {bool notifyListeners = false}) {
    ArgumentError.checkNotNull(locale, 'locale');

    logger.log(
        '$this.aggregate (topRev: ${topLocation.revision}, rev: $_revision)',
        level: LogLevel.debug);
    if (topLocation.revision == _revision) {
      logger.log('Regurgitating narrative revision $_revision',
          level: LogLevel.debug);
      return _narrative;
    }
    // Manually invoke the update, because the order matters and enableWhen calcs need to come after answer value updates.
    topLocation.updateEnableWhen(
        notifyListeners:
            false); // Setting this to true might result in endless refresh and stack overflow
    _narrative = _generateNarrative(topLocation, locale!);
    _revision = topLocation.revision;
    if (notifyListeners) {
      value = _narrative!;
    }
    return _narrative;
  }
}
