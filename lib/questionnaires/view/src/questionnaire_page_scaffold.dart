import 'package:faiadashu/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../questionnaires.dart';

/// Builder class to create a wrapper around a questionnaire filler.
abstract class QuestionnairePageScaffoldBuilder {
  const QuestionnairePageScaffoldBuilder();

  /// Builds a scaffold, or some other wrapper
  ///
  /// The returned [Widget] needs to wrapper the provided [child].
  ///
  /// The [setStateCallback] can be invoked to get access to `setState` of the
  /// parent. This might be required to work with dialogs.
  Widget build(BuildContext context,
      {required void Function(void Function()) setStateCallback,
      required Widget child});
}

/// Default implementation, builds a scaffold with useful buttons.
class DefaultQuestionnairePageScaffoldBuilder
    implements QuestionnairePageScaffoldBuilder {
  final Widget? floatingActionButton;
  final List<Widget>? persistentFooterButtons;

  const DefaultQuestionnairePageScaffoldBuilder(
      {this.floatingActionButton, this.persistentFooterButtons});

  @override
  Widget build(BuildContext context,
      {Locale? locale,
      required void Function(void Function()) setStateCallback,
      required Widget child}) {
    final theLocale = locale ?? Localizations.localeOf(context);

    final questionnaireFiller = QuestionnaireFiller.of(context);
    final questionnaire = questionnaireFiller.questionnaireModel.questionnaire;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: Text(
              questionnaire.title ??
                  FDashLocalizations.of(context).questionnaireGenericTitle,
              maxLines: 2,
              softWrap: true,
            ),
          ),
          const Spacer(),
          IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                showQuestionnaireInfo(context, theLocale, questionnaire,
                    (context) {
                  setStateCallback.call(() {
                    Navigator.pop(context);
                  });
                });
              })
        ]),
      ),
      endDrawer: const NarrativeDrawer(),
      floatingActionButton: floatingActionButton,
      persistentFooterButtons: persistentFooterButtons,
      body: SafeArea(child: child),
    );
  }
}
