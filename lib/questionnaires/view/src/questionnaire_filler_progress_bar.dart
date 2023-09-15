import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

/// A progress bar for the filling of a [QuestionnaireResponseModel].
class QuestionnaireFillerProgressBar extends StatelessWidget {
  final double height;
  final Color? answeredColor;
  final Color? unansweredColor;

  static const double defaultHeight = 4.0;

  const QuestionnaireFillerProgressBar({
    this.height = defaultHeight,
    this.answeredColor,
    this.unansweredColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: QuestionnaireResponseFiller.of(context)
          .questionnaireResponseModel
          .answeredChangeNotifier,
      builder: (context, _) {
        return Row(
          children: QuestionnaireResponseFiller.of(context)
              .questionnaireResponseModel
              .orderedResponseItemModels()
              .where((rim) => rim.isAnswerable)
              .map<Widget>((rim) {
            final theme = Theme.of(context);
            final box = (rim.isAnswered)
                ? Container(
                    height: height,
                    color: answeredColor ?? theme.colorScheme.secondary,
                  )
                : Container(
                    foregroundDecoration: BoxDecoration(
                      border:
                          Border.all(color: theme.disabledColor, width: 0.5),
                    ),
                    height: height,
                    color: unansweredColor,
                  );

            return Expanded(child: box);
          }).toList(growable: false),
        );
      },
    );
  }
}
