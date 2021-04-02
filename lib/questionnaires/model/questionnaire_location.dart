import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

import '../../fhir_types/fhir_types_extensions.dart';
import '../../logging/logging.dart';
import '../../resource_provider/resource_provider.dart';
import '../view/xhtml.dart';
import 'aggregator.dart';
import 'questionnaire_exceptions.dart';
import 'questionnaire_extensions.dart';

part 'questionnaire_top_location.dart';

/// Visit FHIR [Questionnaire] through linkIds.
/// Can provide properties of current location and move to adjacent items.
class QuestionnaireLocation extends ChangeNotifier with Diagnosticable {
  final Questionnaire questionnaire;
  final QuestionnaireItem questionnaireItem;
  QuestionnaireResponse? questionnaireResponse;
  QuestionnaireResponseItem? _questionnaireResponseItem;
  final String linkId;
  final QuestionnaireLocation? parent;
  late QuestionnaireTopLocation? _top;
  final int siblingIndex;
  final int level;
  late final String logTag;
  static final logger = Logger(QuestionnaireLocation);

  QuestionnaireTopLocation get top => _top!;

  LinkedHashMap<String, QuestionnaireLocation>? _orderedItems;

  void _disableWithChildren() {
    _enabled = false;
    for (final child in children) {
      child._disableWithChildren();
    }
  }

  /// Calculate the current enablement status of this item.
  /// Sets the [enabled] property
  void _calculateEnabled() {
    bool anyTrigger = false;
    int allTriggered = 0;
    int allCount = 0;

    forEnableWhens((qew) {
      allCount++;
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          if (top.findByLinkId(qew.question!).responseItem == null) {
            anyTrigger = true;
            allTriggered++;
          }
          break;
        case QuestionnaireEnableWhenOperator.eq:
        case QuestionnaireEnableWhenOperator.ne:
          final responseCoding = top
              .findByLinkId(qew.question!)
              .responseItem
              ?.answer
              ?.firstOrNull
              ?.valueCoding;
          // TODO: More sophistication- System, cardinality, etc.
          if (responseCoding?.code == qew.answerCoding?.code) {
            logger.log('enableWhen: $responseCoding == ${qew.answerCoding}',
                level: LogLevel.debug);
            if (qew.operator_ == QuestionnaireEnableWhenOperator.eq) {
              anyTrigger = true;
              allTriggered++;
            }
          } else {
            logger.log('enableWhen: $responseCoding != ${qew.answerCoding}',
                level: LogLevel.debug);
            if (qew.operator_ == QuestionnaireEnableWhenOperator.ne) {
              anyTrigger = true;
              allTriggered++;
            }
          }
          break;
        default:
          logger.log('Unsupported operator: ${qew.operator_}.',
              level: LogLevel.warn);
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
            'enableWhen with unclear enableBehavior: ${questionnaireItem.enableBehavior}',
            questionnaireItem);
    }
  }

  bool _enabled = true;
  bool get enabled => _enabled;

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

  List<QuestionnaireLocation> get siblings {
    return _LocationListBuilder._buildLocationList(
        questionnaire, top, siblingQuestionnaireItems, parent, level);
  }

  List<QuestionnaireLocation> get children {
    return _LocationListBuilder._buildLocationList(
        questionnaire, top, childQuestionnaireItems, this, level + 1);
  }

  bool get hasNextSibling {
    return siblingQuestionnaireItems.length > siblingIndex + 1;
  }

  bool get hasPreviousSibling => siblingIndex > 0;

  QuestionnaireLocation get nextSibling => siblings.elementAt(siblingIndex + 1);

  bool get hasParent => parent != null;

  bool get hasChildren =>
      (questionnaireItem.item != null) && (questionnaireItem.item!.isNotEmpty);

  set responseItem(QuestionnaireResponseItem? questionnaireResponseItem) {
    logger.log('set responseItem $questionnaireResponseItem',
        level: LogLevel.debug);
    if (questionnaireResponseItem != _questionnaireResponseItem) {
      _questionnaireResponseItem = questionnaireResponseItem;
      top.bumpRevision();
      notifyListeners();
    }
  }

  QuestionnaireResponseItem? get responseItem => _questionnaireResponseItem;

  /// Get a [Decimal] value which can be added to a score.
  /// Returns null if not applicable (either question unanswered, or wrong type)
  Decimal? get score {
    // TODO(tiloc): isReadOnly is probably the wrong condition?
    if ((responseItem == null) || isReadOnly) {
      return null;
    }

    // Sum up ordinal values from extensions
    final ordinalExtension = responseItem
        ?.answer?.firstOrNull?.valueCoding?.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/iso21090-CO-value');
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

      if (questionnaireItem.readOnly == Boolean(true) &&
          questionnaireItem.unit == '{score}') {
        return true;
      }
    }

    return false;
  }

  /// Is this location unable to hold a value?
  bool get isStatic {
    return (questionnaireItem.type == QuestionnaireItemType.group) ||
        (questionnaireItem.type == QuestionnaireItemType.display);
  }

  /// Is this location not changeable by end-users?
  /// Read-only items might still hold a value, such as a calculated value.
  bool get isReadOnly {
    return isStatic ||
        questionnaireItem.readOnly == Boolean(true) ||
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

  LinkedHashMap<String, QuestionnaireLocation> _addChildren() {
    logger.log('_addChildren $linkId', level: LogLevel.trace);
    final LinkedHashMap<String, QuestionnaireLocation> locationMap =
        LinkedHashMap<String, QuestionnaireLocation>();
    if (locationMap.containsKey(linkId)) {
      throw QuestionnaireFormatException('Duplicate linkId: $linkId', this);
    }
    locationMap[linkId] = this;
    if (hasChildren) {
      for (final child in children) {
        locationMap.addAll(child._addChildren());
      }
    }

    return locationMap;
  }

  void _ensureOrderedItems() {
    if (_orderedItems == null) {
      final LinkedHashMap<String, QuestionnaireLocation> locationMap =
          LinkedHashMap<String, QuestionnaireLocation>();
      locationMap.addAll(_addChildren());
      QuestionnaireLocation currentSibling = this;
      while (currentSibling.hasNextSibling) {
        currentSibling = currentSibling.nextSibling;
        if (locationMap.containsKey(currentSibling.linkId)) {
          throw QuestionnaireFormatException(
              'Duplicate linkId $linkId', currentSibling);
        } else {
          locationMap.addAll(currentSibling._addChildren());
        }
      }
      _orderedItems = locationMap;
    }
  }

  /// Get an [Iterable] of [QuestionnaireLocation] in pre-order.
  /// see: https://en.wikipedia.org/wiki/Tree_traversal
  Iterable<QuestionnaireLocation> preOrder() {
    _ensureOrderedItems();
    return _orderedItems!.values;
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

  QuestionnaireLocation._(
      this.questionnaire,
      QuestionnaireTopLocation? top,
      this.questionnaireItem,
      this.linkId,
      this.parent,
      this.siblingIndex,
      this.level) {
    _top = top;
  }

  factory QuestionnaireLocation._cached(
      Questionnaire questionnaire,
      QuestionnaireTopLocation top,
      QuestionnaireItem questionnaireItem,
      String linkId,
      QuestionnaireLocation? parent,
      int siblingIndex,
      int level) {
    return top._cachedItems.putIfAbsent(
        linkId,
        () => QuestionnaireLocation._(questionnaire, top, questionnaireItem,
            linkId, parent, siblingIndex, level));
  }
}

/// Build list of [QuestionnaireLocation] from [QuestionnaireItem] and meta-data.
class _LocationListBuilder {
  static List<QuestionnaireLocation> _buildLocationList(
      Questionnaire _questionnaire,
      QuestionnaireTopLocation top,
      List<QuestionnaireItem> _items,
      QuestionnaireLocation? _parent,
      int _level) {
    int siblingIndex = 0;
    final locationList = <QuestionnaireLocation>[];

    for (final item in _items) {
      locationList.add(QuestionnaireLocation._cached(_questionnaire, top, item,
          item.linkId!, _parent, siblingIndex, _level));
      siblingIndex++;
    }

    return locationList;
  }
}
