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
      Offset.zero & Size(radius - strokeWidth, radius - strokeWidth),
      0,
      2 * pi,
      false,
      _inactive,
    );

    final paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final sweepAngle = 2 * pi / colors.length;

    for (int i = 0; i < colors.length; i++) {
      final sweepColor = colors.elementAt(i);
      if (sweepColor != null) {
        canvas.drawArc(
          Offset.zero & Size(radius - strokeWidth, radius - strokeWidth),
          i * sweepAngle,
          sweepAngle,
          false,
          paint,
        );
      }
    }
  }

  // OPTIMIZE: Come up with a criterion
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _QuestionnaireFillerCircularProgressState
    extends State<QuestionnaireFillerCircularProgress> {
  QuestionnaireResponseModel? _questionnaireResponseModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final questionnaireResponseModel =
        QuestionnaireFiller.of(context).questionnaireResponseModel;
    _questionnaireResponseModel = questionnaireResponseModel;
    questionnaireResponseModel.addListener(_updateProgress);
  }

  @override
  void dispose() {
    _questionnaireResponseModel?.removeListener(_updateProgress);
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
    final questionnaireResponseModel = _questionnaireResponseModel;

    final radius = widget.radius ?? 36.0;

    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
        painter: (questionnaireResponseModel != null)
            ? _ProgressPainter(
                radius,
                colors: questionnaireResponseModel
                    .orderedResponseItemModels()
                    .where((rim) => rim.isAnswerable)
                    .map<Color?>((rim) {
                  return rim.isAnswered ? Colors.green : null;
                }).toList(growable: false),
              )
            : _ProgressPainter(radius, colors: [null]),
      ),
    );
  }
}
