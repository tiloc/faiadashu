import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../fhir_types/fhir_types.dart';

/// Display a single [Observation] with value, code, and timestamp.
/// Currently only supports observations with valueQuantity,
/// or components of valueQuantity.
class ObservationWidget extends StatelessWidget {
  final Widget _valueWidget;
  final Widget _codeWidget;
  final Widget _dateTimeWidget;

  ObservationWidget(Observation observation,
      {Key? key,
      TextStyle? valueStyle,
      TextStyle? unitStyle,
      TextStyle? codeStyle,
      TextStyle? dateTimeStyle,
      String componentSeparator = ' | ',
      String unknownUnitText = '',
      String unknownValueText = '?'})
      : _valueWidget = ObservationValueWidget(observation,
            valueStyle: valueStyle,
            unitStyle: unitStyle,
            componentSeparator: componentSeparator,
            unknownUnitText: unknownUnitText,
            unknownValueText: unknownValueText),
        _codeWidget =
            CodeableConceptWidget(observation.code, style: codeStyle, key: key),
        _dateTimeWidget = FhirDateTimeWidget(
          observation.effectiveDateTime,
          style: dateTimeStyle,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _valueWidget,
        _codeWidget,
        _dateTimeWidget,
      ],
    );
  }
}

/// Display the value of a single [Observation].
/// Currently only supports observations with valueQuantity,
/// or components of valueQuantity.
class ObservationValueWidget extends StatelessWidget {
  final Observation _observation;
  final TextStyle? valueStyle;
  final TextStyle? unitStyle;
  final String componentSeparator;
  final String unknownValueText;
  final String unknownUnitText;

  const ObservationValueWidget(this._observation,
      {Key? key,
      this.valueStyle,
      this.unitStyle,
      this.componentSeparator = ' | ',
      this.unknownUnitText = '',
      this.unknownValueText = '?'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget valueWidget;

    if (_observation.valueQuantity != null) {
      final valueString = _observation.valueQuantity!.value.toString();
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
      for (final component in _observation.component!) {
        final valueString =
            component.valueQuantity?.value?.toString() ?? unknownValueText;
        final unitString = component.valueQuantity?.unit ??
            component.valueQuantity?.code ??
            unknownUnitText;
        if (componentText.isEmpty) {
          componentText.write('$valueString $unitString');
        } else {
          componentText.write('$componentSeparator$valueString $unitString');
        }
      }
      valueWidget = Text(
        componentText.toString(),
        style: valueStyle,
      );
    } else {
      valueWidget = Text(unknownValueText,
          style: valueStyle?.copyWith(
              fontWeight: FontWeight.bold, color: Colors.red));
    }

    return valueWidget;
  }
}
