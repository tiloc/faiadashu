import 'dart:collection';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

import '../../fhir_types/fhir_types_extensions.dart';
import '../../logging/logging.dart';
import '../../resource_provider/resource_provider.dart';
import '../questionnaires.dart';
import '../view/xhtml.dart';
import 'aggregation/aggregation.dart';
import 'questionnaire_exceptions.dart';
import 'questionnaire_extensions.dart';

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
  QuestionnaireResponse? questionnaireResponse;
  QuestionnaireResponseItem? _questionnaireResponseItem;
  final String linkId;
  final QuestionnaireItemModel? parent;
  late QuestionnaireModel? _questionnaireModel;
  final int siblingIndex;
  final int level;
  static final _qimLogger = Logger(QuestionnaireItemModel);

  QuestionnaireModel get questionnaireModel => _questionnaireModel!;

  LinkedHashMap<String, QuestionnaireItemModel>? _orderedItems;

  void _disableWithChildren() {
    _isEnabled = false;
    for (final child in children) {
      child._disableWithChildren();
    }
  }

  /// Calculates the current enablement status of this item.
  ///
  /// Sets the [isEnabled] property
  void _calculateEnabled() {
    _qimLogger.trace('Enter _calculateEnabled()');

    bool anyTrigger = false;
    int allTriggered = 0;
    int allCount = 0;

    forEnableWhens((qew) {
      allCount++;
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          if (questionnaireModel.fromLinkId(qew.question!).responseItem !=
              null) {
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
            questionnaireItem);
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
    return _LocationListBuilder._buildLocationList(questionnaire,
        questionnaireModel, siblingQuestionnaireItems, parent, level);
  }

  List<QuestionnaireItemModel> get children {
    return _LocationListBuilder._buildLocationList(questionnaire,
        questionnaireModel, childQuestionnaireItems, this, level + 1);
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
      questionnaireModel.bumpRevision();
      // This notifies aggregators on changes to individual items
      notifyListeners();
    }
  }

  /// Returns the associated [QuestionnaireResponseItem].
  QuestionnaireResponseItem? get responseItem => _questionnaireResponseItem;

  ResponseModel? _responseModel;

  /// Returns the [ResponseModel].
  ResponseModel get responseModel {
    return _responseModel ??= ResponseModel(this);
  }

  /// Is the item unanswered?
  ///
  /// Static or read-only items are not unanswered.
  /// Items which are not enabled are not unanswered.
  bool get isUnanswered {
    _qimLogger.debug('isUnanswered $linkId');
    if (isReadOnly || !isEnabled) {
      return false;
    }

    if (responseItem != null) {
      _qimLogger.debug('responseItem $responseItem');
      return false;
    }

    _qimLogger.debug('$linkId is unanswered.');

    return true;
  }

  /// A [Decimal] value which can be added to a score.
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
                'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value') ??
        responseItem?.answer?.firstOrNull?.valueCoding?.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/ordinalValue');
    if (ordinalExtension == null) {
      return null;
    }

    return ordinalExtension.valueDecimal;
  }

  bool get isCalculatedExpression {
    if (questionnaireItem.type == QuestionnaireItemType.quantity ||
        questionnaireItem.type == QuestionnaireItemType.decimal) {
      if (questionnaireItem.extension_?.firstWhereOrNull((ext) {
            return {
              'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression',
              'http://hl7.org/fhir/StructureDefinition/cqf-expression'
            }.contains(ext.url?.value.toString());
          }) !=
          null) {
        return true;
      }

      // From the description of the extension it is not entirely clear
      // whether the unit should be in display or code.
      // NLM Forms Builder puts it into display.
      //
      // Checking for read-only is relevant,
      // as there are also input fields (e.g. pain score) with unit {score}.
      if (questionnaireItem.readOnly == Boolean(true) &&
          questionnaireItem.unit?.display == '{score}') {
        return true;
      }
    }

    return false;
  }

  /// Is this itemModel unable to hold a value?
  bool get isStatic {
    return (questionnaireItem.type == QuestionnaireItemType.group) ||
        (questionnaireItem.type == QuestionnaireItemType.display);
  }

  /// Is this itemModel not changeable by end-users?
  ///
  /// Read-only items might still hold a value, such as a calculated value.
  bool get isReadOnly {
    return isStatic ||
        questionnaireItem.readOnly == Boolean(true) ||
        isHidden ||
        isCalculatedExpression;
  }

  bool get isHidden {
    return (questionnaireItem.extension_
                ?.extensionOrNull(
                    'http://hl7.org/fhir/StructureDefinition/questionnaire-hidden')
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
                    'http://hl7.org/fhir/StructureDefinition/questionnaire-displayCategory')
                ?.valueCodeableConcept
                ?.coding
                ?.firstOrNull
                ?.code
                ?.value ==
            'help');
  }

  String? get titleText {
    final title = Xhtml.toXhtml(
        questionnaireItem.text, questionnaireItem.textElement?.extension_);

    final prefix = Xhtml.toXhtml(
        questionnaireItem.prefix, questionnaireItem.prefixElement?.extension_);

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
              'Duplicate linkId $linkId', currentSibling);
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
      this.level) {
    _questionnaireModel = questionnaireModel;
  }

  factory QuestionnaireItemModel._cached(
      Questionnaire questionnaire,
      QuestionnaireModel questionnaireModel,
      QuestionnaireItem questionnaireItem,
      String linkId,
      QuestionnaireItemModel? parent,
      int siblingIndex,
      int level) {
    return questionnaireModel._cachedItems.putIfAbsent(
        linkId,
        () => QuestionnaireItemModel._(questionnaire, questionnaireModel,
            questionnaireItem, linkId, parent, siblingIndex, level));
  }
}

/// Build list of [QuestionnaireItemModel] from [QuestionnaireItem] and meta-data.
class _LocationListBuilder {
  static List<QuestionnaireItemModel> _buildLocationList(
      Questionnaire _questionnaire,
      QuestionnaireModel questionnaireModel,
      List<QuestionnaireItem> _items,
      QuestionnaireItemModel? _parent,
      int _level) {
    int siblingIndex = 0;
    final itemModelList = <QuestionnaireItemModel>[];

    for (final item in _items) {
      itemModelList.add(QuestionnaireItemModel._cached(
          _questionnaire,
          questionnaireModel,
          item,
          item.linkId!,
          _parent,
          siblingIndex,
          _level));
      siblingIndex++;
    }

    return itemModelList;
  }
}
