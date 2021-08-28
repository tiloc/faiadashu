import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:fhir/primitive_types/fhir_date_time.dart';
import 'package:flutter/material.dart';

import 'exhibit_page.dart';

class PrimitivePage extends ExhibitPage {
  const PrimitivePage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return Column(
      children: [
        Text('Default locale', style: Theme.of(context).textTheme.headline6),
        FhirDateTimeText(FhirDateTime('2002-02-05')),
        FhirDateTimeText(FhirDateTime('2010-02-05 14:02')),
        FhirDateTimeText(FhirDateTime('2010-02')),
        const Spacer(),
        Text('Germany', style: Theme.of(context).textTheme.headline6),
        FhirDateTimeText(
          FhirDateTime('2010-02-05 14:02'),
          locale: const Locale('de', 'DE'),
        ),
        const Spacer(),
        Text('Japan', style: Theme.of(context).textTheme.headline6),
        FhirDateTimeText(
          FhirDateTime('2010-02'),
          locale: const Locale('ja', 'JP'),
        ),
        FhirDateTimeText(
          FhirDateTime('2010-02-05 14:02'),
          locale: const Locale('ja', 'JP'),
        ),
        const Spacer(),
        Text('Bahrain', style: Theme.of(context).textTheme.headline6),
        FhirDateTimeText(
          FhirDateTime('2010-02-05 14:02'),
          locale: const Locale('ar', 'BH'),
        ),
      ],
    );
  }

  @override
  String get title => 'Primitives';
}
