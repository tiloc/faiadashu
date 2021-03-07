import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:widgets_on_fhir/questionnaires/questionnaires.dart';

import 'phq9_instrument.dart';

class QuestionnaireStepperPage extends StatefulWidget {
  QuestionnaireStepperPage({Key? key}) : super(key: key);

  final locations = QuestionnaireLocation(Questionnaire.fromJson(
          json.decode(Phq9Instrument.phq9Instrument) as Map<String, dynamic>))
      .preOrder();

  @override
  State<StatefulWidget> createState() => _QuestionnaireStepperState();
}

class _QuestionnaireStepperState extends State<QuestionnaireStepperPage> {
  static const QuestionnaireItemDecorator _decorator = _ItemDecorator();

  int step = 0;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.locations.elementAt(0).questionnaire.title ?? 'Untitled'),
        ),
        body: Column(children: [
          Expanded(
            child: PageView(
              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
              /// Use [Axis.vertical] to scroll vertically.
              controller: controller,
              children: widget.locations
                  .map<Widget>((location) =>
                      QuestionnaireItemWidgetFactory.fromQuestionnaireItem(
                          location, _decorator))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => controller.previousPage(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 250)),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => controller.nextPage(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 250)),
              ),
            ],
          ),
        ]));
  }
}

@immutable
class _ItemDecorator extends QuestionnaireItemDecorator {
  const _ItemDecorator();

  @override
  Widget build(BuildContext context, QuestionnaireLocation location,
      {required Widget body}) {
    return ListTile(
      title: Text(location.questionnaireItem.text!,
          style: (location.level == 0)
              ? Theme.of(context).textTheme.headline5
              : Theme.of(context).textTheme.headline6),
      subtitle: body,
    );
  }
}
