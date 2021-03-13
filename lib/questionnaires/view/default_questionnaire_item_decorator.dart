import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../questionnaires.dart';

@immutable
class DefaultQuestionnaireItemDecorator extends QuestionnaireItemDecorator {
  const DefaultQuestionnaireItemDecorator();

  @override
  Widget build(BuildContext context, QuestionnaireLocation location,
      {required Widget body}) {
    final titleText = location.text;

    if (titleText != null) {
      final titleWidget = (titleText.contains('</'))
          ? HTML.toRichText(context, titleText)
          : Text(titleText,
              style: (location.level == 0)
                  ? Theme.of(context).textTheme.headline4
                  : Theme.of(context).textTheme.headline5);

      return ListTile(
        title: titleWidget,
        subtitle: body,
      );
    } else {
      return body;
    }
  }
}
