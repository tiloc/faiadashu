import 'package:faiadashu/questionnaires/questionnaires.dart'
    show
        NarrativeAggregator,
        QuestionnaireResponseFiller,
        QuestionnaireResponseModel;
import 'package:faiadashu/questionnaires/view/src/webview_none.dart'
    if (dart.library.io) 'package:faiadashu/questionnaires/view/src/webview_io.dart'
    if (dart.library.html) 'package:faiadashu/questionnaires/view/src/webview_html.dart';
import 'package:fhir/r4/special_types/special_types.dart';
import 'package:flutter/material.dart';

/// Display a narrative
class NarrativeTile extends StatefulWidget {
  final QuestionnaireResponseModel? questionnaireResponseModel;
  final Narrative? narrative;

  /// Construct a tile to show a narrative.
  ///
  /// Preferable, it will take the narrative from [narrative].
  /// Otherwise it will take the [questionnaireResponseModel], or locate
  /// one in the widget tree, and aggregate a narrative.
  const NarrativeTile({
    this.questionnaireResponseModel,
    this.narrative,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NarrativeTileState();
}

class _NarrativeTileState extends State<NarrativeTile> {
  late Widget _narrativeHtmlView;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final narrative = widget.narrative;

    String? div;

    if (narrative != null) {
      div = narrative.div;
    } else {
      final questionnaireResponseModel = widget.questionnaireResponseModel ??
          QuestionnaireResponseFiller.of(context).questionnaireResponseModel;
      div = questionnaireResponseModel
          .aggregator<NarrativeAggregator>()
          .aggregate()
          ?.div;
    }

    div ??= NarrativeAggregator.emptyNarrative.div;

    _narrativeHtmlView = createWebView(div);
  }

  @override
  Widget build(BuildContext context) {
    return _narrativeHtmlView;
  }
}
