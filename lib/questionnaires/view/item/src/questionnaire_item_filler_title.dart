import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

class QuestionnaireItemFillerTitle extends StatelessWidget {
  final Widget? leading;
  final Widget? help;
  final String htmlTitleText;
  final String semanticsLabel;
  final QuestionnaireTheme questionnaireTheme;

  const QuestionnaireItemFillerTitle._({
    required this.questionnaireTheme,
    required this.htmlTitleText,
    this.leading,
    this.help,
    required this.semanticsLabel,
    Key? key,
  }) : super(key: key);

  static Widget? fromFillerItem({
    required FillerItemModel fillerItem,
    required QuestionnaireTheme questionnaireTheme,
    Key? key,
  }) {
    final questionnaireItemModel = fillerItem.questionnaireItemModel;
    final text = questionnaireItemModel.text;

    if (text == null) {
      return null;
    } else {
      final leading =
          _QuestionnaireItemFillerTitleLeading.fromFillerItem(fillerItem);
      final help = _createHelp(questionnaireItemModel);

      final requiredTag = (questionnaireItemModel.isRequired) ? '*' : '';

      final openStyleTag = (questionnaireItemModel.isGroup) ? '<h2>' : '<b>';

      final closeStyleTag =
          (questionnaireItemModel.isGroup) ? '</h2>' : '$requiredTag</b>';

      final prefixText = fillerItem.prefix;

      final htmlTitleText = (prefixText != null)
          ? '$openStyleTag${prefixText.xhtmlText}&nbsp;${text.xhtmlText}$closeStyleTag'
          : '$openStyleTag${text.xhtmlText}$closeStyleTag';

      return QuestionnaireItemFillerTitle._(
        questionnaireTheme: questionnaireTheme,
        htmlTitleText: htmlTitleText,
        leading: leading,
        help: help,
        semanticsLabel: text.plainText,
        key: key,
      );
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
            HTML.toTextSpan(
              context,
              htmlTitleText,
              defaultTextStyle: Theme.of(context).textTheme.bodyText1,
            ),
            if (help != null) WidgetSpan(child: help!),
          ],
        ),
        semanticsLabel: semanticsLabel,
      ),
    );
  }

  static Widget? _createHelp(
    QuestionnaireItemModel itemModel, {
    Key? key,
  }) {
    final helpItem = itemModel.helpTextItem;

    if (helpItem != null) {
      return _QuestionnaireItemFillerHelp(helpItem, key: key);
    }

    final supportLink = itemModel.questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-supportLink',
        )
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

  Future<void> _showHelp(
    BuildContext context,
    QuestionnaireItemModel questionnaireItemModel,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help'),
          content: Xhtml.fromXhtmlString(
            context,
            questionnaireItemModel.text ?? RenderingString.nullText,
            defaultTextStyle: Theme.of(context).textTheme.bodyText1,
          ),
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
      },
    );
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
        QuestionnaireResponseFiller.of(context)
            .onLinkTap
            ?.call(context, supportLink);
      },
    );
  }
}

class _QuestionnaireItemFillerTitleLeading extends StatelessWidget {
  final Widget _leadingWidget;
  const _QuestionnaireItemFillerTitleLeading._(Widget leadingWidget, {Key? key})
      : _leadingWidget = leadingWidget,
        super(key: key);

  static Widget? fromFillerItem(
    FillerItemModel fillerItemModel, {
    // ignore: unused_element
    Key? key,
  }) {
    final displayCategory = fillerItemModel.questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory',
        )
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

      return _QuestionnaireItemFillerTitleLeading._(leadingWidget);
    } else {
      final itemImageWidget = ItemMediaImage.fromQuestionnaireItem(
        fillerItemModel.questionnaireItemModel,
        height: 24.0,
      );
      if (itemImageWidget == null) {
        return null;
      }

      return _QuestionnaireItemFillerTitleLeading._(itemImageWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _leadingWidget;
  }
}
