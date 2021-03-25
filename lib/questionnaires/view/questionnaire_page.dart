import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../questionnaires.dart';

/// Base for full-page widgets to fill a questionnaire.
/// Provides async loading of questionnaire.
abstract class QuestionnairePage extends StatefulWidget {
  final Future<QuestionnaireTopLocation> Function(dynamic param) loaderFuture;
  final dynamic loaderParam;

  // TODO: Should this rather be a part of QuestionnaireFiller????
  static Future<QuestionnaireTopLocation> _loadFromAsset(
      dynamic assetPath) async {
    final instrumentString = await rootBundle.loadString(assetPath.toString());
    final jsonQuestionnaire =
        json.decode(instrumentString) as Map<String, dynamic>;
    return QuestionnaireTopLocation.fromQuestionnaire(
      Questionnaire.fromJson(jsonQuestionnaire),
      aggregators: [
        TotalScoreAggregator(),
        NarrativeAggregator(),
        QuestionnaireResponseAggregator()
      ],
    );
  }

  const QuestionnairePage.fromAsset(this.loaderParam, {Key? key})
      // ignore: avoid_field_initializers_in_const_classes
      : loaderFuture = _loadFromAsset,
        super(key: key);
}

abstract class QuestionnairePageState<T extends QuestionnairePage>
    extends State<T> {
  late final String logTag;
  late final Future<QuestionnaireTopLocation> builderFuture;

  @override
  void initState() {
    super.initState();
    builderFuture = widget.loaderFuture.call(widget.loaderParam);
  }

  QuestionnairePageState() {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
  }
}
