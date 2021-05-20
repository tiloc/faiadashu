import 'package:fhir/r4/r4.dart';
import 'package:flutter/material.dart';

import '../../../logging/logging.dart';
import '../../questionnaires.dart';
import '../broken_questionnaire_item.dart';

/// Filler for an individual [QuestionnaireResponseAnswer].
abstract class QuestionnaireAnswerFiller extends StatefulWidget {
  static final _logger = Logger(QuestionnaireAnswerFiller);
  final QuestionnaireItemModel itemModel;
  final AnswerLocation answerLocation;

  const QuestionnaireAnswerFiller(this.itemModel, this.answerLocation,
      {Key? key})
      : super(key: key);

  static QuestionnaireAnswerFiller fromAnswerModel(AnswerModel answerModel) {
    _logger.debug(
        'Creating AnswerFiller for $answerModel from ${answerModel.itemModel}');

    final itemModel = answerModel.itemModel;
    final answerLocation = answerModel.answerLocation;

    try {
      if (itemModel.isCalculatedExpression) {
        // TODO: Should there be a dedicated CalculatedExpression Model and item?
        return StaticItem(itemModel, answerLocation);
      } else if (answerModel is NumericalAnswerModel) {
        return NumericalAnswerFiller(itemModel, answerLocation);
      } else if (answerModel is StringAnswerModel) {
        return StringAnswerFiller(itemModel, answerLocation);
      } else if (answerModel is DateTimeAnswerModel) {
        return DateTimeAnswerFiller(itemModel, answerLocation);
      } else if (answerModel is CodingAnswerModel) {
        return CodingAnswerFiller(itemModel, answerLocation);
      } else if (answerModel is BooleanAnswerModel) {
        return BooleanAnswerFiller(itemModel, answerLocation);
      } else if (answerModel is StaticAnswerModel) {
        return StaticItem(itemModel, answerLocation);
      } else {
        throw QuestionnaireFormatException(
            'Unsupported AnswerModel: $answerModel');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return _BrokenItem(itemModel, answerLocation, exception);
    }
  }

  // TODO: Make obsolete in favor of fromAnswerModel.
  static QuestionnaireAnswerFiller fromQuestionnaireItem(
      QuestionnaireItemModel itemModel, AnswerLocation answerLocation) {
    _logger.debug('Creating AnswerFiller for $itemModel');

    try {
      switch (itemModel.questionnaireItem.type!) {
        case QuestionnaireItemType.choice:
        case QuestionnaireItemType.open_choice:
          return CodingAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.quantity:
        case QuestionnaireItemType.decimal:
        case QuestionnaireItemType.integer:
          return (itemModel.isCalculatedExpression)
              ? StaticItem(itemModel, answerLocation)
              : NumericalAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.string:
        case QuestionnaireItemType.text:
        case QuestionnaireItemType.url:
          return StringAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.display:
        case QuestionnaireItemType.group:
          return StaticItem(itemModel, answerLocation);
        case QuestionnaireItemType.date:
        case QuestionnaireItemType.datetime:
        case QuestionnaireItemType.time:
          return DateTimeAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.boolean:
          return BooleanAnswerFiller(itemModel, answerLocation);
        case QuestionnaireItemType.attachment:
        case QuestionnaireItemType.unknown:
        case QuestionnaireItemType.reference:
          throw QuestionnaireFormatException(
              'Unsupported item type: ${itemModel.questionnaireItem.type!}');
      }
    } catch (exception) {
      _logger.warn('Cannot create answer filler:', error: exception);
      return _BrokenItem(itemModel, answerLocation, exception);
    }
  }
}

abstract class QuestionnaireAnswerState<V, W extends QuestionnaireAnswerFiller,
    M extends AnswerModel<Object, V>> extends State<W> {
  static final _abstractLogger = Logger(QuestionnaireAnswerState);
  late final M answerModel;

  late final Object? answerModelError;

  late final FocusNode firstFocusNode;
  bool _isFocusHookedUp = false;

  QuestionnaireItem get qi => widget.itemModel.questionnaireItem;
  Locale get locale => widget.itemModel.questionnaireModel.locale;
  QuestionnaireItemModel get itemModel => widget.itemModel;

  QuestionnaireAnswerState();

  @override
  void initState() {
    super.initState();

    try {
      answerModel =
          AnswerModel.createModel<M>(itemModel, widget.answerLocation) as M;

      answerModelError = null;

      firstFocusNode = FocusNode(
          debugLabel:
              'AnswerFiller firstFocusNode: ${widget.itemModel.linkId}');

      postInitState();
    } catch (exception) {
      _abstractLogger.warn('Could not initialize model for ${itemModel.linkId}',
          error: exception);
      answerModelError = exception;
    }
  }

  /// Initialize the filler after the model has been successfully finished.
  ///
  /// Do not place initialization code into [initState], but place it here.
  ///
  /// Guarantees a properly initialized [answerModel].
  void postInitState();

  @override
  void dispose() {
    firstFocusNode.dispose();
    super.dispose();
  }

  Widget _guardedBuildReadOnly(BuildContext context) {
    if (answerModelError != null) {
      return BrokenQuestionnaireItem.fromException(answerModelError!);
    }

    return buildReadOnly(context);
  }

  Widget _guardedBuildEditable(BuildContext context) {
    if (answerModelError != null) {
      return BrokenQuestionnaireItem.fromException(answerModelError!);
    }

    // TODO: Is there a more elegant solution? Do I have to unregister the listener?
    // Listen to the parent FocusNode and become focussed when it does.
    if (!_isFocusHookedUp) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        Focus.of(context).addListener(() {
          if ((firstFocusNode.parent?.hasPrimaryFocus ?? false) &&
              !firstFocusNode.hasPrimaryFocus) {
            firstFocusNode.requestFocus();
          }
        });
      });
      _isFocusHookedUp = true;
    }

    return buildEditable(context);
  }

  Widget buildReadOnly(BuildContext context) {
    return Text(answerModel.display);
  }

  Widget buildEditable(BuildContext context);

  set value(V? newValue) {
    if (mounted) {
      setState(() {
        answerModel.value = newValue;
      });

      if (answerModel.hasCodingAnswers()) {
        widget.answerLocation.updateAnswers(answerModel.fillCodingAnswers());
      } else {
        widget.answerLocation.updateAnswer(answerModel.fillAnswer());
      }
    }
  }

  V? get value => answerModel.value;

  @override
  Widget build(BuildContext context) {
    return widget.itemModel.isReadOnly
        ? _guardedBuildReadOnly(context)
        : _guardedBuildEditable(context);
  }
}

class _BrokenItem extends QuestionnaireAnswerFiller {
  final Object exception;

  const _BrokenItem(QuestionnaireItemModel itemModel,
      AnswerLocation answerLocation, this.exception)
      : super(itemModel, answerLocation);

  @override
  State<StatefulWidget> createState() => _BrokenItemState();
}

class _BrokenItemState extends State<_BrokenItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BrokenQuestionnaireItem(
        'Could not initialize QuestionnaireAnswerFiller',
        widget.itemModel.questionnaireItem,
        widget.exception);
  }
}
