import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fhir_types_extensions.dart';

/// Present a picker for FhirDateTime, Date, or Time.
///
/// The control is displayed as a text field that can be tapped to open
/// a picker.
class FhirDateTimePicker extends StatefulWidget {
  final Locale? locale;
  final DateTime firstDate;
  final DateTime lastDate;
  final FhirDateTime? initialDateTime;
  final Type pickerType;
  final InputDecoration? decoration;
  final void Function(FhirDateTime?)? onChanged;

  const FhirDateTimePicker(
      {required this.initialDateTime,
      required this.firstDate,
      required this.lastDate,
      required this.pickerType,
      this.decoration,
      this.onChanged,
      this.locale,
      Key? key})
      : super(key: key);

  @override
  _FhirDateTimePickerState createState() => _FhirDateTimePickerState();
}

class _FhirDateTimePickerState extends State<FhirDateTimePicker> {
  final _dateTimeFieldController = TextEditingController();
  FhirDateTime? _dateTimeValue;
  bool _fieldInitialized = false;

  @override
  void initState() {
    super.initState();
    _dateTimeValue = widget.initialDateTime;
    _fieldInitialized = false;
  }

  @override
  void dispose() {
    _dateTimeFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale ?? Localizations.localeOf(context);

    // There is no Locale in initState.
    if (_fieldInitialized == false) {
      _dateTimeFieldController.text = _dateTimeValue?.format(locale) ?? '';
      _fieldInitialized = true;
    }

    return TextFormField(
      decoration: widget.decoration,
      controller: _dateTimeFieldController,
      onTap: () async {
        DateTime dateTime = DateTime(1970);

        if (widget.pickerType != Time) {
          final date = await showDatePicker(
              initialDate: _dateTimeValue?.value ?? DateTime.now(),
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              locale: locale,
              context: context);

          if (date == null) {
            return; // Cancelled, don't touch anything
          }
          dateTime = date.toLocal();
        }

        if (widget.pickerType == FhirDateTime || widget.pickerType == Time) {
          final time = await showTimePicker(
              initialTime: TimeOfDay.fromDateTime(
                  _dateTimeValue?.value ?? DateTime.now()),
              context: context,
              builder: (context, child) {
                return Localizations.override(
                    context: context, locale: locale, child: child);
              });

          if (time == null) {
            return; // Cancelled, don't touch anything
          }

          dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
              time.hour, time.minute);
        }

        final fhirDateTime = FhirDateTime.fromDateTime(
            dateTime,
            (widget.pickerType == Date)
                ? DateTimePrecision.YYYYMMDD
                : DateTimePrecision.FULL);
        _dateTimeFieldController.text = (widget.pickerType == Time)
            ? DateFormat.jm(locale.toString()).format(dateTime)
            : fhirDateTime.format(locale);
        _dateTimeValue = fhirDateTime;
        widget.onChanged?.call(fhirDateTime);
      },
      readOnly: true,
    );
  }
}
