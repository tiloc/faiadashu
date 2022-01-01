import 'package:faiadashu/l10n/l10n.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:flutter/material.dart';

/// Should coding selections be presented in a compact or an expanded format?
///
/// compact = dropdown or auto-complete
/// expanded = radio buttons / check boxes
enum CodingControlPreference {
  compact,
  expanded,
}

class QuestionnaireTheme extends InheritedWidget {
  final QuestionnaireThemeData data;

  const QuestionnaireTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static QuestionnaireThemeData of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<QuestionnaireTheme>();

    return inheritedTheme == null
        ? const QuestionnaireThemeData()
        : inheritedTheme.data;
  }

  @override
  bool updateShouldNotify(QuestionnaireTheme oldWidget) => false;
}

/// Create the views for all levels of a questionnaire. Provide styling theme.
class QuestionnaireThemeData {
  static final _logger = Logger(QuestionnaireThemeData);

  /// Returns whether user will be offered option to skip question.
  final bool canSkipQuestions;

  /// Returns whether a progress bar/circle is displayed while filling
  final bool showProgress;

  static const defaultAutoCompleteThreshold = 10;

  /// Coding answers with more than this amount of choices will be shown as auto-complete control
  final int autoCompleteThreshold;

  static const defaultHorizontalCodingBreakpoint = 750.0;

  /// The minimum display width to show coding answers horizontally
  final double horizontalCodingBreakpoint;

  static const defaultMaxLinesForTextItem = 4;
  final int maxLinesForTextItem;

  static const defaultMaxItemWidth = 800.0;

  /// The maximum width of the questionnaire items
  ///
  /// They will not use more width, even if the display is wider.
  final double maxItemWidth;

  static const defaultCodingControlPreference = CodingControlPreference.compact;
  final CodingControlPreference codingControlPreference;

  final QuestionnaireAnswerFiller Function(AnswerModel, {Key? key})
      createQuestionnaireAnswerFiller;

  const QuestionnaireThemeData({
    this.canSkipQuestions = false,
    this.showProgress = true,
    this.autoCompleteThreshold = defaultAutoCompleteThreshold,
    this.horizontalCodingBreakpoint = defaultHorizontalCodingBreakpoint,
    this.maxLinesForTextItem = defaultMaxLinesForTextItem,
    this.codingControlPreference = defaultCodingControlPreference,
    this.maxItemWidth = defaultMaxItemWidth,
    this.createQuestionnaireAnswerFiller = _createDefaultAnswerFiller,
  });

  /// Returns a [QuestionnaireItemFiller] for a given [QuestionnaireResponseFiller].
  ///
  /// Used by [QuestionnaireResponseFiller].
  QuestionnaireItemFiller createQuestionnaireItemFiller(
    QuestionnaireFillerData questionnaireFiller,
    FillerItemModel fillerItemModel, {
    Key? key,
  }) {
    if (fillerItemModel is QuestionItemModel) {
      return QuestionResponseItemFiller(
        questionnaireFiller,
        fillerItemModel,
        key: key,
      );
    } else if (fillerItemModel is GroupItemModel) {
      return GroupItem(
        questionnaireFiller,
        fillerItemModel,
        key: key,
      );
    } else if (fillerItemModel is DisplayItemModel) {
      return DisplayItem(
        questionnaireFiller,
        fillerItemModel,
        key: key,
      );
    } else {
      throw UnsupportedError('Cannot generate filler for $fillerItemModel');
    }
  }

  /// Returns a [QuestionnaireAnswerFiller] for a given [AnswerModel].
  static QuestionnaireAnswerFiller _createDefaultAnswerFiller(
    AnswerModel answerModel, {
    Key? key,
  }) {
    try {
      final responseModel = answerModel.responseItemModel;

      _logger.debug(
        'Creating AnswerFiller for ${responseModel.questionnaireItemModel} - $answerModel',
      );

      if (responseModel.questionnaireItemModel.isDisplay) {
        throw UnsupportedError(
          'Cannot generate an answer filler on a display item.',
        );
      }

      if (responseModel.questionnaireItemModel.isGroup) {
        throw UnsupportedError(
          'Cannot generate an answer filler on a group item.',
        );
      }

      if (responseModel.questionnaireItemModel.isTotalScore) {
        return TotalScoreItem(answerModel, key: key);
      }

      if (answerModel is NumericalAnswerModel) {
        return NumericalAnswerFiller(answerModel, key: key);
      } else if (answerModel is StringAnswerModel) {
        return StringAnswerFiller(answerModel, key: key);
      } else if (answerModel is DateTimeAnswerModel) {
        return DateTimeAnswerFiller(answerModel, key: key);
      } else if (answerModel is CodingAnswerModel) {
        return CodingAnswerFiller(answerModel, key: key);
      } else if (answerModel is BooleanAnswerModel) {
        return BooleanAnswerFiller(answerModel, key: key);
      } else if (answerModel is UnsupportedAnswerModel) {
        throw QuestionnaireFormatException(
          'Unsupported item type: ${answerModel.qi.type}',
          answerModel.questionnaireItemModel.linkId,
        );
      } else {
        throw QuestionnaireFormatException('Unknown AnswerModel: $answerModel');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);

      return BrokenAnswerFiller(
        answerModel,
        exception,
        key: key,
      );
    }
  }

  /// Decorate a [QuestionnaireAnswerFiller] with UI elements.
  ///
  ///
  Widget decorateRepeatingAnswer(
    BuildContext context,
    QuestionnaireAnswerFiller answerFiller,
    VoidCallback? removeAnswerCallback, {
    Key? key,
  }) {
    return Row(
      children: [
        Expanded(child: answerFiller),
        IconButton(
          onPressed:
              (removeAnswerCallback != null) ? removeAnswerCallback : null,
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  /// Build a UI element to add another answer to a repeating item
  ///
  /// Will be disabled if [callback] is null.
  Widget buildAddRepetition(
    BuildContext context,
    ResponseItemModel responseItemModel,
    VoidCallback? callback, {
    Key? key,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: callback,
          key: key,
          label: Text(
            FDashLocalizations.of(context).fillerAddAnotherItemLabel(
              responseItemModel.questionnaireItemModel.shortText ??
                  responseItemModel.questionnaireItemModel.text?.plainText ??
                  '',
            ),
          ),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
