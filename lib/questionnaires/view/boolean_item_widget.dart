import 'package:fhir/r4.dart';
import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class BooleanItemWidget extends QuestionnaireItemFiller {
  const BooleanItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _BooleanItemState();
}

class _BooleanItemState
    extends QuestionnaireItemState<Boolean, BooleanItemWidget> {
  _BooleanItemState() : super(null);

  @override
  Widget buildBodyReadOnly(BuildContext context) {
    return Text(value?.toString() ?? '');
  }

  @override
  Widget buildBodyEditable(BuildContext context) {
    return Checkbox(
      value: value?.value,
      tristate: true,
      onChanged: (newValue) {
        value = (newValue != null) ? Boolean(newValue) : null;
      },
    );
  }

  @override
  QuestionnaireResponseAnswer? createAnswer() =>
      (value != null) ? QuestionnaireResponseAnswer(valueBoolean: value) : null;
}
