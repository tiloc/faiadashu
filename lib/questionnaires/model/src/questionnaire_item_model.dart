import 'dart:collection';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:fhir_path/fhir_path.dart';
import 'package:flutter/foundation.dart';

import '../../../fhir_types/fhir_types.dart';
import '../../../l10n/l10n.dart';
import '../../../logging/logging.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

part 'questionnaire_model.dart';

/// Models an individual item of a questionnaire.
///
/// Combines the [QuestionnaireItem] and the corresponding [QuestionnaireResponseItem].
///
/// Provides properties of the item.
///
/// Provides access to adjacent items (parent, siblings, children).
class QuestionnaireItemModel extends ChangeNotifier with Diagnosticable {
  final Questionnaire questionnaire;
  final QuestionnaireItem questionnaireItem;
  QuestionnaireResponseItem? _questionnaireResponseItem;
  final String linkId;
  final QuestionnaireItemModel? parent;
  late QuestionnaireModel? _questionnaireModel;
  final int siblingIndex;
  final int level;
  static final _qimLogger = Logger(QuestionnaireItemModel);

  QuestionnaireModel get questionnaireModel => _questionnaireModel!;

  LinkedHashMap<String, QuestionnaireItemModel>? _orderedItems;

  late final List<VariableModel>? _variables;

  /// Returns whether the item has an initial value.
  ///
  /// True if either initial.value[x] or initialExpression are present.
  bool get hasInitialValue {
    return (questionnaireItem.initial != null &&
            questionnaireItem.initial!.isNotEmpty) ||
        hasInitialExpression;
  }

  bool get hasInitialExpression {
    return questionnaireItem.extension_
            ?.extensionOrNull(
              'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression',
            )
            ?.valueExpression
            ?.expression !=
        null;
  }

  void _populateInitialValue() {
    _qimLogger.debug('_populateInitialValue: $linkId');
    if (hasInitialExpression) {
      final initialEvaluationResult = _evaluateInitialExpression();
      responseModel
          .answerModel(0)
          .populateFromExpression(initialEvaluationResult);
    } else {
      // initial.value[x]
      // TODO: Implement
    }
  }

  /// Returns the value of the initialExpression.
  ///
  /// Returns null if the item does not have an initialExpression,
  /// or it evaluates to an empty list.
  dynamic _evaluateInitialExpression() {
    final fhirPathExpression = questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression',
        )
        ?.valueExpression
        ?.expression;

    if (fhirPathExpression == null) {
      return null;
    }

    final evaluationResult = questionnaireModel.evaluateFhirPathExpression(
      fhirPathExpression,
      requiresQuestionnaireResponse: false,
    );

    if (evaluationResult.isEmpty) {
      return null;
    }

    return evaluationResult.first;
  }

  void _disableWithChildren() {
    _isEnabled = false;
    for (final child in children) {
      child._disableWithChildren();
    }
  }

  /// Returns whether the item is enabled/disabled through an enabledWhen condition.
  bool get isEnabledWhen {
    return questionnaireItem.enableWhen?.isNotEmpty ?? false;
  }

  /// Returns whether the item is enabled/disabled through an enabledWhenExpression condition.
  bool get isEnabledWhenExpression {
    return questionnaireItem.extension_?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-enableWhenExpression',
        ) !=
        null;
  }

  /// Updates the current enablement status of this item.
  ///
  /// Determines the applicable method (enableWhen / enableWhenExpression).
  ///
  /// Sets the [isEnabled] property
  void _updateEnabled() {
    _qimLogger.trace('Enter _updateEnabled()');

    if (isEnabledWhen) {
      _updateEnabledByEnableWhen();
    } else if (isEnabledWhenExpression) {
      _updateEnabledByEnableWhenExpression();
    }
  }

  /// Updates the current enablement status of this item, based on enabledWhenExpression.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhenExpression() {
    _qimLogger.trace('Enter _updateEnabledByEnableWhenExpression()');

    final fhirPathExpression = questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-enableWhenExpression',
        )
        ?.valueExpression
        ?.expression;

    if (fhirPathExpression == null) {
      throw QuestionnaireFormatException(
        'enableWhenExpression missing expression',
        questionnaireItem,
      );
    }

    final fhirPathResult =
        questionnaireModel.evaluateFhirPathExpression(fhirPathExpression);

    // Evaluate result
    if (!_isFhirPathResultTrue(
      fhirPathResult,
      fhirPathExpression,
      orElse: false,
    )) {
      _disableWithChildren();
    }
  }

  bool _isFhirPathResultTrue(
    List<dynamic> fhirPathResult,
    String fhirPathExpression, {
    required bool orElse,
  }) {
    // TODO: Final specification of proper behavior pending: http://jira.hl7.org/browse/FHIR-33295
    if (fhirPathResult.isEmpty) {
      return orElse;
    } else if (fhirPathResult.first is! bool) {
      throw QuestionnaireFormatException(
        'FHIRPath expression does not return a bool: $fhirPathExpression',
        this,
      );
    } else {
      return fhirPathResult.first as bool;
    }
  }

  /// Updates the current enablement status of this item, based on enabledWhen.
  ///
  /// Sets the [isEnabled] property
  void _updateEnabledByEnableWhen() {
    _qimLogger.trace('Enter _updateEnabledByEnableWhen()');

    bool anyTrigger = false;
    int allTriggered = 0;
    int allCount = 0;

    forEnableWhens((qew) {
      allCount++;
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          if (questionnaireModel.fromLinkId(qew.question!).isAnswered ==
              qew.answerBoolean!.value) {
            anyTrigger = true;
            allTriggered++;
          }
          break;
        case QuestionnaireEnableWhenOperator.eq:
        case QuestionnaireEnableWhenOperator.ne:
          final responseCoding = questionnaireModel
              .fromLinkId(qew.question!)
              .responseItem
              ?.answer
              ?.firstOrNull
              ?.valueCoding;
          // TODO: More sophistication- System, cardinality, etc.
          if (responseCoding?.code == qew.answerCoding?.code) {
            _qimLogger
                .debug('enableWhen: $responseCoding == ${qew.answerCoding}');
            if (qew.operator_ == QuestionnaireEnableWhenOperator.eq) {
              anyTrigger = true;
              allTriggered++;
            }
          } else {
            _qimLogger.debug(
              'enableWhen: $responseCoding != ${qew.answerCoding}',
            );
            if (qew.operator_ == QuestionnaireEnableWhenOperator.ne) {
              anyTrigger = true;
              allTriggered++;
            }
          }
          break;
        default:
          _qimLogger.warn('Unsupported operator: ${qew.operator_}.');
          // Err on the side of caution: Enable fields when enableWhen cannot be evaluated.
          anyTrigger = true;
          allTriggered++;
      }
    });

    // TODO: Optimization: 'any' could stop evaluation after first trigger.
    switch (questionnaireItem.enableBehavior) {
      case QuestionnaireItemEnableBehavior.any:
      case null:
        if (!anyTrigger) {
          _disableWithChildren();
        }
        break;
      case QuestionnaireItemEnableBehavior.all:
        if (allCount != allTriggered) {
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

  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;

  /// Iterate over all enableWhen conditions and do something with them.
  void forEnableWhens(void Function(QuestionnaireEnableWhen qew) f) {
    final enableWhens = questionnaireItem.enableWhen;
    if ((enableWhens != null) && enableWhens.isNotEmpty) {
      for (final enableWhen in enableWhens) {
        f.call(enableWhen);
      }
    }
  }

  /// All siblings at the current level as FHIR [QuestionnaireItem].
  /// Includes the current item.
  List<QuestionnaireItem> get siblingQuestionnaireItems {
    if (level == 0) {
      return questionnaire.item!;
    } else {
      return parent!.questionnaireItem.item!;
    }
  }

  /// All children below the current level as FHIR [QuestionnaireItem].
  /// Returns an empty list when there are no children.
  List<QuestionnaireItem> get childQuestionnaireItems {
    if ((questionnaireItem.item == null) || (questionnaireItem.item!.isEmpty)) {
      return <QuestionnaireItem>[];
    } else {
      return questionnaireItem.item!;
    }
  }

  List<QuestionnaireItemModel> get siblings {
    return _buildModelsFromItems(
      questionnaire,
      questionnaireModel,
      siblingQuestionnaireItems,
      parent,
      level,
    );
  }

  List<QuestionnaireItemModel> get children {
    return _buildModelsFromItems(
      questionnaire,
      questionnaireModel,
      childQuestionnaireItems,
      this,
      level + 1,
    );
  }

  bool get hasNextSibling {
    return siblingQuestionnaireItems.length > siblingIndex + 1;
  }

  bool get hasPreviousSibling => siblingIndex > 0;

  QuestionnaireItemModel get nextSibling =>
      siblings.elementAt(siblingIndex + 1);

  bool get hasParent => parent != null;

  bool get hasChildren =>
      (questionnaireItem.item != null) && (questionnaireItem.item!.isNotEmpty);

  /// Sets the associated [QuestionnaireResponseItem].
  set responseItem(QuestionnaireResponseItem? questionnaireResponseItem) {
    _qimLogger.debug('set responseItem $questionnaireResponseItem');
    if (questionnaireResponseItem != _questionnaireResponseItem) {
      _questionnaireResponseItem = questionnaireResponseItem;
      questionnaireModel.nextGeneration();
      // This notifies aggregators on changes to individual items
      notifyListeners();
    }
  }

  /// Returns an integer, starting with 1, that provides the number
  /// of [QuestionnaireModel]s that have [isAnswerable] flags set to true
  ///
  int getQuestionNumber(int answerIndex) {
    late final int questionNumber;

    /// If [answerIndex] falls within the _cachedAnswerModels data set...
    /// Check each question in turn until [answerIndex] is reached.
    /// Create a count of all questions that are labeled as answerable until
    /// [answerIndexx]
    ///
    if (_orderedItems != null) {
      if (_orderedItems!.length >= answerIndex) {
        var iterable = 1;
        for (var idx = 0; idx < answerIndex; idx++) {
          // Use linked hash map to ensure a key exists at this answer index
          if (_orderedItems?.keys.elementAt(idx).isNotEmpty ?? false) {
            // If a key exists, check to see if the isAnswerable flag is true
            if (_orderedItems?[_orderedItems?.keys.elementAt(idx)]
                    ?.isAnswerable ??
                false) {
              iterable++;
            }
          }
        }
        questionNumber = iterable;
      } else {
        throw ArgumentError(
          'answerIndex $answerIndex not found in _orderedItems',
        );
      }
    } else {
      throw StateError('_orderedItems not found');
    }
    return questionNumber;
  }

  /// Returns the associated [QuestionnaireResponseItem].
  QuestionnaireResponseItem? get responseItem => _questionnaireResponseItem;

  ResponseModel? _responseModel;

  /// Returns the [ResponseModel].
  ResponseModel get responseModel {
    return _responseModel ??= ResponseModel(this);
  }

  bool get isRequired => questionnaireItem.required_ == Boolean(true);

  /// Can the item be answered?
  ///
  /// Static or read-only items cannot be answered.
  /// Items which are not enabled cannot be answered.
  bool get isAnswerable {
    _qimLogger.trace('isAnswerable $linkId');
    if (isReadOnly || !isEnabled) {
      return false;
    }

    return true;
  }

  /// Is the item answered?
  ///
  /// Static or read-only items are not answered.
  /// Items which are not enabled are not answered.
  bool get isAnswered {
    _qimLogger.trace('isAnswered $linkId');
    if (!isAnswerable) {
      return false;
    }

    if (responseItem != null) {
      _qimLogger.debug('responseItem $responseItem');
      _qimLogger.debug('$linkId is answered.');
      return true;
    }

    return false;
  }

  /// Is the item unanswered?
  ///
  /// Static or read-only items are not unanswered.
  /// Items which are not enabled are not unanswered.
  bool get isUnanswered {
    _qimLogger.trace('isUnanswered $linkId');
    if (!isAnswerable) {
      return false;
    }

    if (responseItem != null) {
      _qimLogger.debug('responseItem $responseItem');
      return false;
    }

    _qimLogger.debug('$linkId is unanswered.');

    return true;
  }

  /// Is the item invalid?
  bool get isInvalid {
    _qimLogger.trace('isInvalid $linkId');
    return responseModel.isInvalid;
  }

  Iterable<QuestionnaireErrorFlag>? get isComplete {
    if (isRequired && !responseModel.isUnanswered) {
      return [
        QuestionnaireErrorFlag(
          linkId,
          errorText: lookupFDashLocalizations(questionnaireModel.locale)
              .validatorRequiredItem,
        )
      ];
    }
    return responseModel.isComplete;
  }

  bool get hasConstraint => constraintExpression != null;

  bool get isFulfillingConstraint {
    // TODO: Implement
    return true;
  }

  String? get constraintExpression {
    return questionnaireItem.extension_
        ?.firstWhereOrNull(
          (ext) =>
              ext.url?.value.toString() ==
              'http://hl7.org/fhir/StructureDefinition/questionnaire-constraint',
        )
        ?.valueExpression
        ?.expression;
  }

  /// Returns a [Decimal] value which can be added to a score.
  ///
  /// Returns null if not applicable (either question unanswered, or wrong type)
  Decimal? get ordinalValue {
    if (responseItem == null) {
      return null;
    }

    // Find ordinal value in extensions
    final ordinalExtension = responseItem
            ?.answer?.firstOrNull?.valueCoding?.extension_
            ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value',
        ) ??
        responseItem?.answer?.firstOrNull?.valueCoding?.extension_
            ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/ordinalValue',
        );
    if (ordinalExtension == null) {
      return null;
    }

    return ordinalExtension.valueDecimal;
  }

  /// Is this item's value calculated?
  bool get isCalculated {
    return isCalculatedExpression || isTotalScore;
  }

  /// Is this item a total score calculation?
  bool get isTotalScore {
    // From the description of the extension it is not entirely clear
    // whether the unit should be in display or code.
    // NLM Forms Builder puts it into display.
    //
    // Checking for read-only is relevant,
    // as there are also input fields (e.g. pain score) with unit {score}.
    if (questionnaireItem.type == QuestionnaireItemType.quantity ||
        questionnaireItem.type == QuestionnaireItemType.decimal) {
      if (questionnaireItem.extension_?.firstWhereOrNull((ext) {
            return 'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression' ==
                    ext.url?.value.toString() &&
                ext.valueExpression?.expression ==
                    'answers().sum(value.ordinal())';
          }) !=
          null) {
        return true;
      }

      if (questionnaireItem.readOnly == Boolean(true) &&
          questionnaireItem.unit?.display == '{score}') {
        return true;
      }
    }
    return false;
  }

  static const String calculatedExpressionExtensionUrl =
      'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression';

  String? get calculatedExpression {
    return questionnaireItem.extension_
        ?.firstWhereOrNull(
          (ext) =>
              ext.url?.value.toString() == calculatedExpressionExtensionUrl,
        )
        ?.valueExpression
        ?.expression;
  }

  /// Is the value of this item calculated by an expression?
  bool get isCalculatedExpression {
    if (questionnaireItem.extension_?.firstWhereOrNull((ext) {
          return {
            calculatedExpressionExtensionUrl,
            'http://hl7.org/fhir/StructureDefinition/cqf-expression'
          }.contains(ext.url?.value.toString());
        }) !=
        null) {
      return true;
    }
    return false;
  }

  void _updateCalculatedExpression() {
    final fhirPathExpression = calculatedExpression;
    if (fhirPathExpression == null) {
      return;
    }

    final rawEvaluationResult = questionnaireModel.evaluateFhirPathExpression(
      fhirPathExpression,
    );

    final evaluationResult =
        (rawEvaluationResult.isNotEmpty) ? rawEvaluationResult.first : null;

    // Write the value back to the answer model
    responseModel.answerModel(0).populateFromExpression(evaluationResult);
    // ... and make sure the world will know about it
    responseModel.updateResponse();
  }

  void _updateVariables() {
    final responseResource = questionnaireModel.questionnaireResponse;
    _variables?.forEach((variableModel) {
      variableModel.updateValue(responseResource);
    });
  }

  /// Is this itemModel unable to hold a value?
  bool get isStatic => isGroup || isDisplay;

  bool get isGroup => questionnaireItem.type == QuestionnaireItemType.group;

  bool get isDisplay => questionnaireItem.type == QuestionnaireItemType.display;

  /// Is this item not changeable by end-users?
  ///
  /// Read-only items might still hold a value, such as a calculated value.
  /// This does not consider the completion status of the questionnaire.
  bool get isReadOnly {
    return isStatic ||
        questionnaireItem.readOnly == Boolean(true) ||
        isHidden ||
        isCalculated;
  }

  /// Is this item hidden?
  bool get isHidden {
    return (questionnaireItem.extension_
                ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/questionnaire-hidden',
                )
                ?.valueBoolean
                ?.value ==
            true) ||
        isHelp;
  }

  /// The [QuestionnaireItemModel] which contains help text about the current item.
  ///
  /// null, if this doesn't exist.
  QuestionnaireItemModel? get helpItem =>
      children.firstWhereOrNull((itemModel) => itemModel.isHelp);

  bool get isHelp {
    return questionnaireItem.isItemControl('help') ||
        (questionnaireItem.extension_
                ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory',
                )
                ?.valueCodeableConcept
                ?.coding
                ?.firstOrNull
                ?.code
                ?.value ==
            'help');
  }

  String? get titleText {
    final title = Xhtml.toXhtml(
      questionnaireItem.text,
      questionnaireItem.textElement?.extension_,
    );

    final prefix = Xhtml.toXhtml(
      questionnaireItem.prefix,
      questionnaireItem.prefixElement?.extension_,
    );

    return (prefix != null) ? '$prefix $title' : title;
  }

  LinkedHashMap<String, QuestionnaireItemModel> _addChildren() {
    _qimLogger.trace('_addChildren $linkId');
    final LinkedHashMap<String, QuestionnaireItemModel> itemModelMap =
        LinkedHashMap<String, QuestionnaireItemModel>();
    if (itemModelMap.containsKey(linkId)) {
      throw QuestionnaireFormatException('Duplicate linkId: $linkId', this);
    }
    itemModelMap[linkId] = this;
    if (hasChildren) {
      for (final child in children) {
        itemModelMap.addAll(child._addChildren());
      }
    }

    return itemModelMap;
  }

  void _ensureOrderedItems() {
    if (_orderedItems == null) {
      final LinkedHashMap<String, QuestionnaireItemModel> itemModelMap =
          LinkedHashMap<String, QuestionnaireItemModel>();
      itemModelMap.addAll(_addChildren());
      QuestionnaireItemModel currentSibling = this;
      while (currentSibling.hasNextSibling) {
        currentSibling = currentSibling.nextSibling;
        if (itemModelMap.containsKey(currentSibling.linkId)) {
          throw QuestionnaireFormatException(
            'Duplicate linkId $linkId',
            currentSibling,
          );
        } else {
          itemModelMap.addAll(currentSibling._addChildren());
        }
      }
      _orderedItems = itemModelMap;
    }
  }

  /// Returns an [Iterable] of [QuestionnaireItemModel]s in "pre-order".
  ///
  /// see: https://en.wikipedia.org/wiki/Tree_traversal
  Iterable<QuestionnaireItemModel> orderedQuestionnaireItemModels() {
    _ensureOrderedItems();
    return _orderedItems!.values;
  }

  /// Returns a single [QuestionnaireItemModel] by [index].
  ///
  /// The order of the items is the same as with [orderedQuestionnaireItemModels].
  QuestionnaireItemModel itemModelAt(int index) {
    return orderedQuestionnaireItemModels().elementAt(index);
  }

  /// Returns the index of the first [QuestionnaireItemModel] which matches the predicate function.
  ///
  /// The items are examined as returned by [orderedQuestionnaireItemModels].
  ///
  /// Returns [notFound] if no matching item exists.
  int? indexOf(
    bool Function(QuestionnaireItemModel) predicate, [
    int? notFound = -1,
  ]) {
    int index = 0;
    for (final qim in orderedQuestionnaireItemModels()) {
      if (predicate.call(qim)) {
        return index;
      }
      index++;
    }

    return notFound;
  }

  /// Returns the count of [QuestionnaireItemModel]s which match the predicate function.
  ///
  /// Considers the item models returned by [orderedQuestionnaireItemModels()].
  int count(bool Function(QuestionnaireItemModel) predicate) {
    int count = 0;
    for (final qim in orderedQuestionnaireItemModels()) {
      if (predicate.call(qim)) {
        count++;
      }
    }

    return count;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('linkId', linkId));
    properties
        .add(FlagProperty('children', value: hasChildren, ifTrue: 'children'));
    properties.add(IntProperty('level', level));
    properties.add(IntProperty('siblingIndex', siblingIndex));
    properties.add(IntProperty('siblings', siblings.length));
  }

  QuestionnaireItemModel._(
    this.questionnaire,
    QuestionnaireModel? questionnaireModel,
    this.questionnaireItem,
    this.linkId,
    this.parent,
    this.siblingIndex,
    this.level,
  ) {
    _questionnaireModel = questionnaireModel;
    // WIP: Implement support for item-level variables.
    _variables = (questionnaireModel == null)
        ? VariableModel.variables(questionnaire, null)
        : null;
  }

  factory QuestionnaireItemModel._cached(
    Questionnaire questionnaire,
    QuestionnaireModel questionnaireModel,
    QuestionnaireItem questionnaireItem,
    String linkId,
    QuestionnaireItemModel? parent,
    int siblingIndex,
    int level,
  ) {
    return questionnaireModel._cachedItems.putIfAbsent(
      linkId,
      () => (linkId != questionnaireModel.linkId)
          ? QuestionnaireItemModel._(
              questionnaire,
              questionnaireModel,
              questionnaireItem,
              linkId,
              parent,
              siblingIndex,
              level,
            )
          : questionnaireModel,
    );
  }
}

/// Build list of [QuestionnaireItemModel] from [QuestionnaireItem] and meta-data.
List<QuestionnaireItemModel> _buildModelsFromItems(
  Questionnaire _questionnaire,
  QuestionnaireModel questionnaireModel,
  List<QuestionnaireItem> _items,
  QuestionnaireItemModel? _parent,
  int _level,
) {
  int siblingIndex = 0;
  final itemModelList = <QuestionnaireItemModel>[];

  for (final item in _items) {
    itemModelList.add(
      QuestionnaireItemModel._cached(
        _questionnaire,
        questionnaireModel,
        item,
        item.linkId,
        _parent,
        siblingIndex,
        _level,
      ),
    );
    siblingIndex++;
  }

  return itemModelList;
}
