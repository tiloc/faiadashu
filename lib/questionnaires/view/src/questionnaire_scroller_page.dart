import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:flutter/material.dart';

/// A [QuestionnaireScroller] with a scaffold.
///
/// Fills up the entire page, provides default navigation, help button.
class QuestionnaireScrollerPage extends StatelessWidget {
  final Locale? locale;
  final FhirResourceProvider fhirResourceProvider;
  final LaunchContext launchContext;
  final Widget? floatingActionButton;
  final List<Widget>? persistentFooterButtons;
  final List<Aggregator<dynamic>>? aggregators;
  final void Function(BuildContext context, Uri url)? onLinkTap;
  final QuestionnaireModelDefaults questionnaireModelDefaults;

  const QuestionnaireScrollerPage({
    this.locale,
    required this.fhirResourceProvider,
    required this.launchContext,
    this.floatingActionButton,
    this.persistentFooterButtons,
    this.aggregators,
    this.onLinkTap,
    this.questionnaireModelDefaults = const QuestionnaireModelDefaults(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScroller(
      locale: locale,
      scaffoldBuilder: DefaultQuestionnairePageScaffoldBuilder(
        // Progress can only be shown instead of a FAB
        floatingActionButton: floatingActionButton ??
            (QuestionnaireTheme.of(context).showProgress
                ? Builder(
                    builder: (context) =>
                        const QuestionnaireFillerCircularProgress(),
                  )
                : null),
        persistentFooterButtons: persistentFooterButtons,
      ),
      fhirResourceProvider: fhirResourceProvider,
      launchContext: launchContext,
      aggregators: aggregators,
      onLinkTap: onLinkTap,
      questionnaireModelDefaults: questionnaireModelDefaults,
      key: key,
    );
  }
}
