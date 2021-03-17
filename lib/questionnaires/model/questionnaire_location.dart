import 'dart:collection';
import 'dart:developer' as developer;

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

import '../../util/safe_access_extensions.dart';

class QuestionnaireTopLocation extends QuestionnaireLocation {
  final Map<String, QuestionnaireLocation> _cachedItems = {};

  /// Create the first location top-down of the given [Questionnaire].
  /// Will throw [Error]s in case this [Questionnaire] has no items.
  QuestionnaireTopLocation.fromQuestionnaire(Questionnaire questionnaire)
      : super._(
            questionnaire,
            null,
            ArgumentError.checkNotNull(questionnaire.item?.first),
            ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
            null,
            0,
            0) {
    _top = this;
    // This will set up the traversal order and fill up the cache.
    _ensureOrderedItems();
  }

  void bumpRevision() {
    developer.log('QuestionnaireTopLocation.bumpRevision', level: 500);
    _revision += 1;
    notifyListeners();
  }

  /// Find a contained element by its id.
  /// Id may start with a leading '#', which will be stripped.
  /// [elementId] == null will return null.
  Resource? findContainedByElementId(String? elementId) {
    if (elementId == null) {
      return null;
    }
    final key = elementId.startsWith('#')
        ? elementId.substring(1)
        : elementId; // Strip leading #
    return questionnaire.contained
        ?.firstWhereOrNull((element) => key == element.id?.toString());
  }

  int get revision => _revision;

  /// Find the [QuestionnaireLocation] that corresponds to the linkId.
  /// Throws an [Exception] when no such [QuestionnaireLocation] exists.
  QuestionnaireLocation findByLinkId(String linkId) {
    return _orderedItems![linkId]!;
  }

  /// Update the current enablement status of all items.
  void updateEnableWhen() {
    developer.log('updateEnableWhen()', level: 500);
    for (final location in preOrder()) {
      location._enabled = true;
    }

    for (final location in preOrder()) {
      location._calculateEnabled();
    }
    bumpRevision();
  }

  /// Activate the "enableWhen" behaviors.
  void activateEnableWhen() {
    for (final location in preOrder()) {
      location.forEnableWhens((qew) {
        findByLinkId(qew.question!).addListener(() => updateEnableWhen());
      });
    }

    updateEnableWhen();
  }
}

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
  int _revision = 1;

  QuestionnaireTopLocation get top => _top!;

  LinkedHashMap<String, QuestionnaireLocation>? _orderedItems;

  void _disableWithChildren() {
    _enabled = false;
    for (final child in children) {
      child._disableWithChildren();
    }
  }

  /// Calculate the current enablement status of this item.
  /// Sets the [enabled] property and returns true if status has changed.
  void _calculateEnabled() {
    forEnableWhens((qew) {
      if (qew.operator_ == QuestionnaireEnableWhenOperator.exists) {
        if (top.findByLinkId(qew.question!).responseItem == null) {
          _disableWithChildren();
        }
      } else {
        developer.log('Unsupported operator: ${qew.operator_}.', level: 900);
      }
    });
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

      if (questionnaireItem.extension_
              ?.extensionOrNull(
                  'http://hl7.org/fhir/StructureDefinition/questionnaire-unit')
              ?.valueCoding
              ?.display ==
          '{score}') {
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
    return questionnaireItem.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl')
            ?.valueCodeableConcept
            ?.coding
            ?.firstOrNull
            ?.code
            ?.value ==
        'help';
  }

  R? applyIfExists<R, T>(R Function(T?) f, T? arg) =>
      (arg == null) ? null : f(arg);

  String? get text {
    return questionnaireItem.textElement?.extension_
            ?.extensionOrNull(
                'http://hl7.org/fhir/StructureDefinition/rendering-xhtml')
            ?.valueString ??
        applyIfExists<String, String>(
            (renderingStyle) =>
                '<div style="$renderingStyle">${questionnaireItem.text}</div>',
            questionnaireItem.textElement?.extension_
                ?.extensionOrNull(
                    'http://hl7.org/fhir/StructureDefinition/rendering-style')
                ?.valueString) ??
        questionnaireItem.text;
  }

  LinkedHashMap<String, QuestionnaireLocation> _addChildren() {
    final LinkedHashMap<String, QuestionnaireLocation> locationMap =
        LinkedHashMap<String, QuestionnaireLocation>();

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
        locationMap.addAll(currentSibling._addChildren());
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
