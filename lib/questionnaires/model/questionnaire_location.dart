import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:faiadashu/questionnaires/valueset/valueset_provider.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

import '../../fhir_types/fhir_types_extensions.dart';
import '../../logging/logging.dart';
import '../view/xhtml.dart';
import 'aggregator.dart';
import 'questionnaire_exceptions.dart';
import 'questionnaire_extensions.dart';

/// Visit FHIR [Questionnaire] through linkIds.
/// This marks the entry point into the [Questionnaire].
/// All contained items and children are expressed as [QuestionnaireLocation].
class QuestionnaireTopLocation extends QuestionnaireLocation {
  final Map<String, QuestionnaireLocation> _cachedItems = {};
  List<QuestionnaireLocation>? _enabledWhens;
  final List<Aggregator>? _aggregators;
  final ValueSetProvider? _valueSetProvider;
  static final logger = Logger(QuestionnaireTopLocation);

  /// Create the first location top-down of the given [Questionnaire].
  /// Will throw [Error]s in case this [Questionnaire] has no items.
  /// A newly constructed [QuestionnaireTopLocation] will require an invocation of
  /// [init], or it might malfunction!
  QuestionnaireTopLocation.fromQuestionnaire(Questionnaire questionnaire,
      {List<Aggregator>? aggregators, ValueSetProvider? valueSetProvider})
      : _aggregators = aggregators,
        _valueSetProvider = valueSetProvider,
        super._(
            questionnaire,
            null,
            ArgumentError.checkNotNull(questionnaire.item?.first),
            ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
            null,
            0,
            0) {
    logger.log('QuestionnaireTopLocation.fromQuestionnaire',
        level: LogLevel.debug);
    _top = this;
    // This will set up the traversal order and fill up the cache.
    _ensureOrderedItems();

    for (final location in preOrder()) {
      final enableWhens = location.questionnaireItem.enableWhen;
      if ((enableWhens != null) && enableWhens.isNotEmpty) {
        if (_enabledWhens == null) {
          _enabledWhens = [location];
        } else {
          _enabledWhens!.add(location);
        }
      }
    }

    logger.log('_enabledWhens: $_enabledWhens', level: LogLevel.debug);

    if (aggregators != null) {
      for (final aggregator in aggregators) {
        aggregator.init(this);
        // Assumption: aggregators that don't autoAggregate will have their aggregate method invoked manually when it matters.
        if (aggregator.autoAggregate) {
          aggregator.aggregate(null, notifyListeners: true);
        }
      }
    }

    activateEnableWhen();
  }

  /// Bring the model into a fully functional state.
  /// Unfortunately, this is necessary, as some operations are async and
  /// you cannot have an async constructor.
  Future<void> initState() async {
    await _valueSetProvider?.init();
  }

  T aggregator<T extends Aggregator>() {
    if (_aggregators == null) {
      throw StateError('Aggregators have not been specified in constructor.');
    }
    return (_aggregators?.firstWhere((aggregator) => aggregator is T) as T?)!;
  }

  void bumpRevision({bool notifyListeners = true}) {
    final newRevision = _revision + 1;
    logger.log(
      'QuestionnaireTopLocation.bumpRevision $notifyListeners: $_revision -> $newRevision',
      level: LogLevel.debug,
    );
    _revision = newRevision;
    if (notifyListeners) {
      this.notifyListeners();
    }
  }

  /// Get a [ValueSet] which is not contained in the [Questionnaire].
  ValueSet? getValueSet(String uri) {
    return _valueSetProvider?.getValueSet(uri);
  }

  /// Find a contained element by its id.
  /// Id may start with a leading '#', which will be stripped.
  /// [elementId] == null will return null.
  /// Will throw [QuestionnaireFormatException] if [elementId] cannot be found.
  Resource? findContainedByElementId(String? elementId) {
    if (elementId == null) {
      return null;
    }

    if (questionnaire.contained == null) {
      throw QuestionnaireFormatException(
          'Questionnaire does not have contained elements.', questionnaire);
    }

    final key = elementId.startsWith('#')
        ? elementId.substring(1)
        : elementId; // Strip leading #

    for (final resource in questionnaire.contained!) {
      if (key == resource.id?.toString()) {
        return resource;
      }

      if (resource.resourceType == R4ResourceType.Bundle) {
        final entries = (resource as Bundle).entry;
        if (entries == null) {
          continue;
        }
        for (final entry in entries) {
          if (key == entry.resource?.id?.toString()) {
            return entry.resource;
          }
        }
      }
    }

    throw QuestionnaireFormatException(
        'Questionnaire does not contain element with id #$elementId',
        questionnaire.contained);
  }

  int get revision => _revision;

  /// Find the [QuestionnaireLocation] that corresponds to the linkId.
  /// Throws an [Exception] when no such [QuestionnaireLocation] exists.
  QuestionnaireLocation findByLinkId(String linkId) {
    return _orderedItems![linkId]!;
  }

  QuestionnaireResponseStatus responseStatus =
      QuestionnaireResponseStatus.unknown;

  /// Update the current enablement status of all items.
  void updateEnableWhen({bool notifyListeners = true}) {
    if (_enabledWhens == null) {
      logger.log('updateEnableWhen: no conditional items',
          level: LogLevel.trace);
      return;
    }
    logger.log('updateEnableWhen()', level: LogLevel.trace);

    final previouslyEnabled = List<bool>.generate(
        preOrder().length, (index) => preOrder().elementAt(index).enabled,
        growable: false);
    logger.log('prevEnabled: $previouslyEnabled', level: LogLevel.trace);
    for (final location in preOrder()) {
      location._enabled = true;
    }

    for (final location in _enabledWhens!) {
      location._calculateEnabled();
    }
    final afterEnabled = List<bool>.generate(
        preOrder().length, (index) => preOrder().elementAt(index).enabled,
        growable: false);
    logger.log('afterEnabled: $afterEnabled', level: LogLevel.trace);

    if (!listEquals(previouslyEnabled, afterEnabled)) {
      bumpRevision(notifyListeners: notifyListeners);
    } else {
      logger.log('enableWhen unchanged.', level: LogLevel.debug);
    }
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
    if (questionnaireItem.enableBehavior != null &&
        questionnaireItem.enableBehavior !=
            QuestionnaireItemEnableBehavior.any) {
      logger.log(
          'Unsupported enableBehavior: ${questionnaireItem.enableBehavior}',
          level: LogLevel.warn);
    }
    forEnableWhens((qew) {
      switch (qew.operator_) {
        case QuestionnaireEnableWhenOperator.exists:
          if (top.findByLinkId(qew.question!).responseItem == null) {
            _disableWithChildren();
          }
          break;
        case QuestionnaireEnableWhenOperator.eq:
          final responseCoding = top
              .findByLinkId(qew.question!)
              .responseItem
              ?.answer
              ?.firstOrNull
              ?.valueCoding;
          // TODO: More sophistication? System, cardinality, etc.
          if (responseCoding?.code != qew.answerCoding?.code) {
            logger.log(
                'enableWhen: no equality $responseCoding != ${qew.answerCoding}',
                level: LogLevel.debug);
            _disableWithChildren();
          }
          break;
        default:
          logger.log('Unsupported operator: ${qew.operator_}.',
              level: LogLevel.warn);
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
