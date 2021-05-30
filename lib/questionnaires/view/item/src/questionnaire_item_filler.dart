import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

class QuestionnaireItemFiller extends StatefulWidget {
  final Widget? _titleWidget;
  final QuestionnaireItemModel itemModel;
  final QuestionnaireFillerData questionnaireFiller;
  late final QuestionnaireResponseFiller _responseFiller;

  factory QuestionnaireItemFiller.fromQuestionnaireFiller(
      QuestionnaireFillerData questionnaireFiller, int index,
      {Key? key}) {
    return QuestionnaireItemFiller._(questionnaireFiller,
        questionnaireFiller.questionnaireModel.itemModelAt(index),
        key: key);
  }

  QuestionnaireItemFiller._(this.questionnaireFiller, this.itemModel,
      {Key? key})
      : _titleWidget =
            QuestionnaireItemFillerTitle.fromQuestionnaireItemModel(itemModel),
        super(key: key) {
    _responseFiller =
        questionnaireFiller.viewFactory.createQuestionnaireResponseFiller(this);
  }

  @override
  State<StatefulWidget> createState() => QuestionnaireItemFillerState();
}

class QuestionnaireItemFillerState extends State<QuestionnaireItemFiller> {
  static final _logger = Logger(QuestionnaireItemFillerState);

  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode =
        FocusNode(debugLabel: widget.itemModel.linkId, skipTraversal: true);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  /// Requests focus on this [QuestionnaireItemFiller].
  void requestFocus() {
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    _logger.trace(
        'build ${widget.itemModel.linkId} hidden: ${widget.itemModel.isHidden}, enabled: ${widget.itemModel.isEnabled}');

    return (!widget.itemModel.isHidden)
        ? Focus(
            focusNode: _focusNode,
            onFocusChange: (gainedFocus) {
              debugDumpFocusTree();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: widget.itemModel.isEnabled
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
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget._titleWidget != null)
                              Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: widget._titleWidget),
                            widget._responseFiller,
                          ],
                        )
                  : const SizedBox(),
            ),
          )
        : const SizedBox();
  }
}

class QuestionnaireItemFillerTitle extends StatelessWidget {
  final QuestionnaireItemModel itemModel;
  final Widget? leading;
  final Widget? help;
  final String htmlTitleText;

  const QuestionnaireItemFillerTitle._(
      this.itemModel, this.htmlTitleText, this.leading, this.help,
      {Key? key})
      : super(key: key);

  static Widget? fromQuestionnaireItemModel(QuestionnaireItemModel itemModel,
      {Key? key}) {
    if (itemModel.titleText == null) {
      return null;
    } else {
      final leading =
          QuestionnaireItemFillerTitleLeading.fromQuestionnaireItem(itemModel);
      final help =
          _QuestionnaireItemFillerHelpFactory.fromQuestionnaireItem(itemModel);

      final requiredTag =
          (itemModel.questionnaireItem.required_?.value == true) ? '*' : '';

      final openStyleTag =
          (itemModel.questionnaireItem.type == QuestionnaireItemType.group)
              ? '<h2>'
              : '<b>';

      final closeStyleTag =
          (itemModel.questionnaireItem.type == QuestionnaireItemType.group)
              ? '</h2>'
              : '$requiredTag</b>';

      final htmlTitleText =
          '$openStyleTag${htmlEscape.convert(itemModel.titleText!)}$closeStyleTag';

      return QuestionnaireItemFillerTitle._(
          itemModel, htmlTitleText, leading, help,
          key: key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.only(top: 8.0),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              if (leading != null) WidgetSpan(child: leading!),
              if (itemModel.titleText != null)
                HTML.toTextSpan(context, htmlTitleText,
                    defaultTextStyle: Theme.of(context).textTheme.bodyText1),
              if (help != null) WidgetSpan(child: help!),
            ],
          ),
          semanticsLabel: itemModel.titleText,
        ));
  }
}

class _QuestionnaireItemFillerHelpFactory {
  static Widget? fromQuestionnaireItem(QuestionnaireItemModel itemModel,
      {Key? key}) {
    final helpItem = itemModel.helpItem;

    if (helpItem != null) {
      return _QuestionnaireItemFillerHelp(helpItem, key: key);
    }

    final supportLink = itemModel.questionnaireItem.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-supportLink')
        ?.valueUri
        ?.value;

    if (supportLink != null) {
      return _QuestionnaireItemFillerSupportLink(supportLink, key: key);
    }

    return null;
  }
}

class _QuestionnaireItemFillerHelp extends StatefulWidget {
  final QuestionnaireItemModel ql;

  const _QuestionnaireItemFillerHelp(this.ql, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuestionnaireItemFillerHelpState();
}

class _QuestionnaireItemFillerHelpState
    extends State<_QuestionnaireItemFillerHelp> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      mouseCursor: SystemMouseCursors.help,
      color: Theme.of(context).colorScheme.secondary,
      icon: const Icon(Icons.info_outline),
      onPressed: () {
        _showHelp(context, widget.ql);
      },
    );
  }

  Future<void> _showHelp(BuildContext context,
      QuestionnaireItemModel questionnaireItemModel) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Help'),
            content: HTML.toRichText(
                context, questionnaireItemModel.titleText ?? '',
                defaultTextStyle: Theme.of(context).textTheme.bodyText1),
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

class _QuestionnaireItemFillerSupportLink extends StatelessWidget {
  static final _logger = Logger(_QuestionnaireItemFillerSupportLink);
  final Uri supportLink;

  const _QuestionnaireItemFillerSupportLink(this.supportLink, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      mouseCursor: SystemMouseCursors.help,
      color: Theme.of(context).colorScheme.secondary,
      icon: const Icon(Icons.info_outline),
      onPressed: () {
        _logger.debug("supportLink '${supportLink.toString()}'");
        QuestionnaireFiller.of(context).onLinkTap?.call(context, supportLink);
      },
    );
  }
}

class QuestionnaireItemFillerTitleLeading extends StatelessWidget {
  final Widget _leadingWidget;
//  static final _logger = Logger(QuestionnaireItemFillerTitleLeading);

  const QuestionnaireItemFillerTitleLeading._(Widget leadingWidget, {Key? key})
      : _leadingWidget = leadingWidget,
        super(key: key);

  static Widget? fromQuestionnaireItem(QuestionnaireItemModel itemModel,
      {Key? key}) {
    final displayCategory = itemModel.questionnaireItem.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory')
        ?.valueCodeableConcept
        ?.coding
        ?.firstOrNull
        ?.code
        ?.value;

    if (displayCategory != null) {
      final leadingWidget = (displayCategory == 'instructions')
          ? const Icon(Icons.info)
          : (displayCategory == 'security')
              ? const Icon(Icons.lock)
              : const Icon(Icons.help_center_outlined); // Error / unclear

      return QuestionnaireItemFillerTitleLeading._(leadingWidget);
    } else {
      final itemImageWidget =
          CpgItemImage.fromQuestionnaireItem(itemModel, height: 24.0);
      if (itemImageWidget == null) {
        return null;
      }
      return QuestionnaireItemFillerTitleLeading._(itemImageWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _leadingWidget;
  }
}
