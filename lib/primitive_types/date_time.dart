import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A [Text] widget built from a FhirDateTime.
/// Takes the precision into account.
class FhirDateTimeWidget extends StatelessWidget {
  final FhirDateTime dateTime;
  final TextStyle? style;
  final String defaultText;
  const FhirDateTimeWidget(this.dateTime,
      {this.style, this.defaultText = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    final DateFormat dateFormat;
    switch (dateTime.precision) {
      case DateTimePrecision.FULL:
        dateFormat = DateFormat.yMd(languageCode).add_jms();
        break;
      case DateTimePrecision.YYYY:
      case DateTimePrecision.INVALID:
        dateFormat = DateFormat.y(languageCode);
        break;
      case DateTimePrecision.YYYYMM:
        dateFormat = DateFormat.yM(languageCode);
        break;
      case DateTimePrecision.YYYYMMDD:
        dateFormat = DateFormat.yMd(languageCode);
        break;
    }

    return Text(
        (dateTime.value != null)
            ? dateFormat.format(dateTime.value!)
            : defaultText,
        style: style);
  }
}
