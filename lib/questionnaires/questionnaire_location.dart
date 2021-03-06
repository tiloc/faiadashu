import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

/// Visit FHIR [Questionnaire] through linkIds.
/// Can provide properties of current location and move to adjacent items.
@immutable
class QuestionnaireLocation with Diagnosticable {
  final Questionnaire questionnaire;
  final QuestionnaireItem questionnaireItem;
  final String linkId;
  final QuestionnaireItem? parent;
  final int siblingIndex;
  final int level;

  /// Go to the first location top-down of the given [Questionnaire].
  /// Will throw [Error]s in case this [Questionnaire] has no items.
  QuestionnaireLocation(this.questionnaire)
      : linkId = ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
        questionnaireItem =
            ArgumentError.checkNotNull(questionnaire.item?.first),
        parent = null,
        siblingIndex = 0,
        level = 0;

  /// All siblings at the current level as FHIR [QuestionnaireItem].
  /// Includes the current item.
  List<QuestionnaireItem> get siblingQuestionnaireItems {
    if (level == 0) {
      return questionnaire.item!;
    } else {
      return parent!.item!;
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
        questionnaire, siblingQuestionnaireItems, parent, level);
  }

  List<QuestionnaireLocation> get children {
    return _LocationListBuilder._buildLocationList(
        questionnaire, childQuestionnaireItems, questionnaireItem, level + 1);
  }

  bool get hasNextSibling {
    return siblingQuestionnaireItems.length > siblingIndex + 1;
  }

  bool get hasPreviousSibling => siblingIndex > 0;

  QuestionnaireLocation get nextSibling => siblings.elementAt(siblingIndex + 1);

  bool get hasParent => parent != null;

  bool get hasChildren =>
      (questionnaireItem.item != null) && (questionnaireItem.item!.isNotEmpty);

  /// Find the [QuestionnaireLocation] that corresponds to the linkId.
  /// Throws an [Exception] when no such [QuestionnaireLocation] exists.
  QuestionnaireLocation findByLinkId(String linkId) {
    return preOrder().firstWhere(
        (questionnaireLocation) => questionnaireLocation.linkId == linkId);
  }

  List<QuestionnaireLocation> _addChildren() {
    final List<QuestionnaireLocation> locationList = <QuestionnaireLocation>[];

    locationList.add(this);
    if (hasChildren) {
      for (final child in children) {
        locationList.addAll(child._addChildren());
      }
    }

    return locationList;
  }

  /// Build a list of [QuestionnaireLocation] in pre-order.
  /// see: https://en.wikipedia.org/wiki/Tree_traversal
  List<QuestionnaireLocation> preOrder() {
    final List<QuestionnaireLocation> locationList = <QuestionnaireLocation>[];
    locationList.addAll(_addChildren());
    QuestionnaireLocation currentSibling = this;
    while (currentSibling.hasNextSibling) {
      currentSibling = currentSibling.nextSibling;
      locationList.addAll(currentSibling._addChildren());
    }
    return locationList;
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

  const QuestionnaireLocation._(this.questionnaire, this.questionnaireItem,
      this.linkId, this.parent, this.siblingIndex, this.level);
}

/// Build list of [QuestionnaireLocation] from [QuestionnaireItem] and meta-data.
class _LocationListBuilder {
  static List<QuestionnaireLocation> _buildLocationList(
      Questionnaire _questionnaire,
      List<QuestionnaireItem> _items,
      QuestionnaireItem? _parent,
      int _level) {
    int siblingIndex = 0;
    final locationList = <QuestionnaireLocation>[];

    for (final item in _items) {
      locationList.add(QuestionnaireLocation._(
          _questionnaire, item, item.linkId!, _parent, siblingIndex, _level));
      siblingIndex++;
    }

    return locationList;
  }
}
