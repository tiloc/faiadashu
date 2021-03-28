import 'package:fhir/r4.dart' show Questionnaire;
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import 'xhtml.dart';

class QuestionnaireCoverPage extends StatelessWidget {
  final Questionnaire questionnaire;
  const QuestionnaireCoverPage(this.questionnaire, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HTML.toRichText(
          context,
          Xhtml.toXhtml(questionnaire.title,
                  questionnaire.titleElement?.extension_) ??
              'Untitled'),
      HTML.toRichText(
          context,
          Xhtml.toXhtml(questionnaire.publisher,
                  questionnaire.publisherElement?.extension_) ??
              'Unknown publisher'),
    ]);
  }
}
