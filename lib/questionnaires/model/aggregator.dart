import 'package:flutter/material.dart';

import 'questionnaire_location.dart';

abstract class Aggregator<T> extends ValueNotifier<T> {
  late final QuestionnaireTopLocation topLocation;

  Aggregator(T initialValue) : super(initialValue);
  // ignore: use_setters_to_change_properties
  @mustCallSuper
  void init(QuestionnaireTopLocation topLocation) {
    this.topLocation = topLocation;
  }

  void aggregate();
}
