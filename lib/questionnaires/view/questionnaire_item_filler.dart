import 'dart:developer' as developer;

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../fhir_types/fhir_types_extensions.dart';
import '../../logging/logging.dart';
import '../questionnaires.dart';

class QuestionnaireItemFiller extends StatefulWidget {
  final Widget? _titleWidget;
  final QuestionnaireLocation location;
  final QuestionnaireResponseFiller _responseFiller;
  late final String logTag;

  factory QuestionnaireItemFiller.fromQuestionnaireItem(
      QuestionnaireLocation location) {
    return QuestionnaireItemFiller._(
        // TODO: Error handling for failed response filler creation
        location,
        QuestionnaireResponseFiller(location));
  }

  QuestionnaireItemFiller._(this.location, this._responseFiller, {Key? key})
      : _titleWidget = QuestionnaireItemFillerTitle.forLocation(location),
        super(key: key) {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
  }

  @override
  State<StatefulWidget> createState() => QuestionnaireItemFillerState();
}

class QuestionnaireItemFillerState extends State<QuestionnaireItemFiller> {
  late final String logTag;

  QuestionnaireItemFillerState() {
    // ignore: no_runtimetype_tostring
    logTag = 'wof.${runtimeType.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    developer.log(
        'build ${widget.location.linkId} hidden: ${widget.location.isHidden}, enabled: ${widget.location.enabled}',
        level: LogLevel.debug,
        name: logTag);

    return (!widget.location.isHidden)
        ? AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: widget.location.enabled
                ? (MediaQuery.of(context).size.width > 1000)
                    ? Table(
                        columnWidths: {
                          0: FixedColumnWidth(
                              MediaQuery.of(context).size.width / 3.2),
                          1: FixedColumnWidth(
                              MediaQuery.of(context).size.width / 3.2 * 2)
                        },
                        children: [
                          TableRow(children: [
                            if (widget._titleWidget != null)
                              Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: widget._titleWidget)
                            else
                              Container(),
                            widget._responseFiller
                          ])
                        ],
                      )
                    : ListTile(
                        title: widget._titleWidget,
                        subtitle: widget._responseFiller,
                      )
                : const SizedBox())
        : const SizedBox();
  }
}

class QuestionnaireItemFillerTitle extends StatelessWidget {
  final QuestionnaireLocation location;
  const QuestionnaireItemFillerTitle._(this.location, {Key? key})
      : super(key: key);

  static Widget? forLocation(QuestionnaireLocation location, {Key? key}) {
    if (location.titleText == null) {
      return null;
    } else {
      return QuestionnaireItemFillerTitle._(location, key: key);
    }
  }

  @override
  Widget build(BuildContext context) {
    final leading = QuestionnaireItemFillerTitleLeading.forLocation(location);

    final styleTag =
        (location.questionnaireItem.type == QuestionnaireItemType.group)
            ? 'h2'
            : 'b';

    final titleText = location.titleText;
    return Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text.rich(
          TextSpan(children: <InlineSpan>[
            if (leading != null) WidgetSpan(child: leading),
            if (titleText != null)
              HTML.toTextSpan(context, '<$styleTag>$titleText</$styleTag>'),
          ]),
          semanticsLabel: titleText,
        ));
  }
}

class QuestionnaireItemFillerTitleLeading extends StatelessWidget {
  final QuestionnaireLocation location;
  final String category;
  const QuestionnaireItemFillerTitleLeading._(this.location, this.category,
      {Key? key})
      : super(key: key);

  static Widget? forLocation(QuestionnaireLocation location, {Key? key}) {
    final displayCategory = location.questionnaireItem.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory')
        ?.valueCodeableConcept
        ?.coding
        ?.firstOrNull
        ?.code
        ?.value;

    if (displayCategory == null) {
      return null;
    }

    return ((displayCategory == 'instructions') ||
            (displayCategory == 'security'))
        ? QuestionnaireItemFillerTitleLeading._(location, displayCategory,
            key: key)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final leading = (category == 'instructions')
        ? const Icon(Icons.info)
        : (category == 'security')
            ? const Icon(Icons.lock)
            : const Icon(Icons.help_center_outlined); // Error / unclear

    return leading;
  }
}
