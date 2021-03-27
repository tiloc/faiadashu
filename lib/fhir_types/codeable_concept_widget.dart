import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import 'fhir_types_extensions.dart';

class CodeableConceptWidget extends StatelessWidget {
  final Widget _widget;

  CodeableConceptWidget(CodeableConcept _codeableConcept,
      {TextStyle? style, Key? key})
      : _widget = Text(
          _codeableConcept.safeDisplay,
          key: key,
          style: style,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}
