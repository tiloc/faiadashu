import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/observations/observations.dart';
import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

/// Display a single [Observation] with value, code, and timestamp.
///
/// Currently only supports observations with valueQuantity,
/// or components of valueQuantity.
class ObservationView extends StatelessWidget {
  final Widget _valueWidget;
  final Widget _codeWidget;
  final Widget _dateTimeWidget;
  final Locale? locale;

  ObservationView(
    Observation observation, {
    Key? key,
    this.locale,
    TextStyle? valueStyle,
    TextStyle? unitStyle,
    TextStyle? codeStyle,
    TextStyle? dateTimeStyle,
    String componentSeparator = ' | ',
    String unknownUnitText = '',
    String unknownValueText = '?',
  })  : _valueWidget = ObservationValueView(
          observation,
          valueStyle: valueStyle,
          unitStyle: unitStyle,
          locale: locale,
          componentSeparator: componentSeparator,
          unknownUnitText: unknownUnitText,
          unknownValueText: unknownValueText,
        ),
        _codeWidget =
            CodeableConceptText(observation.code, style: codeStyle, key: key),
        _dateTimeWidget = FhirDateTimeText(
          observation.effectiveDateTime,
          locale: locale,
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
