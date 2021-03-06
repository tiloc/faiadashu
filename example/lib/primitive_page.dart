import 'package:fhir/primitive_types/fhir_date_time.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/primitive_types/date_time_widget.dart';

// ignore: use_key_in_widget_constructors
class PrimitivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primitive Types'),
      ),
      body: Column(children: [
        FhirDateTimeWidget(FhirDateTime('2002-02-05')),
        FhirDateTimeWidget(FhirDateTime('2010-02-05 14:02')),
        FhirDateTimeWidget(FhirDateTime('2010-02')),
      ]),
    );
  }
}
