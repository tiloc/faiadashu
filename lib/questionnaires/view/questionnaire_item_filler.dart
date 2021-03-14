import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../questionnaires.dart';

class QuestionnaireItemFiller extends StatefulWidget {
  final Widget _titleWidget;
  final QuestionnaireLocation location;
  final QuestionnaireResponseFiller _responseFiller;

  // TODO(tiloc): Should a key be created?
  factory QuestionnaireItemFiller.fromQuestionnaireItem(
      QuestionnaireLocation location) {
    return QuestionnaireItemFiller._(
        location, QuestionnaireResponseFiller(location));
  }

  QuestionnaireItemFiller._(this.location, this._responseFiller, {Key? key})
      : _titleWidget = QuestionnaireItemFillerTitleWidget(location),
        super(key: key);

  @override
  State<StatefulWidget> createState() => QuestionnaireItemFillerState();
}

class QuestionnaireItemFillerState extends State<QuestionnaireItemFiller> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: widget.location.enabled
            ? ListTile(
                title: widget._titleWidget,
                subtitle: widget._responseFiller,
              )
            : const SizedBox());
  }
}

class QuestionnaireItemFillerTitleWidget extends StatelessWidget {
  final QuestionnaireLocation location;
  const QuestionnaireItemFillerTitleWidget(this.location, {Key? key})
      : super(key: key);

  TextStyle? _styleForLevel(BuildContext context, int level) {
    final textTheme = Theme.of(context).textTheme;
    switch (level) {
      case 0:
        return textTheme.headline4;
      case 1:
        return textTheme.headline5;
      case 2:
        return textTheme.headline6;
      default:
        return textTheme.subtitle1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = location.text;
    return (titleText != null)
        ? (titleText.contains('</'))
            ? HTML.toRichText(context, titleText)
            : Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(titleText,
                    style: _styleForLevel(context, location.level)))
        : const SizedBox();
  }
}
