import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

/// Fill a questionnaire through a wizard-style series of individual questions.
class QuestionnaireStepper extends StatefulWidget {
  final Locale? locale;
  final FhirResourceProvider fhirResourceProvider;
  final QuestionnairePageScaffoldBuilder scaffoldBuilder;
  final QuestionnaireTheme questionnaireTheme;

  const QuestionnaireStepper({
    this.locale,
    required this.scaffoldBuilder,
    required this.fhirResourceProvider,
    this.questionnaireTheme = const QuestionnaireTheme(),
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionnaireStepperState();
}

class _QuestionnaireStepperState extends State<QuestionnaireStepperPage> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return QuestionnaireFiller(
      locale: widget.locale ?? Localizations.localeOf(context),
      fhirResourceProvider: widget.fhirResourceProvider,
      questionnaireTheme: widget.questionnaireTheme,
      builder: (BuildContext context) {
        final questionnaireFiller = QuestionnaireFiller.of(context);
        final itemCount = questionnaireFiller.questionnaireItemModels.length;
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
                      return QuestionnaireFiller.of(context)
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
                          valueListenable: QuestionnaireFiller.of(context)
                              .aggregator<TotalScoreAggregator>(),
                        ),
                        if (widget.questionnaireTheme.showProgress)
                          QuestionnaireFillerProgressBar(
                            questionnaireFiller.questionnaireModel,
                          ),
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

class QuestionnaireStepperPage extends QuestionnaireStepper {
  const QuestionnaireStepperPage({
    Locale? locale,
    required FhirResourceProvider fhirResourceProvider,
    QuestionnaireTheme questionnaireTheme = const QuestionnaireTheme(),
    Key? key,
  }) : super(
          locale: locale,
          scaffoldBuilder: const DefaultQuestionnairePageScaffoldBuilder(),
          fhirResourceProvider: fhirResourceProvider,
          questionnaireTheme: questionnaireTheme,
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _QuestionnaireStepperState();
}
