import 'package:flutter/material.dart';

import 'questionnaire_location.dart';

abstract class Aggregator<T> extends ValueNotifier<T> {
  late final QuestionnaireLocation top;

  Aggregator(T initialValue) : super(initialValue);
  // ignore: use_setters_to_change_properties
  @mustCallSuper
  void init(QuestionnaireLocation location) {
    top = location;
  }
}
