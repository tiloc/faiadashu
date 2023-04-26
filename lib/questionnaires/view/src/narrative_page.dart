import 'package:faiadashu/faiadashu.dart';
import 'package:fhir/r4/special_types/special_types.dart';
import 'package:flutter/material.dart';

/// Display a narrative on a dedicated page.
class NarrativePage extends StatelessWidget {
  final QuestionnaireResponseModel? questionnaireResponseModel;
  final Narrative? narrative;

  /// Construct a page to show a narrative.
  ///
  /// Preferable, it will take the narrative from [narrative].
  /// Otherwise it will take the [questionnaireResponseModel], or locate
  /// one in the widget tree, and aggregate a narrative.
  const NarrativePage({
    this.questionnaireResponseModel,
    this.narrative,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FDashLocalizations.of(context).narrativePageTitle),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: NarrativeTile(
            questionnaireResponseModel: questionnaireResponseModel,
            narrative: narrative,
          ),
        ),
      ),
    );
  }
}
