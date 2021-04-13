import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../model/aggregation/narrative_aggregator.dart';
import '../model/questionnaire_location.dart';
import 'questionnaire_filler.dart';

/// Display a narrative
class NarrativeTile extends StatefulWidget {
  final QuestionnaireTopLocation? topLocation;

  const NarrativeTile({this.topLocation, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NarrativeTileState();
}

class _NarrativeTileState extends State<NarrativeTile> {
  late final ScrollController _narrativeScrollController;

  @override
  void initState() {
    super.initState();
    _narrativeScrollController = ScrollController();
  }

  @override
  void dispose() {
    _narrativeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top =
        widget.topLocation ?? QuestionnaireFiller.of(context).topLocation;
    return Scrollbar(
        isAlwaysShown: true,
        controller: _narrativeScrollController,
        child: SingleChildScrollView(
            controller: _narrativeScrollController,
            child: HTML.toRichText(
                context,
                top.aggregator<NarrativeAggregator>().aggregate()?.div ??
                    NarrativeAggregator.emptyNarrative.div,
                defaultTextStyle: Theme.of(context).textTheme.bodyText1)));
  }
}
