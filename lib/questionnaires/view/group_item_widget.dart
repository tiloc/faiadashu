import 'package:fhir/r4/resource_types/clinical/diagnostics/diagnostics.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';

class GroupItemWidget extends QuestionnaireItemFiller {
  const GroupItemWidget(
      QuestionnaireLocation location, QuestionnaireItemDecorator decorator,
      {Key? key})
      : super(location, decorator, key: key);
  @override
  State<StatefulWidget> createState() => _GroupItemState();
}

class _GroupItemState extends QuestionnaireItemState {
  _GroupItemState() : super(null);

  @override
  Widget buildBodyReadOnly(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }

  @override
  QuestionnaireResponseAnswer? createAnswer() {
    // Not required for a static item
    throw UnimplementedError();
  }

  @override
  Widget buildBodyEditable(BuildContext context) {
    // Not required for a read-only item
    throw UnimplementedError();
  }
}
