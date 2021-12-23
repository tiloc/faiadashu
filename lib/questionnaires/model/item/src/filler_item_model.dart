import 'package:collection/collection.dart';
import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

/// An item entry for a questionnaire filler.
///
/// This is a common base-class for items that can generate responses (questions, groups),
/// and those that cannot (display).
abstract class FillerItemModel extends ResponseNode with ChangeNotifier {
  static final _fimLogger = Logger(FillerItemModel);

  final QuestionnaireResponseModel questionnaireResponseModel;
  final QuestionnaireItemModel questionnaireItemModel;

  bool _enableWhenActivated = false;

  late final FhirExpressionEvaluator? _enableWhenExpression;

  @override
  String calculateNodeUid() {
    return "${(parentNode != null) ? parentNode!.nodeUid : ''}/${questionnaireItemModel.linkId}";
  }

  RenderingString? get prefix =>
      questionnaireItemModel.prefix ??
      questionnaireItemModel
          .questionnaireModel.questionnaireModelDefaults.prefixBuilder
          ?.call(this);

  FillerItemModel? get parentFillerItem {
    ResponseNode? currentParent = parentNode;

    while (currentParent != null) {
      if (currentParent is FillerItemModel) {
        return currentParent;
      }
      currentParent = currentParent.parentNode;
    }

    return null;
  }

  late final Iterable<ExpressionEvaluator> _itemLevelExpressionEvaluators;

  Iterable<ExpressionEvaluator> get _itemBelowVariablesExpressionEvaluators {
    final qitemExpression =
        _QuestionnaireItemExpressionEvaluator(questionnaireItem);

    return [
      ...questionnaireResponseModel.questionnaireLevelExpressionEvaluators,
      qitemExpression,
    ];
  }

  // Builds the [ExpressionEvaluator]s for this item
  void _buildItemLevelExpressionEvaluators() {
    final itemUpstream = _itemBelowVariablesExpressionEvaluators;

    // Item-level variables
    final variableExtensions = questionnaireItem.extension_
        ?.where((ext) => ext.url == variableExtensionUrl);
    final qiLevelVars = <FhirExpressionEvaluator>[];

    if (variableExtensions != null) {
      for (final variableExtension in variableExtensions) {
        final variableExpression = variableExtension.valueExpression;
        if (variableExpression == null) {
          throw QuestionnaireFormatException(
            'Variable without expression.',
            questionnaireItem,
          );
        }

        // %context is not a full resource, but just a fragment from the QuestionnaireResponse,
        // corresponding to this item.
        final variable = FhirExpressionEvaluator.fromExpression(
          null,
          variableExpression,
          [...itemUpstream, ...qiLevelVars],
          jsonBuilder: () =>
              questionnaireResponseModel.responseItemByUid(nodeUid),
        );

        qiLevelVars.add(variable);
      }
    }

    _itemLevelExpressionEvaluators = [...itemUpstream, ...qiLevelVars];
  }

  /// Returns the [ExpressionEvaluator]s for this item, such as item-level variables
  Iterable<ExpressionEvaluator> get itemLevelExpressionEvaluators =>
      _itemLevelExpressionEvaluators;

  /// Returns the [ExpressionEvaluator]s for this item, all parent items,
  /// the questionnaire, and the launch context.
  ///
  /// One-stop shopping :-)
  Iterable<ExpressionEvaluator> get itemWithPredecessorsExpressionEvaluators {
    final fillerItemParent = parentFillerItem;

    return fillerItemParent == null
        ? [
            ...questionnaireResponseModel
                .questionnaireLevelExpressionEvaluators,
            ...itemLevelExpressionEvaluators,
          ]
        : [
            ...fillerItemParent.itemWithPredecessorsExpressionEvaluators,
            ...itemLevelExpressionEvaluators,
          ];
  }

  FillerItemModel(
    ResponseNode? parentNode,
    this.questionnaireResponseModel,
    this.questionnaireItemModel,
  ) : super(parentNode) {
    _buildItemLevelExpressionEvaluators();

    final enableWhenExtensionExpression = questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-enableWhenExpression',
        )
        ?.valueExpression;

    _enableWhenExpression = (enableWhenExtensionExpression != null)
        ? FhirExpressionEvaluator.fromExpression(
            null,
            enableWhenExtensionExpression,
            itemWithPredecessorsExpressionEvaluators,
            jsonBuilder: () =>
                questionnaireResponseModel.responseItemByUid(nodeUid),
          )
        : null;
  }

  QuestionnaireItem get questionnaireItem =>
      questionnaireItemModel.questionnaireItem;

  /// Activate the enablement behavior for this item.
  ///
  /// Idempotent - does nothing if behavior is already activated.
  void activateEnableBehavior() {
    if (!_enableWhenActivated) {
      questionnaireItemModel.forEnableWhens((qew) {
        fromLinkId(qew.question!)
            .addListener(() => questionnaireResponseModel.updateEnabledItems());
      });

      // Attach individual listeners to parent answers underneath which this item is nested
      if (questionnaireItemModel.isNestedItem) {
        final parentNode = this.parentNode;
        assert(parentNode != null);
        assert(parentNode is AnswerModel);
        final predecessorResponseNode = parentNode!.parentNode;
        assert(predecessorResponseNode != null);
        assert(predecessorResponseNode is ResponseItemModel);

        // Update the enable status when the response which owns the parent answer has changed.
        (predecessorResponseNode! as ResponseItemModel)
            .addListener(() => questionnaireResponseModel.updateEnabledItems());
      }

      _enableWhenActivated = true;
    }
  }

  /// Updates the current enablement status of this item.
  ///
  /// Determines the applicable method (enableWhen / enableWhenExpression / nesting).
  ///
  /// Sets the [isEnabled] property
  void updateEnabled() {
    _fimLogger.trace('Enter updateEnabled()');

    if (questionnaireItemModel.isEnabledWhen) {
      _updateEnabledByEnableWhen();
    } else if (questionnaireItemModel.isEnabledWhenExpression) {
      _updateEnabledByEnableWhenExpression();
    } else if (questionnaireItemModel.isNestedItem) {
      _updateEnabledByParentAnswer();
    }
  }

  /// Updates the current enablement status of this item, based on enabledWhenExpression.
  ///
  /// Sets the [isEnabled] property
  Future<void> _updateEnabledByEnableWhenExpression() async {
    _fimLogger.trace('Enter _updateEnabledByEnableWhenExpression()');

    final enableWhenExpression =
        ArgumentError.checkNotNull(_enableWhenExpression);

    if (!await (enableWhenExpression as FhirPathExpressionEvaluator)
        .fetchBoolValue(
      unknownValue: false,
      location: nodeUid,
    )) {
      _disableWithChildren();
    }
  }

  void _disableWithChildren() {
    _isEnabled = false;
    for (final child in questionnaireResponseModel
        .orderedFillerItemModelsWithParent(parent: this)) {
      child._disableWithChildren();
    }
  }

  ResponseItemModel fromLinkId(String linkId) {
    // TODO: This makes a simplifying assumption about 1:1 relationship question/response
    // Expected behavior according to spec:
    // If multiple question occurrences are present for the same question
    // (same linkId), then this refers to the nearest question occurrence
    // reachable by tracing first the "ancestor" axis and then the "preceding"
    // axis and then the "following" axis. If there are multiple items with the
    // same linkId and all are equidistant (e.g. a question references a
    // question that appears in a separate repeating group), that is an error.
    //
    // (Consider using the enableWhenExpression extension to define logic to handle such a situation.)
    // https://stackoverflow.com/questions/22455959/xpath-difference-between-preceding-and-ancestor/22456251
    return questionnaireResponseModel
        .orderedResponseItemModels()
        .where((rim) => rim.questionnaireItemModel.linkId == linkId)
        .first;
  }

  /// Updates the current enablement status of this item, based on enabledWhen.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhen() {
    _fimLogger.trace('Enter _updateEnabledByEnableWhen()');

    final enableWhenTrigger = _EnableWhenTrigger();

    questionnaireItemModel.forEnableWhens((qew) {
      // TODO: implement the following rule: If enableWhen logic depends on an item that is disabled, the logic should proceed as though the item is not valued - even if a default value or other value might be retained in memory in the event of the item being re-enabled.
      final questionLinkId = qew.question;
      if (questionLinkId == null) {
        throw QuestionnaireFormatException(
          'enableWhen with unspecified linkId.',
          qew,
        );
      }

      enableWhenTrigger.incrementAllConditionCount();
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          _evaluateExistsOperator(qew, enableWhenTrigger);
          break;
        case QuestionnaireEnableWhenOperator.eq:
        case QuestionnaireEnableWhenOperator.ne:
          _evaluateEqualityOperator(questionLinkId, qew, enableWhenTrigger);
          break;
        default:
          _fimLogger.warn('Unsupported operator: ${qew.operator_}.');
          // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
          // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
          enableWhenTrigger.trigger();
      }
    });

    // TODO: Optimization: 'any' could stop evaluation after first trigger.
    switch (questionnaireItem.enableBehavior) {
      case QuestionnaireItemEnableBehavior.any:
      case null:
        if (!enableWhenTrigger.anyTriggered) {
          _disableWithChildren();
        }
        break;
      case QuestionnaireItemEnableBehavior.all:
        if (!enableWhenTrigger.allTriggered) {
          _disableWithChildren();
        }
        break;
      case QuestionnaireItemEnableBehavior.unknown:
        throw QuestionnaireFormatException(
          'enableWhen with unknown enableBehavior: ${questionnaireItem.enableBehavior}',
          questionnaireItem,
        );
    }
  }

  void _evaluateEqualityOperator(
    String questionLinkId,
    QuestionnaireEnableWhen qew,
    _EnableWhenTrigger enableWhenTrigger,
  ) {
    final question = fromLinkId(questionLinkId);
    if (question is QuestionItemModel) {
      final qim = fromLinkId(questionLinkId) as QuestionItemModel;

      // If enableWhen logic depends on an item that is disabled, the logic should proceed as though the item is not valued - even if a default value or other value might be retained in memory in the event of the item being re-enabled.
      final firstAnswer = (qim.isEnabled)
          ? (fromLinkId(questionLinkId) as QuestionItemModel)
              .answeredAnswerModels
              .firstOrNull
          : null;

      if (firstAnswer == null) {
        // null equals nothing
        if (qew.operator_ == QuestionnaireEnableWhenOperator.ne) {
          enableWhenTrigger.trigger();
        }
      } else if (firstAnswer is CodingAnswerModel) {
        if (firstAnswer.equalsCoding(qew.answerCoding)) {
          _fimLogger.debug(
            'enableWhen: $firstAnswer == ${qew.answerCoding}',
          );
          if (qew.operator_ == QuestionnaireEnableWhenOperator.eq) {
            enableWhenTrigger.trigger();
          }
        } else {
          _fimLogger.debug(
            'enableWhen: $firstAnswer != ${qew.answerCoding}',
          );
          if (qew.operator_ == QuestionnaireEnableWhenOperator.ne) {
            enableWhenTrigger.trigger();
          }
        }
      } else {
        _fimLogger.warn(
          'Unsupported: Item with linkId is not a code question: $questionLinkId.',
        );
        // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
        // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
        enableWhenTrigger.trigger();
      }
    } else {
      _fimLogger.warn('linkId refers to non-question item: $questionLinkId.');
      // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
      // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
      enableWhenTrigger.trigger();
    }
  }

  void _evaluateExistsOperator(
    QuestionnaireEnableWhen qew,
    _EnableWhenTrigger enableWhenTrigger,
  ) {
    final rim = fromLinkId(qew.question!);
    final shouldExist = qew.answerBoolean?.value ?? true;

    // If enableWhen logic depends on an item that is disabled, the logic should proceed as though the item is not valued - even if a default value or other value might be retained in memory in the event of the item being re-enabled.
    if (rim.isEnabled && rim.isAnswered == shouldExist) {
      enableWhenTrigger.trigger();
    }
    if (!rim.isEnabled && !shouldExist) {
      enableWhenTrigger.trigger();
    }
  }

  void _updateEnabledByParentAnswer() {
    if ((parentNode! as AnswerModel).isUnanswered) {
      _disableWithChildren();
    }
  }

  /// INTERNAL USE: Enable the item.
  void enable() {
    _isEnabled = true;
  }

  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;

  bool get isNotEnabled => !_isEnabled;
}

class _EnableWhenTrigger {
  int _allCount = 0;
  bool _anyTriggered = false;
  int _allTriggered = 0;

  void incrementAllConditionCount() {
    _allCount++;
  }

  void trigger() {
    _anyTriggered = true;
    _allTriggered++;
  }

  bool get anyTriggered => _anyTriggered;
  bool get allTriggered => _allTriggered == _allCount;
}

class _QuestionnaireItemExpressionEvaluator extends ExpressionEvaluator {
  late final Map<String, dynamic> questionnaireItemJson;

  @override
  Future<dynamic> fetchValue() {
    final qi = questionnaireItemJson;

    return Future.value([qi]);
  }

  _QuestionnaireItemExpressionEvaluator(
    QuestionnaireItem questionnaireItem,
  ) : super('qitem', []) {
    questionnaireItemJson = questionnaireItem.toJson();
  }
}
