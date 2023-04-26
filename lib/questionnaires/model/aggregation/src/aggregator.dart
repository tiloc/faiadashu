import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:flutter/material.dart';

/// Aggregators can combine numerous items from a questionnaire into a combined result.
/// Examples: Total score; Narrative; QuestionnaireResponse; Percentage of answered questions
/// Some aggregators can 'autoAggregate': They update automatically when the underlying questionnaire response changes.
/// More expensive aggregators require manual invocations of their aggregate method.
abstract class Aggregator<T> extends ValueNotifier<T> {
  late final QuestionnaireResponseModel questionnaireResponseModel;
  late final Locale locale;
  final bool autoAggregate;

  /// [autoAggregate] specifies whether it should attach listeners to the
  /// questionnaire and aggregate when the questionnaire changes.
  Aggregator(super.initialValue, {this.autoAggregate = true});

  // ignore: use_setters_to_change_properties
  /// Initialize the aggregator.
  @mustCallSuper
  void init(QuestionnaireResponseModel questionnaireResponseModel) {
    this.questionnaireResponseModel = questionnaireResponseModel;
    locale = questionnaireResponseModel.locale;
  }

  /// Aggregate the questionnaire. Return [null] if currently not possible.
  T? aggregate({bool notifyListeners = false});
}
