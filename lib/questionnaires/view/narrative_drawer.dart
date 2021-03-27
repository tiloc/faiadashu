import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../model/narrative_aggregator.dart';
import '../model/questionnaire_response_aggregator.dart';
import 'questionnaire_filler.dart';

/// "Drawer" which contains the narrative for a questionnaire.
/// To be used with the drawer or endDrawer parameter of a [Scaffold].
class NarrativeDrawer extends StatefulWidget {
  const NarrativeDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NarrativeDrawerState();
}

class _NarrativeDrawerState extends State<NarrativeDrawer> {
  final ScrollController _narrativeScrollController = ScrollController();

  // false = narrative, true = JSON
  bool _drawerMode = false;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _narrativeScrollController,
          child: SingleChildScrollView(
            controller: _narrativeScrollController,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => SwitchListTile(
                  title: Text(
                    !_drawerMode
                        ? 'Narrative'
                        : 'FHIR R4 QuestionnaireResponse JSON',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: !_drawerMode
                      ? HTML.toRichText(
                          context,
                          QuestionnaireFiller.of(context)
                                  .aggregator<NarrativeAggregator>()
                                  .aggregate(locale)
                                  ?.div ??
                              NarrativeAggregator.emptyNarrative.div)
                      : Text(jsonEncode(QuestionnaireFiller.of(context)
                          .aggregator<QuestionnaireResponseAggregator>()
                          .aggregate(locale)
                          ?.toJson())),
                  value: _drawerMode,
                  onChanged: (newState) {
                    setState(() {
                      _drawerMode = newState;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
