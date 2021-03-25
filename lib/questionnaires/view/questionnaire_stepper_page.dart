import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';

import '../questionnaires.dart';
import 'questionnaire_page.dart';

/// Fill a questionnaire through a wizard-style series of individual questions.
class QuestionnaireStepperPage extends QuestionnairePage {
  const QuestionnaireStepperPage.fromAsset(loaderParam, {Key? key})
      : super.fromAsset(loaderParam, key: key);

  @override
  State<StatefulWidget> createState() => _QuestionnaireStepperState();
}

class _QuestionnaireStepperState
    extends QuestionnairePageState<QuestionnaireStepperPage> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return FutureBuilder<QuestionnaireTopLocation>(
        future: builderFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return QuestionnaireFiller(snapshot.data!,
                child: Builder(
                    builder: (BuildContext context) => Scaffold(
                        appBar: AppBar(
                          title: Text(
                              snapshot.data!.questionnaire.title ?? 'Untitled'),
                        ),
                        body: Column(children: [
                          Expanded(
                            child: PageView(
                              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                              /// Use [Axis.vertical] to scroll vertically.
                              controller: controller,
                              children:
                                  QuestionnaireFiller.of(context).itemFillers(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => controller.previousPage(
                                    curve: Curves.easeIn,
                                    duration:
                                        const Duration(milliseconds: 250)),
                              ),
                              ValueListenableBuilder<Decimal>(
                                builder: (BuildContext context, Decimal value,
                                    Widget? child) {
                                  return Text(
                                    'Score: ${value.value!.round().toString()}',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  );
                                },
                                valueListenable: QuestionnaireFiller.of(context)
                                    .aggregator<TotalScoreAggregator>(),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () => controller.nextPage(
                                    curve: Curves.easeIn,
                                    duration:
                                        const Duration(milliseconds: 250)),
                              ),
                            ],
                          ),
                        ]))));
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
