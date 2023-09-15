import 'dart:collection';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Display the value of a single [Observation].
///
/// Currently only supports observations with valueQuantity,
/// or components of valueQuantity.
class ObservationValueView extends StatelessWidget {
  final Observation _observation;
  final Locale? locale;
  final TextStyle? valueStyle;
  final TextStyle? unitStyle;
  final String componentSeparator;
  final String unknownValueText;
  final String unknownUnitText;

  const ObservationValueView(
    this._observation, {
    super.key,
    this.locale,
    this.valueStyle,
    this.unitStyle,
    this.componentSeparator = ' | ',
    this.unknownUnitText = '',
    this.unknownValueText = '?',
  });

  @override
  Widget build(BuildContext context) {
    final Widget valueWidget;

    final decimalFormat = NumberFormat.decimalPattern(
      (locale ?? Localizations.localeOf(context)).toString(),
    );

    if (_observation.valueQuantity != null) {
      final valueString =
          decimalFormat.format(_observation.valueQuantity!.value);
      final unitString = _observation.valueQuantity?.unit ??
          _observation.valueQuantity?.code ??
          unknownUnitText;
      valueWidget = Text(
        '$valueString $unitString',
        style: valueStyle,
      );
    } else if (_observation.component != null &&
        _observation.component!.isNotEmpty) {
      final componentText = StringBuffer();
      String? currentUnit;
      final componentIterator =
          HasNextIterator(_observation.component!.iterator);
      do {
        final ObservationComponent component = componentIterator.next();
        final unitString =
            ' ${component.valueQuantity?.unit ?? unknownUnitText}';
        // Avoid duplicate output of same unit:
        // emit unit only when it is different from unit of previous component
        if (currentUnit != null && unitString != currentUnit) {
          componentText.write(currentUnit);
        }
        currentUnit = unitString;

        final valueString = (component.valueQuantity?.value != null)
            ? decimalFormat.format(component.valueQuantity?.value!.value)
            : unknownValueText;
        if (componentText.isEmpty) {
          componentText.write(valueString);
        } else {
          componentText.write('$componentSeparator$valueString');
        }
      } while (componentIterator.hasNext);
      componentText.write(currentUnit);
      valueWidget = Text(
        componentText.toString(),
        style: valueStyle,
      );
    } else {
      valueWidget = Text(
        unknownValueText,
        style: valueStyle?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.error,
        ),
      );
    }

    return valueWidget;
  }
}
