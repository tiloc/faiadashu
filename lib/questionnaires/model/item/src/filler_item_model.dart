import 'package:collection/collection.dart';
import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/questionnaires.dart';
import 'package:fhir/r4.dart';

/// Express changes to the response model structure
enum StructuralState {
  /// Item has recently been added
  adding,

  /// Item is present
  present,
}

/// Codes that guide the display of questionnaire items
enum DisplayVisibility {
  /// Item is fully visible
  shown,

  /// Item is completely hidden
  hidden,

  /// Item is visible, but read-only
  protected,
}

/// An item entry for a questionnaire filler.
///
/// This is a common base-class for items that can generate responses (questions, groups),
/// and those that cannot (display).
abstract class FillerItemModel extends ResponseNode {
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
    final qItemExpression =
        _QuestionnaireItemExpressionEvaluator(questionnaireItem);

    return [
      ...questionnaireResponseModel.questionnaireLevelExpressionEvaluators,
      qItemExpression,
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
              questionnaireResponseModel.fhirResponseItemByUid(nodeUid),
        );

        qiLevelVars.add(variable);
      }
    }

    _itemLevelExpressionEvaluators = [...qiLevelVars];
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
    super.parentNode,
    this.questionnaireResponseModel,
    this.questionnaireItemModel,
  ) {
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
                questionnaireResponseModel.fhirResponseItemByUid(nodeUid),
          )
        : null;

    _displayVisibility = _calculateDisplayVisibility();
  }

  QuestionnaireItem get questionnaireItem =>
      questionnaireItemModel.questionnaireItem;

  /// Returns whether the enablement of this item can ever change.
  bool get isDynamicallyEnabled {
    return questionnaireItemModel.isEnabledWhen ||
        questionnaireItemModel.hasEnabledWhenExpression ||
        questionnaireItemModel.isNestedItem;
  }

  /// Activate the dynamic aspects of enableWhen for this item.
  ///
  /// Idempotent - does nothing if enableWhen is already activated.
  void activateEnableWhen() {
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

        // Update the enablement status when the response which owns the parent answer has changed.
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
    } else if (questionnaireItemModel.hasEnabledWhenExpression) {
      _updateEnabledByEnableWhenExpression();
    } else if (questionnaireItemModel.isNestedItem) {
      _updateEnabledByParentAnswer();
    }
  }

  /// Updates the current enablement status of this item, based on enabledWhenExpression.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhenExpression() {
    _fimLogger.trace('Enter _updateEnabledByEnableWhenExpression()');

    final enableWhenExpression =
        ArgumentError.checkNotNull(_enableWhenExpression);

    if (!(enableWhenExpression as FhirPathExpressionEvaluator).fetchBoolValue(
      unknownValue: false,
      generation: questionnaireResponseModel.generation,
      location: nodeUid,
    )) {
      _nextGenerationDisableWithDescendants();
    }
  }

  void _nextGenerationDisableWithDescendants() {
    _nextGenerationIsEnabled = false;
    for (final child in questionnaireResponseModel
        .orderedFillerItemModelsWithParent(parent: this)) {
      child._nextGenerationDisableWithDescendants();
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
      final questionLinkId = qew.question;
      if (questionLinkId == null) {
        throw QuestionnaireFormatException(
          'enableWhen with unspecified linkId.',
          qew,
        );
      }

      enableWhenTrigger.incrementAllConditionCount();
      switch (qew.operator_?.value) {
        case 'exists':
          _evaluateExistsOperator(qew, enableWhenTrigger);
          break;
        case 'eq':
        case 'ne':
          _evaluateEqualityOperator(questionLinkId, qew, enableWhenTrigger);
          break;
        case 'lt':
        case 'gt':
        case 'ge':
        case 'le':
          _evaluateComparisonOperator(questionLinkId, qew, enableWhenTrigger);
          break;
        default:
          _fimLogger.warn('Unsupported operator: ${qew.operator_}.');
          // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
          // See http://hl7.org/fhir/uv/sdc/2019May/expressions.html#missing-information for specification
          enableWhenTrigger.trigger();
      }
    });

    // TODO: Optimization: 'any' could stop evaluation after first trigger.
    switch (questionnaireItem.enableBehavior?.value) {
      case 'any':
      case null:
        if (!enableWhenTrigger.anyTriggered) {
          _nextGenerationDisableWithDescendants();
        }
        break;
      case 'all':
        if (!enableWhenTrigger.allTriggered) {
          _nextGenerationDisableWithDescendants();
        }
        break;
      case 'unknown':
        throw QuestionnaireFormatException(
          'enableWhen with unknown enableBehavior: ${questionnaireItem.enableBehavior}',
          questionnaireItem,
        );
    }
  }

  void _evaluateComparisonOperator(
    String questionLinkId,
    QuestionnaireEnableWhen qew,
    _EnableWhenTrigger enableWhenTrigger,
  ) {
    final question = fromLinkId(questionLinkId);
    if (question is QuestionItemModel) {
      final qim = fromLinkId(questionLinkId) as QuestionItemModel;

      // If enableWhen logic depends on an item that is disabled, the logic
      // should proceed as though the item is not valued - even if a
      // default value or other value might be retained in memory in the event
      // of the item being re-enabled.
      final firstAnswer = (qim.isEnabled)
          ? (fromLinkId(questionLinkId) as QuestionItemModel)
              .answeredAnswerModels
              .firstOrNull
          : null;

      if (firstAnswer == null) {
        return;
      }

      if (firstAnswer is NumericalAnswerModel) {
        final answerValue = firstAnswer.value?.value;
        if (answerValue == null) {
          return;
        }

        final comparisonValue = qew.answerDecimal?.value ??
            qew.answerInteger?.value ??
            qew.answerQuantity?.value?.value;

        if (comparisonValue == null) {
          throw QuestionnaireFormatException(
            'No number for comparison in enableWhen on $questionLinkId',
          );
        }

        switch (qew.operator_?.value) {
          case 'gt':
            if (answerValue > comparisonValue) {
              enableWhenTrigger.trigger();
            }
            break;
          case 'ge':
            if (answerValue >= comparisonValue) {
              enableWhenTrigger.trigger();
            }
            break;
          case 'lt':
            if (answerValue < comparisonValue) {
              enableWhenTrigger.trigger();
            }
            break;
          case 'le':
            if (answerValue >= comparisonValue) {
              enableWhenTrigger.trigger();
            }
            break;
          default:
            _fimLogger.warn(
              'Unexpected operator: ${qew.operator_} at $questionLinkId.',
            );
            enableWhenTrigger.trigger();
        }
      } else {
        _fimLogger.warn(
          'Unsupported: Item with linkId is not a numerical question: $questionLinkId.',
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

  void _evaluateEqualityOperator(
    String questionLinkId,
    QuestionnaireEnableWhen qew,
    _EnableWhenTrigger enableWhenTrigger,
  ) {
    final question = fromLinkId(questionLinkId);
    if (question is QuestionItemModel) {
      final qim = fromLinkId(questionLinkId) as QuestionItemModel;

      // If enableWhen logic depends on an item that is disabled, the logic
      // should proceed as though the item is not valued - even if a
      // default value or other value might be retained in memory in the event
      // of the item being re-enabled.
      final firstAnswer = (qim.isEnabled)
          ? (fromLinkId(questionLinkId) as QuestionItemModel)
              .answeredAnswerModels
              .firstOrNull
          : null;

      if (firstAnswer == null) {
        // null equals nothing
        if (qew.operator_?.value == 'ne') {
          enableWhenTrigger.trigger();
        }
      } else if (firstAnswer is CodingAnswerModel) {
        if (firstAnswer.equalsCoding(qew.answerCoding)) {
          _fimLogger.debug(
            'enableWhen: ${firstAnswer.value} == ${qew.answerCoding}',
          );
          if (qew.operator_?.value == 'eq') {
            enableWhenTrigger.trigger();
          }
        } else {
          _fimLogger.debug(
            'enableWhen: ${firstAnswer.value} != ${qew.answerCoding}',
          );
          if (qew.operator_?.value == 'ne') {
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

    // If enableWhen logic depends on an item that is disabled, the logic should
    // proceed as though the item is not valued - even if a default value or
    // other value might be retained in memory in the event of the item being
    // re-enabled.
    if (rim.isEnabled && rim.isAnswered == shouldExist) {
      enableWhenTrigger.trigger();
    }
    if (!rim.isEnabled && !shouldExist) {
      enableWhenTrigger.trigger();
    }
  }

  void _updateEnabledByParentAnswer() {
    if ((parentNode! as AnswerModel).isEmpty) {
      _nextGenerationDisableWithDescendants();
    }
  }

  /// INTERNAL USE: The item will be enabled in the next generation.
  void nextGenerationEnable() {
    _nextGenerationIsEnabled = true;
  }

  /// INTERNAL USE: Enable the item as determined for the next generation.
  bool enableNextGeneration() {
    final hasChanged = _isEnabled ^ _nextGenerationIsEnabled;

    if (hasChanged) {
      _isEnabled = _nextGenerationIsEnabled;
      _displayVisibility = _calculateDisplayVisibility();
      notifyListeners();
    }

    return hasChanged;
  }

  /// Is the item answered?
  ///
  /// Static or read-only items are not answered.
  /// Items which are not enabled are not answered.
  bool get isAnswered;

  /// Is the item unanswered?
  ///
  /// Static or read-only items are not unanswered.
  /// Items which are not enabled are not unanswered.
  bool get isUnanswered;

  /// Is the item invalid?
  bool get isInvalid;

  /// Does the item have a value?
  ///
  /// This is regardless of enabled or read-only status.
  bool get isPopulated;

  StructuralState _structuralState = StructuralState.adding;
  StructuralState get structuralState => _structuralState;

  void structuralNextGeneration({bool notifyListeners = true}) {
    if (structuralState == StructuralState.adding) {
      _structuralState = StructuralState.present;
      _displayVisibility = _calculateDisplayVisibility();
      if (notifyListeners) {
        this.notifyListeners();
      }
    }
  }

  // TODO: Get this from the R5 extension
  QuestionnaireDisabledDisplay get disabledDisplay => questionnaireResponseModel
      .questionnaireModel.questionnaireModelDefaults.disabledDisplay;

  DisplayVisibility _calculateDisplayVisibility() {
    DisplayVisibility resultVisibility = DisplayVisibility.shown;

    if (questionnaireResponseModel.responseStatus.value == 'completed') {
      resultVisibility =
          _maxVisibility(resultVisibility, DisplayVisibility.protected);
    }

    if (isNotEnabled) {
      switch (disabledDisplay) {
        case QuestionnaireDisabledDisplay.hidden:
          resultVisibility =
              _maxVisibility(resultVisibility, DisplayVisibility.hidden);
          break;
        case QuestionnaireDisabledDisplay.protected:
          resultVisibility =
              _maxVisibility(resultVisibility, DisplayVisibility.protected);
          break;
        case QuestionnaireDisabledDisplay.protectedNonEmpty:
          resultVisibility = isPopulated
              ? _maxVisibility(resultVisibility, DisplayVisibility.protected)
              : _maxVisibility(resultVisibility, DisplayVisibility.hidden);
          break;
      }
    }

    if (questionnaireItemModel.isHidden) {
      resultVisibility =
          _maxVisibility(resultVisibility, DisplayVisibility.hidden);
    }

    if (!questionnaireItemModel.isShownDuringCapture) {
      resultVisibility =
          _maxVisibility(resultVisibility, DisplayVisibility.hidden);
    }

    if (questionnaireItemModel.isReadOnly) {
      resultVisibility =
          _maxVisibility(resultVisibility, DisplayVisibility.protected);
    }

    return resultVisibility;
  }

  DisplayVisibility _maxVisibility(
    DisplayVisibility visibility1,
    DisplayVisibility visibility2,
  ) {
    if (visibility1 == DisplayVisibility.hidden ||
        visibility2 == DisplayVisibility.hidden) {
      return DisplayVisibility.hidden;
    }
    if (visibility1 == DisplayVisibility.protected ||
        visibility2 == DisplayVisibility.protected) {
      return DisplayVisibility.protected;
    }

    return DisplayVisibility.shown;
  }

  /// Handle changes to a questionnaire response's completion status.
  ///
  /// This may affect an items visibility.
  ///
  /// **INTERNAL USE ONLY**
  void handleResponseStatusChange() {
    // The overall questionnaire response going from amended to completed
    // might change the visibility
    final newVisibility = _calculateDisplayVisibility();
    if (newVisibility != _displayVisibility) {
      _displayVisibility = newVisibility;
      notifyListeners();
    }
  }

  bool _nextGenerationIsEnabled = true;

  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;

  bool get isNotEnabled => !_isEnabled;

  late DisplayVisibility _displayVisibility;
  DisplayVisibility get displayVisibility => _displayVisibility;
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
  dynamic evaluate({int? generation}) {
    final qi = questionnaireItemJson;

    return [qi];
  }

  _QuestionnaireItemExpressionEvaluator(
    QuestionnaireItem questionnaireItem,
  ) : super('qitem', []) {
    questionnaireItemJson = questionnaireItem.toJson();
  }
}
