import 'package:flutter/material.dart';

import '../../model/model.dart';

/// A progress bar for the filling of a [QuestionnaireResponseModel].
class QuestionnaireFillerProgressBar extends StatefulWidget {
  final QuestionnaireResponseModel questionnaireResponseModel;
  final double? height;
  final Color? answeredColor;
  final Color? unansweredColor;

  const QuestionnaireFillerProgressBar(
    this.questionnaireResponseModel, {
    this.height,
    this.answeredColor,
    this.unansweredColor,
    Key? key,
  }) : super(key: key);

  @override
  _QuestionnaireFillerProgressBarState createState() =>
      _QuestionnaireFillerProgressBarState();
}

class _QuestionnaireFillerProgressBarState
    extends State<QuestionnaireFillerProgressBar> {
  @override
  void initState() {
    super.initState();
    widget.questionnaireResponseModel.addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.questionnaireResponseModel.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    if (mounted) {
      setState(() {
        // Just rebuild.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.questionnaireResponseModel
          .orderedResponseItemModels()
          .where((rim) => rim.isAnswerable)
          .map<Widget>((rim) {
        final theme = Theme.of(context);
        final height = widget.height ?? 4.0;
        final box = (rim.isAnswered)
            ? Container(
                height: height,
                color: widget.answeredColor ?? theme.colorScheme.secondary,
              )
            : Container(
                foregroundDecoration: BoxDecoration(
                  border: Border.all(color: theme.disabledColor, width: 0.5),
                ),
                height: height,
                color: widget.unansweredColor,
              );

        return Expanded(child: box);
      }).toList(growable: false),
    );
  }
}
