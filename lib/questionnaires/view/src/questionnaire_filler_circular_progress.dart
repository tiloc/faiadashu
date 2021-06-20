import 'dart:math';

import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:flutter/material.dart';

/// A circular progress indicator for the filling of a [QuestionnaireModel]
class QuestionnaireFillerCircularProgress extends StatefulWidget {
  final QuestionnaireItemModel questionnaireItemModel;
  final double? radius;

  const QuestionnaireFillerCircularProgress(this.questionnaireItemModel,
      {this.radius, Key? key})
      : super(key: key);

  @override
  _QuestionnaireFillerCircularProgressState createState() =>
      _QuestionnaireFillerCircularProgressState();
}

class _ProgressPainter extends CustomPainter {
  final double radius;
  final List<Color?> colors;

  const _ProgressPainter(this.radius, {required this.colors}) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final sweepAngle = 2 * pi / colors.length;

    for (int i = 0; i < colors.length; i++) {
      final sweepColor = colors.elementAt(i);
      if (sweepColor != null) {
        canvas.drawArc(const Offset(0, 0) & const Size(22, 22), i * sweepAngle,
            sweepAngle, false, paint);
      }
    }
  }

  // OPTIMIZE: Come up with a criterion
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _QuestionnaireFillerCircularProgressState
    extends State<QuestionnaireFillerCircularProgress> {
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
    final radius = widget.radius ?? 24.0;

    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
        painter: _ProgressPainter(radius,
            colors: widget.questionnaireItemModel
                .orderedQuestionnaireItemModels()
                .where((qim) => qim.isAnswerable)
                .map<Color?>((qim) {
              return qim.isAnswered ? Colors.green : null;
            }).toList(growable: false)),
      ),
    );
  }
}
