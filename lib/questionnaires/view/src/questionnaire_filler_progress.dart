import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:flutter/material.dart';

/// Display a progress bar for the filling of a [QuestionnaireModel].
class QuestionnaireFillerProgress extends StatefulWidget {
  final QuestionnaireItemModel questionnaireItemModel;
  final double height;

  const QuestionnaireFillerProgress(this.questionnaireItemModel,
      {this.height = 4.0, Key? key})
      : super(key: key);

  @override
  _QuestionnaireFillerProgressState createState() =>
      _QuestionnaireFillerProgressState();
}

class _QuestionnaireFillerProgressState
    extends State<QuestionnaireFillerProgress> {
  @override
  void initState() {
    super.initState();
    widget.questionnaireItemModel.questionnaireModel
        .addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.questionnaireItemModel.questionnaireModel
        .removeListener(_updateProgress);
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
      children: widget.questionnaireItemModel
          .orderedQuestionnaireItemModels()
          .where((qim) => qim.isAnswerable)
          .map<Widget>((qim) => Expanded(
                  child: Container(
                height: widget.height,
                color: qim.isAnswered
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              )))
          .toList(growable: false),
    );
  }
}
