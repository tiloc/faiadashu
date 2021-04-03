import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logging.dart';
import '../../questionnaires.dart';

class QuestionnaireItemFiller extends StatefulWidget {
  static final logger = Logger(QuestionnaireItemFiller);
  final Widget? _titleWidget;
  final QuestionnaireLocation location;
  final QuestionnaireResponseFiller _responseFiller;

  factory QuestionnaireItemFiller.fromQuestionnaireItem(
      QuestionnaireLocation location) {
    return QuestionnaireItemFiller._(
        // TODO: Error handling for failed response filler creation
        location,
        QuestionnaireResponseFiller(location));
  }

  QuestionnaireItemFiller._(this.location, this._responseFiller, {Key? key})
      : _titleWidget = QuestionnaireItemFillerTitle.forLocation(location),
        super(key: key);

  @override
  State<StatefulWidget> createState() => QuestionnaireItemFillerState();
}

class QuestionnaireItemFillerState extends State<QuestionnaireItemFiller> {
  static final logger = Logger(QuestionnaireItemFillerState);

  @override
  Widget build(BuildContext context) {
    logger.log(
        'build ${widget.location.linkId} hidden: ${widget.location.isHidden}, enabled: ${widget.location.enabled}',
        level: LogLevel.debug);

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
    final help = QuestionnaireItemFillerHelp.forLocation(location);

    final requiredTag =
        (location.questionnaireItem.required_?.value == true) ? '*' : '';

    final openStyleTag =
        (location.questionnaireItem.type == QuestionnaireItemType.group)
            ? '<h2>'
            : '<b>';

    final closeStyleTag =
        (location.questionnaireItem.type == QuestionnaireItemType.group)
            ? '</h2>'
            : '$requiredTag</b>';

    final titleText = location.titleText;
    return Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              if (leading != null) WidgetSpan(child: leading),
              if (titleText != null)
                HTML.toTextSpan(context,
                    '$openStyleTag${htmlEscape.convert(titleText)}$closeStyleTag'),
              if (help != null) WidgetSpan(child: help),
            ],
          ),
          semanticsLabel: titleText,
        ));
  }
}

class QuestionnaireItemFillerHelp extends StatefulWidget {
  final QuestionnaireLocation ql;

  const QuestionnaireItemFillerHelp._(this.ql, {Key? key}) : super(key: key);

  static Widget? forLocation(QuestionnaireLocation location, {Key? key}) {
    final helpLocation = location.helpLocation;

    return (helpLocation != null)
        ? QuestionnaireItemFillerHelp._(helpLocation, key: key)
        : null;
  }

  @override
  State<StatefulWidget> createState() => QuestionnaireItemFillerHelpState();
}

class QuestionnaireItemFillerHelpState
    extends State<QuestionnaireItemFillerHelp> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      mouseCursor: SystemMouseCursors.help,
      color: Theme.of(context).accentColor,
      icon: const Icon(Icons.info_outline),
      onPressed: () {
        _showHelp(context, widget.ql);
      },
    );
  }

  Future<void> _showHelp(
      BuildContext context, QuestionnaireLocation questionnaireLocation) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Help'),
            content:
                HTML.toRichText(context, questionnaireLocation.titleText ?? ''),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Dismiss'),
              ),
            ],
          );
        });
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
