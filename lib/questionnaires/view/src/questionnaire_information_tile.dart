import 'package:fhir/r4.dart' show Questionnaire;
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../l10n/l10n.dart';
import 'xhtml.dart';

/// Informational tile about a [Questionnaire].
///
/// Contains information such as title and publisher.
class QuestionnaireInformationTile extends StatelessWidget {
  final Questionnaire questionnaire;
  const QuestionnaireInformationTile(this.questionnaire, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.subtitle1;
    return Column(children: [
      HTML.toRichText(
          context,
          Xhtml.toXhtml(questionnaire.title,
                  questionnaire.titleElement?.extension_) ??
              FDashLocalizations.of(context).questionnaireUnknownTitle,
          defaultTextStyle: defaultTextStyle),
      const Divider(),
      HTML.toRichText(
          context,
          Xhtml.toXhtml(questionnaire.publisher,
                  questionnaire.publisherElement?.extension_) ??
              FDashLocalizations.of(context).questionnaireUnknownPublisher,
          defaultTextStyle: defaultTextStyle),
    ]);
  }
}
