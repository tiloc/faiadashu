import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

/// Fill a questionnaire through a wizard-style series of individual questions.
class QuestionnaireStepper extends StatefulWidget {
  final Locale? locale;
  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;
  final QuestionnairePageScaffoldBuilder scaffoldBuilder;
  final QuestionnaireModelDefaults questionnaireModelDefaults;

  const QuestionnaireStepper({
    this.locale,
    required this.scaffoldBuilder,
    required this.fhirResourceProvider,
    required this.launchContext,
    this.questionnaireModelDefaults = const QuestionnaireModelDefaults(),
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => QuestionnaireStepperState();
}

class QuestionnaireStepperState extends State<QuestionnaireStepper> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return QuestionnaireResponseFiller(
      locale: widget.locale ?? Localizations.localeOf(context),
      fhirResourceProvider: widget.fhirResourceProvider,
      launchContext: widget.launchContext,
      questionnaireModelDefaults: widget.questionnaireModelDefaults,
      builder: (BuildContext context) {
        final questionnaireFiller = QuestionnaireResponseFiller.of(context);
        final itemCount = questionnaireFiller.fillerItemModels.length;

        return widget.scaffoldBuilder.build(
          context,
          setStateCallback: (fn) => setState(fn),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PageView.builder(
                    /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                    /// Use [Axis.vertical] to scroll vertically.
                    controller: controller,
                    itemCount: itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return QuestionnaireResponseFiller.of(context)
                          .itemFillerAt(index);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => controller.previousPage(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ValueListenableBuilder<Decimal>(
                          builder: (
                            BuildContext context,
                            Decimal value,
                            Widget? child,
                          ) {
                            final scoreString = value.value!.round().toString();

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                FDashLocalizations.of(context)
                                    .aggregationScore(scoreString),
                                key: ValueKey<String>(scoreString),
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            );
                          },
                          valueListenable:
                              QuestionnaireResponseFiller.of(context)
                                  .aggregator<TotalScoreAggregator>(),
                        ),
                        if (QuestionnaireTheme.of(context).showProgress)
                          const QuestionnaireFillerProgressBar(),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => controller.nextPage(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
