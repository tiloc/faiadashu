import 'package:fhir/r4/special_types/special_types.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../model/model.dart';
import 'questionnaire_filler.dart';

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
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NarrativeTileState();
}

class _NarrativeTileState extends State<NarrativeTile> {
  late final ScrollController _narrativeScrollController;
  Widget? _narrativeRichText;

  @override
  void initState() {
    super.initState();
    _narrativeScrollController = ScrollController();
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

    _narrativeRichText = HTML.toRichText(
      context,
      div,
      defaultTextStyle: Theme.of(context).textTheme.bodyText1,
    );
  }

  @override
  void dispose() {
    _narrativeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _narrativeScrollController,
        child: SingleChildScrollView(
          controller: _narrativeScrollController,
          child: _narrativeRichText,
        ),
      ),
    );
  }
}
