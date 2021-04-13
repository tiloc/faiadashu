import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../fhir_types/fhir_types.dart';
import '../model/aggregation/narrative_aggregator.dart';
import '../model/aggregation/questionnaire_response_aggregator.dart';
import '../questionnaires.dart';
import 'questionnaire_filler.dart';

/// "Drawer" which contains the narrative for a questionnaire.
/// To be used with the drawer or endDrawer parameter of a [Scaffold].
class NarrativeDrawer extends StatefulWidget {
  const NarrativeDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NarrativeDrawerState();
}

class _NarrativeDrawerState extends State<NarrativeDrawer> {
  late final ScrollController _responseScrollController;

  // false = narrative, true = JSON
  bool _drawerMode = false;

  @override
  void initState() {
    super.initState();
    _responseScrollController = ScrollController();
  }

  @override
  void dispose() {
    _responseScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferredHeight = MediaQuery.of(context).size.height * 0.7;
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: preferredHeight, minHeight: preferredHeight),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                    key: UniqueKey(),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        key: UniqueKey(),
                        title: Text(
                          !_drawerMode ? 'Narrative' : 'FHIR R4 JSON',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        secondary: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: _drawerMode
                                        ? jsonEncode(QuestionnaireFiller.of(
                                                context)
                                            .aggregator<
                                                QuestionnaireResponseAggregator>()
                                            .aggregate()
                                            ?.toJson())
                                        : QuestionnaireFiller.of(context)
                                            .aggregator<NarrativeAggregator>()
                                            .aggregate()
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
                      const Divider(),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: preferredHeight - 100,
                              maxHeight: preferredHeight - 100),
                          child: _drawerMode
                              ? Scrollbar(
                                  isAlwaysShown: true,
                                  controller: _responseScrollController,
                                  child: SingleChildScrollView(
                                    controller: _responseScrollController,
                                    child: ResourceJsonTree(
                                      QuestionnaireFiller.of(context)
                                          .aggregator<
                                              QuestionnaireResponseAggregator>()
                                          .aggregate()
                                          ?.toJson(),
                                    ),
                                  ),
                                )
                              : const NarrativeTile()),
                    ])),
          ),
        ),
      ),
    );
  }
}
