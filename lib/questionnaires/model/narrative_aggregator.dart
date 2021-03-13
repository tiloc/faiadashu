import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

/// Create a narrative from the responses to a [Questionnaire].
/// Updates immediately after responses have changed.
class NarrativeAggregator extends ValueNotifier<Narrative> {
  final QuestionnaireLocation top;

  NarrativeAggregator(QuestionnaireLocation location)
      : top = location.top,
        super(_generateNarrative(location.top)) {
    for (final location in top.preOrder()) {
      if (!location.isStatic) {
        location.addListener(() => _updateNarrative());
      }
    }
  }

  static bool _addResponseItemToDiv(
      StringBuffer div, QuestionnaireLocation location) {
    final item = location.responseItem;

    if (item == null) {
      return false;
    }

    final level = location.level;

    bool returnValue = false;

    if (item.text != null) {
      div.write('<h${level + 2}>${item.text}</h${level + 2}>');
      returnValue = true;
    }

    // TODO(tiloc): Should the conversion from answer to text rather live in classes for the individual types?
    if (item.answer != null) {
      for (final answer in item.answer!) {
        if (answer.valueString != null) {
          div.write('<p>${answer.valueString}</p>');
        } else if (answer.valueDecimal != null) {
          div.write('<p>${answer.valueDecimal.toString()}</p>');
        } else if (answer.valueQuantity != null) {
          div.write(
              '<p>${answer.valueQuantity!.value} ${answer.valueQuantity!.unit}</p>');
        } else if (answer.valueCoding != null) {
          div.write('<p>${answer.valueCoding!.safeDisplay}</p>');
        } else if (answer.valueDateTime != null) {
          div.write('<p>${answer.valueDateTime}</p>');
        } else if (answer.valueDate != null) {
          div.write('<p>${answer.valueDate}</p>');
        } else if (answer.valueTime != null) {
          div.write('<p>${answer.valueTime}</p>');
        } else if (answer.valueBoolean != null) {
          div.write('<p>${answer.valueBoolean}</p>');
        } else {
          div.write('<p>${answer.toString()}</p>');
        }
        returnValue = true;
      }
    }

    return returnValue;
  }

  static Narrative _generateNarrative(QuestionnaireLocation topLocation) {
    final div = StringBuffer('<div xmlns="http://www.w3.org/1999/xhtml">');

    bool generated = false;

    for (final location in topLocation.preOrder()) {
      generated = generated | _addResponseItemToDiv(div, location);
    }
    div.write('</div>');
    return Narrative(
        div: div.toString(),
        status: generated ? NarrativeStatus.generated : NarrativeStatus.empty);
  }

  void _updateNarrative() {
    value = _generateNarrative(top);
  }
}
