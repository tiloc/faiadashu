import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

abstract class QuestionnaireItemFiller extends StatefulWidget {
  final QuestionnaireThemeData questionnaireTheme;
  final FillerItemModel fillerItemModel;

  String get responseUid => fillerItemModel.nodeUid;

  QuestionnaireItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    this.fillerItemModel, {
    Key? key,
  })  : questionnaireTheme = questionnaireFiller.questionnaireTheme,
        super(key: key);
}

abstract class QuestionnaireItemFillerState<W extends QuestionnaireItemFiller>
    extends State<W> {
  late final Widget? _titleWidget;
  Widget? get titleWidget => _titleWidget;

  QuestionnaireFillerData? _questionnaireFiller;
  QuestionnaireThemeData get questionnaireTheme => widget.questionnaireTheme;

  late final FocusNode _focusNode;
  FocusNode get focusNode => _focusNode;

  String get responseUid => widget.responseUid;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: responseUid, skipTraversal: true);

    _titleWidget = QuestionnaireItemFillerTitle.fromFillerItem(
      fillerItem: widget.fillerItemModel,
      questionnaireTheme: questionnaireTheme,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _questionnaireFiller = QuestionnaireResponseFiller.of(context);
    _questionnaireFiller?.registerQuestionnaireItemFillerState(this);
  }

  @override
  void dispose() {
    _questionnaireFiller?.unregisterQuestionnaireItemFillerState(this);

    _focusNode.dispose();
    super.dispose();
  }

  /// Requests focus on this [QuestionnaireItemFiller].
  void requestFocus() {
    _focusNode.requestFocus();
  }
}
