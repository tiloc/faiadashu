import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:faiadashu/questionnaires/view/view.dart';
import 'package:fhir/r4/resource_types/specialized/definitional_artifacts/definitional_artifacts.dart';
import 'package:flutter/material.dart';

abstract class AnswerInputControl<A extends AnswerModel>
    extends StatelessWidget {
  final A answerModel;
  final FocusNode? focusNode;
  final QuestionnaireTheme questionnaireTheme;

  QuestionnaireItem get qi =>
      answerModel.questionnaireItemModel.questionnaireItem;
  Locale get locale =>
      answerModel.responseItemModel.questionnaireResponseModel.locale;
  QuestionnaireItemModel get itemModel => answerModel.questionnaireItemModel;

  const AnswerInputControl(
    this.answerModel, {
    this.focusNode,
    required this.questionnaireTheme,
    Key? key,
  }) : super(key: key);
}