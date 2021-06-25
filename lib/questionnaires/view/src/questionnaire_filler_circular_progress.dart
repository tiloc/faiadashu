import 'dart:math';

import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:faiadashu/questionnaires/view/src/questionnaire_filler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/// A circular progress indicator for the filling of a [QuestionnaireModel]
class QuestionnaireFillerCircularProgress extends StatefulWidget {
  final double? radius;

  const QuestionnaireFillerCircularProgress({this.radius, Key? key})
      : super(key: key);

  @override
  _QuestionnaireFillerCircularProgressState createState() =>
      _QuestionnaireFillerCircularProgressState();
}

class _ProgressPainter extends CustomPainter {
  final double radius;
  final List<Color?> colors;

  static const double strokeWidth = 4.0;

  _ProgressPainter(this.radius, {required this.colors}) : super();

  final Paint _inactive = Paint()
    ..color = Colors.black12
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        const Offset(0, 0) & Size(radius - strokeWidth, radius - strokeWidth),
        0,
        2 * pi,
        false,
        _inactive);

    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final sweepAngle = 2 * pi / colors.length;

    for (int i = 0; i < colors.length; i++) {
      final sweepColor = colors.elementAt(i);
      if (sweepColor != null) {
        canvas.drawArc(
            const Offset(0, 0) &
                Size(radius - strokeWidth, radius - strokeWidth),
            i * sweepAngle,
            sweepAngle,
            false,
            paint);
      }
    }
  }

  // OPTIMIZE: Come up with a criterion
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _QuestionnaireFillerCircularProgressState
    extends State<QuestionnaireFillerCircularProgress> {
  late final QuestionnaireItemModel _questionnaireItemModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _questionnaireItemModel =
        QuestionnaireFiller.of(context).questionnaireModel;
    _questionnaireItemModel.questionnaireModel.addListener(_updateProgress);
  }

  @override
  void dispose() {
    _questionnaireItemModel.questionnaireModel.removeListener(_updateProgress);
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
    final radius = widget.radius ?? 36.0;

    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
        painter: _ProgressPainter(radius,
            colors: _questionnaireItemModel
                .orderedQuestionnaireItemModels()
                .where((qim) => qim.isAnswerable)
                .map<Color?>((qim) {
              return qim.isAnswered ? Colors.green : null;
            }).toList(growable: false)),
      ),
    );
  }
}
