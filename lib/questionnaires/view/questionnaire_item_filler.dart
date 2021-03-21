import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../questionnaires.dart';

class QuestionnaireItemFiller extends StatefulWidget {
  final Widget _titleWidget;
  final QuestionnaireLocation location;
  final QuestionnaireResponseFiller _responseFiller;
  late final String logTag;

  // TODO(tiloc): Should a key be created?
  factory QuestionnaireItemFiller.fromQuestionnaireItem(
      QuestionnaireLocation location) {
    return QuestionnaireItemFiller._(
        location, QuestionnaireResponseFiller(location));
  }

  QuestionnaireItemFiller._(this.location, this._responseFiller, {Key? key})
      : _titleWidget = QuestionnaireItemFillerTitleWidget(location),
        // ignore: no_runtimetype_tostring
        super(key: key) {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
  }

  @override
  State<StatefulWidget> createState() => QuestionnaireItemFillerState();
}

class QuestionnaireItemFillerState extends State<QuestionnaireItemFiller> {
  @override
  Widget build(BuildContext context) {
    developer.log(
        'build ${widget.location.linkId} hidden: ${widget.location.isHidden}, enabled: ${widget.location.enabled}',
        level: LogLevel.debug);
    final displayCategory = widget.location.questionnaireItem.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory')
        ?.valueCodeableConcept
        ?.coding
        ?.firstOrNull
        ?.code
        ?.value;
    final leading = (displayCategory == 'instructions')
        ? const Icon(Icons.info)
        : (displayCategory == 'security')
            ? const Icon(Icons.lock)
            : null;
    return (!widget.location.isHidden)
        ? AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: widget.location.enabled
                ? ListTile(
                    leading: leading,
                    title: widget._titleWidget,
                    subtitle: widget._responseFiller,
                  )
                : const SizedBox())
        : const SizedBox();
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
