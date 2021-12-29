import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:flutter/material.dart';

/// A [QuestionnaireScroller] with a scaffold.
///
/// Fills up the entire page, provides default navigation, help button.
class QuestionnaireScrollerPage extends QuestionnaireScroller {
  QuestionnaireScrollerPage({
    Locale? locale,
    required FhirResourceProvider fhirResourceProvider,
    required LaunchContext launchContext,
    Widget? floatingActionButton,
    List<Widget>? persistentFooterButtons,
    List<Aggregator<dynamic>>? aggregators,
    void Function(BuildContext context, Uri url)? onLinkTap,
    QuestionnaireTheme questionnaireTheme = const QuestionnaireTheme(),
    QuestionnaireModelDefaults questionnaireModelDefaults =
        const QuestionnaireModelDefaults(),
    Key? key,
  }) : super(
          locale: locale,
          scaffoldBuilder: DefaultQuestionnairePageScaffoldBuilder(
            // Progress can only be shown instead of a FAB
            floatingActionButton: floatingActionButton ??
                (questionnaireTheme.showProgress
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
          questionnaireTheme: questionnaireTheme,
          questionnaireModelDefaults: questionnaireModelDefaults,
          key: key,
        );
}
