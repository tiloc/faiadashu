import 'dart:convert';

import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// "Drawer" which contains the narrative for a questionnaire.
/// To be used with the drawer or endDrawer parameter of a [Scaffold].
class NarrativeDrawer extends StatefulWidget {
  const NarrativeDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NarrativeDrawerState();
}

class _NarrativeDrawerState extends State<NarrativeDrawer> {
  // false = narrative, true = JSON
  bool _drawerMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferredHeight = MediaQuery.of(context).size.height * 0.7;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: preferredHeight,
          minHeight: preferredHeight,
        ),
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
                      !_drawerMode
                          ? FDashLocalizations.of(context).narrativePageTitle
                          : 'FHIR R4 JSON',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    secondary: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: _drawerMode
                                ? const JsonEncoder.withIndent('    ').convert(
                                    QuestionnaireResponseFiller.of(context)
                                        .aggregator<
                                            QuestionnaireResponseAggregator>()
                                        .aggregate(containPatient: true)
                                        ?.toJson(),
                                  )
                                : QuestionnaireResponseFiller.of(context)
                                    .aggregator<NarrativeAggregator>()
                                    .aggregate()
                                    ?.div ?? '',
                          ),
                        ).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: _drawerMode
                                  ? const Text(
                                      'QuestionnaireResponse copied to clipboard',
                                    )
                                  : const Text(
                                      'Narrative copied to clipboard',
                                    ),
                            ),
                          );
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
                  Expanded(
                    child: _drawerMode
                        ? SingleChildScrollView(
                            child: ResourceJsonTree(
                              QuestionnaireResponseFiller.of(context)
                                  .aggregator<QuestionnaireResponseAggregator>()
                                  .aggregate(containPatient: true)
                                  ?.toJson(),
                            ),
                          )
                        : const NarrativeTile(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
