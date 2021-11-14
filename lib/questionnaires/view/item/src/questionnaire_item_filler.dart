import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../questionnaires.dart';

abstract class QuestionnaireItemFiller extends StatefulWidget {
  final QuestionnaireTheme questionnaireTheme;
  final FillerItemModel fillerItemModel;

  String get responseUid => fillerItemModel.nodeUid;

  QuestionnaireItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    this.fillerItemModel, {
    Key? key,
  })  : questionnaireTheme = questionnaireFiller.questionnaireTheme,
        super(key: key);
}

abstract class QuestionnaireItemFillerState<W extends QuestionnaireItemFiller>
    extends State<W> {
  static final _logger = Logger(QuestionnaireItemFillerState);
  late final Widget? _titleWidget;
  Widget? get titleWidget => _titleWidget;

  QuestionnaireFillerData? _questionnaireFiller;
  QuestionnaireTheme get questionnaireTheme => widget.questionnaireTheme;

  late final FocusNode _focusNode;
  FocusNode get focusNode => _focusNode;

  String get responseUid => widget.responseUid;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: responseUid, skipTraversal: true);

    _titleWidget = QuestionnaireItemFillerTitle.fromFillerItem(
      fillerItem: widget.fillerItemModel,
      questionnaireTheme: questionnaireTheme,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _questionnaireFiller = QuestionnaireFiller.of(context);
    _questionnaireFiller?.registerQuestionnaireItemFillerState(this);
  }

  @override
  void dispose() {
    _questionnaireFiller?.unregisterQuestionnaireItemFillerState(this);

    _focusNode.dispose();
    super.dispose();
  }

  // OPTIMIZE: Should rather QuestionnaireFiller become an InheritedNotifier?

  /// Triggers a repaint of the filler.
  ///
  /// Required for visual updates on enableWhen changes.
  void forceRebuild() {
    _logger.trace('forceRebuild()');
    setState(() {
      // Just repaint.
    });
  }

  /// Requests focus on this [QuestionnaireItemFiller].
  void requestFocus() {
    _focusNode.requestFocus();
  }
}

class QuestionnaireItemFillerTitle extends StatelessWidget {
  final Widget? leading;
  final String? questionNumeral;
  final Widget? help;
  final String htmlTitleText;
  final String semanticsLabel;
  final QuestionnaireTheme questionnaireTheme;

  const QuestionnaireItemFillerTitle._({
    required this.questionnaireTheme,
    required this.htmlTitleText,
    this.questionNumeral,
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
    final titleText = questionnaireItemModel.titleText;

    if (titleText == null) {
      return null;
    } else {
      final leading =
          QuestionnaireItemFillerTitleLeading.fromFillerItem(fillerItem);
      final help = _createHelp(questionnaireItemModel);

      final requiredTag = (questionnaireItemModel.isRequired) ? '*' : '';

      final openStyleTag = (questionnaireItemModel.isGroup) ? '<h2>' : '<b>';

      final closeStyleTag =
          (questionnaireItemModel.isGroup) ? '</h2>' : '$requiredTag</b>';

      final htmlTitleText =
          '$openStyleTag${htmlEscape.convert(titleText)}$closeStyleTag';

      // TODO: Do I need a refresh strategy? isAnswerable can change.
      final showQuestionNumerals = questionnaireTheme.showQuestionNumerals;
      final questionNumeral =
          (fillerItem is QuestionItemModel) ? fillerItem.questionNumeral : null;
      final htmlQuestionNumeral =
          (showQuestionNumerals && questionNumeral != null)
              ? '<b>$questionNumeral: <b>'
              : null;

      return QuestionnaireItemFillerTitle._(
        questionnaireTheme: questionnaireTheme,
        htmlTitleText: htmlTitleText,
        leading: leading,
        questionNumeral: htmlQuestionNumeral,
        help: help,
        semanticsLabel: titleText,
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
            /// Show question numbers (if flag set in the Questionnaire Theme)
            /// All items with the isAnswerable boolean as true will be
            /// counted, starting with 1, and regardless of grouping.
            ///
            if (questionNumeral != null)
              HTML.toTextSpan(
                context,
                questionNumeral!,
              ),
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
    final helpItem = itemModel.helpItem;

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
          content: HTML.toRichText(
            context,
            questionnaireItemModel.titleText ?? '',
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

  static Widget? fromFillerItem(
    FillerItemModel fillerItemModel, {
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

      return QuestionnaireItemFillerTitleLeading._(leadingWidget);
    } else {
      final itemImageWidget = ItemMediaImage.fromQuestionnaireItem(
        fillerItemModel.questionnaireItemModel,
        height: 24.0,
      );
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
