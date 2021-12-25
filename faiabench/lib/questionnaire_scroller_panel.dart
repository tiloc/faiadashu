import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fhir_resource.dart';
import 'fhir_resource_notifier.dart';

class QuestionnaireScrollerPanel extends ConsumerStatefulWidget {
  final Questionnaire questionnaire;
  final QuestionnaireResponse? questionnaireResponse;
  final LaunchContext launchContext;
  final StateNotifierProvider<FhirResourceNotifier, AsyncValue<FhirResource>>
      fillerOutputProvider;

  const QuestionnaireScrollerPanel(
    this.questionnaire,
    this.questionnaireResponse,
    this.launchContext,
    this.fillerOutputProvider, {
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuestionnaireScrollerPanelState createState() =>
      _QuestionnaireScrollerPanelState();
}

class _QuestionnaireScrollerPanelState
    extends ConsumerState<QuestionnaireScrollerPanel> {
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

  void _handleChangedQuestionnaireResponse(
    QuestionnaireResponseModel? questionnaireResponseModel,
  ) {
    final questionnaireResponse =
        questionnaireResponseModel?.createQuestionnaireResponse();

    final FhirResource resource = (questionnaireResponse != null)
        ? FhirResource.fromResource(questionnaireResponse)
        : emptyFhirResource;

    ref.read(widget.fillerOutputProvider.notifier).updateFhirResource(resource);
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScroller(
      fhirResourceProvider: _fhirResourceProvider,
      scaffoldBuilder: const _FaiabenchFillerScaffoldBuilder(),
      launchContext: widget.launchContext,
      onQuestionnaireResponseChanged: _handleChangedQuestionnaireResponse,
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
