import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../fhir_types/fhir_types.dart';
import '../model/aggregation/narrative_aggregator.dart';
import '../model/aggregation/questionnaire_response_aggregator.dart';
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
                builder: (context) => Column(children: [
                  SwitchListTile(
                    title: Text(
                      !_drawerMode ? 'Narrative' : 'FHIR R4 JSON',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    secondary: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                                text: _drawerMode
                                    ? jsonEncode(QuestionnaireFiller.of(context)
                                        .aggregator<
                                            QuestionnaireResponseAggregator>()
                                        .aggregate(locale)
                                        ?.toJson())
                                    : QuestionnaireFiller.of(context)
                                        .aggregator<NarrativeAggregator>()
                                        .aggregate(locale)
                                        ?.div))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: _drawerMode
                                  ? const Text(
                                      'QuestionnaireResponse copied to clipboard')
                                  : const Text(
                                      'Narrative copied to clipboard')));
                        });
                      },
                    ),
                    value: _drawerMode,
                    onChanged: (newState) {
                      setState(() {
                        _drawerMode = newState;
                      });
                    },
                  ),
                  if (!_drawerMode)
                    HTML.toRichText(
                        context,
                        QuestionnaireFiller.of(context)
                                .aggregator<NarrativeAggregator>()
                                .aggregate(locale)
                                ?.div ??
                            NarrativeAggregator.emptyNarrative.div,
                        defaultTextStyle: Theme.of(context).textTheme.bodyText1)
                  else
                    ResourceJsonTree(
                      QuestionnaireFiller.of(context)
                          .aggregator<QuestionnaireResponseAggregator>()
                          .aggregate(locale)
                          ?.toJson(),
                    ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
