import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'fhir_types_extensions.dart';

// TODO: Is it really advantageous to use a TextFormField? Or would a FocusableActionDetector be the better basis?

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
  final FocusNode? focusNode;
  final void Function(FhirDateTime?)? onChanged;

  const FhirDateTimePicker(
      {required this.initialDateTime,
      required this.firstDate,
      required this.lastDate,
      required this.pickerType,
      this.onChanged,
      this.locale,
      this.focusNode,
      Key? key})
      : super(key: key);

  @override
  _FhirDateTimePickerState createState() => _FhirDateTimePickerState();
}

class _FhirDateTimePickerState extends State<FhirDateTimePicker> {
  String? _dateTimeText;
  FhirDateTime? _dateTimeValue;
  bool _fieldInitialized = false;
  final _clearFocusNode = FocusNode(skipTraversal: true);

  @override
  void initState() {
    super.initState();
    _dateTimeValue = widget.initialDateTime;
    _fieldInitialized = false;
  }

  @override
  void dispose() {
    _clearFocusNode.dispose();
    super.dispose();
  }

  Future<void> _showPicker(Locale locale) async {
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
          initialTime:
              TimeOfDay.fromDateTime(_dateTimeValue?.value ?? DateTime.now()),
          context: context,
          builder: (context, child) {
            return Localizations.override(
                context: context, locale: locale, child: child);
          });

      if (time == null) {
        return; // Cancelled, don't touch anything
      }

      dateTime = DateTime(
          dateTime.year, dateTime.month, dateTime.day, time.hour, time.minute);
    }

    final fhirDateTime = FhirDateTime.fromDateTime(
        dateTime,
        (widget.pickerType == Date)
            ? DateTimePrecision.YYYYMMDD
            : DateTimePrecision.FULL);
    setState(() {
      _dateTimeText = (widget.pickerType == Time)
          ? DateFormat.jm(locale.toString()).format(dateTime)
          : fhirDateTime.format(locale);
    });
    _dateTimeValue = fhirDateTime;
    widget.onChanged?.call(fhirDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final locale = widget.locale ?? Localizations.localeOf(context);

    // There is no context Locale in initState.
    if (_fieldInitialized == false) {
      _dateTimeText = _dateTimeValue?.format(locale);
      _fieldInitialized = true;
    }

    return Row(
      children: [
        if (widget.pickerType == Time)
          const Icon(Icons.access_time_outlined)
        else
          const Icon(Icons.calendar_today_outlined),
        const SizedBox(width: 8.0),
        Expanded(
          child: OutlinedButton(
            focusNode: widget.focusNode,
            style: OutlinedButton.styleFrom().copyWith(
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return Theme.of(context).textTheme.bodyText1?.color;
              }),
              side: MaterialStateProperty.resolveWith<BorderSide?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) {
                    return BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2.0,
                    );
                  }
                  // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () async {
              widget.focusNode?.requestFocus();
              await _showPicker(locale);
            },
            child: Text(_dateTimeText ?? '—'),
          ),
        ),
        if (_dateTimeText != null && _dateTimeText!.isNotEmpty)
          IconButton(
              focusNode: _clearFocusNode,
              onPressed: () {
                setState(() {
                  _dateTimeText = null;
                });
                widget.onChanged?.call(null);
              },
              icon: const Icon(Icons.clear))
      ],
    );
  }
}
