import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

class QuestionnaireScrollerPanel extends StatefulWidget {
  final Questionnaire questionnaire;
  final QuestionnaireResponse? questionnaireResponse;
  final LaunchContext launchContext;

  const QuestionnaireScrollerPanel(
      this.questionnaire, this.questionnaireResponse, this.launchContext,
      {Key? key})
      : super(key: key);

  @override
  _QuestionnaireScrollerPanelState createState() =>
      _QuestionnaireScrollerPanelState();
}

class _QuestionnaireScrollerPanelState
    extends State<QuestionnaireScrollerPanel> {
  late final FhirResourceProvider _fhirResourceProvider;

  @override
  void initState() {
    super.initState();

    _fhirResourceProvider = RegistryFhirResourceProvider(
      [
        InMemoryResourceProvider.inMemory(
          questionnaireResourceUri,
          widget.questionnaire,
        ),
        InMemoryResourceProvider.inMemory(
          questionnaireResponseResourceUri,
          widget.questionnaireResponse,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScroller(
      fhirResourceProvider: _fhirResourceProvider,
      scaffoldBuilder: _FaiabenchFillerScaffoldBuilder(),
      launchContext: widget.launchContext,
    );
  }
}

class _FaiabenchFillerScaffoldBuilder extends QuestionnairePageScaffoldBuilder {
  const _FaiabenchFillerScaffoldBuilder();

  @override
  Widget build(
    BuildContext context, {
    required void Function(void Function() p1) setStateCallback,
    required Widget child,
  }) {
    return Theme(
      data: Theme.of(context),
      // We have to take care of SafeArea ourselves
      child: SafeArea(
        // This surround Card provides the Material parent that is required by
        // the QuestionnaireFiller. Other potential Material parents would be
        // Scaffolds.
        child: Card(
          // This column surrounds the scroller with whimsical add-ons
          child: Column(
            children: [
              Expanded(child: child), // This child is the actual scroller
            ],
          ),
        ),
      ),
    );
  }
}
