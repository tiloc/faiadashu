import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A [Text] widget built from a FhirDateTime.
/// Takes the precision and locale into account.
class FhirDateTimeWidget extends StatelessWidget {
  final FhirDateTime? dateTime;
  final TextStyle? style;
  final String defaultText;
  const FhirDateTimeWidget(this.dateTime,
      {this.style, this.defaultText = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    if (dateTime != null && dateTime!.precision != DateTimePrecision.INVALID) {
      final DateFormat dateFormat;
      switch (dateTime!.precision) {
        case DateTimePrecision.FULL:
        case DateTimePrecision.INVALID:
          dateFormat = DateFormat.yMd(languageCode).add_jms();
          break;
        case DateTimePrecision.YYYY:
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
          (dateTime!.value != null)
              ? dateFormat.format(dateTime!.value!)
              : defaultText,
          style: style);
    } else {
      return Text(
        defaultText,
        style: style,
      );
    }
  }
}
