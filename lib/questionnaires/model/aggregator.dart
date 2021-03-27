import 'package:flutter/material.dart';

import 'questionnaire_location.dart';

/// Aggregators can combine numerous items from a questionnaire into a combined result.
/// Examples: Total score; Narrative; QuestionnaireResponse; Percentage of answered questions
/// Some aggregators can 'autoAggregate': They update automatically when the underlying questionnaire changes.
/// More expensive or localized aggregators require manual invocations of their aggregate method.
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
  T? aggregate(Locale? locale, {bool notifyListeners = false});
}
