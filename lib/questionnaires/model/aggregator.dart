import 'package:flutter/material.dart';

import 'questionnaire_location.dart';

abstract class Aggregator<T> extends ValueNotifier<T> {
  late final QuestionnaireTopLocation topLocation;
  final bool autoAggregate;

  /// [autoAggregate] specifies whether it should attach listeners to the
  /// questionnaire and aggregate when the questionnaire changes.
  Aggregator(T initialValue, {this.autoAggregate = true}) : super(initialValue);

  // ignore: use_setters_to_change_properties
  /// Initialize the aggregator.
  @mustCallSuper
  void init(QuestionnaireTopLocation topLocation) {
    this.topLocation = topLocation;
  }

  /// Aggregate the questionnaire. Return [null] if currently not possible.
  T? aggregate({bool notifyListeners = false});
}
