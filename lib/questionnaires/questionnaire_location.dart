import 'package:fhir/r4.dart';
import 'package:meta/meta.dart';

/// Visit FHIR [Questionnaire] through linkIds.
/// Can provide properties of current location and move to adjacent items.
@immutable
class QuestionnaireLocation {
  final Questionnaire questionnaire;
  final QuestionnaireItem questionnaireItem;
  final String linkId;
  final QuestionnaireItem? parent;
  final int siblingIdx;
  final int level;

  /// Go to the first location top-down of the given [Questionnaire].
  /// Will throw Errors in case that the [Questionnaire] has no items.
  QuestionnaireLocation(this.questionnaire)
      : linkId = ArgumentError.checkNotNull(questionnaire.item?.first.linkId),
        questionnaireItem =
            ArgumentError.checkNotNull(questionnaire.item?.first),
        parent = null,
        siblingIdx = 0,
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
    return siblingQuestionnaireItems.length > siblingIdx + 1;
  }

  bool get hasPreviousSibling => siblingIdx > 0;

  bool get hasParent => parent != null;

  bool get hasChildren =>
      (questionnaireItem.item != null) && (questionnaireItem.item!.isNotEmpty);

  const QuestionnaireLocation._(this.questionnaire, this.questionnaireItem,
      this.linkId, this.parent, this.siblingIdx, this.level);
}

class QuestionnaireLocationIterator {
  final List<QuestionnaireLocation> locationList = <QuestionnaireLocation>[];

  QuestionnaireLocationIterator.depthFirst(
      QuestionnaireLocation startLocation) {
    if (startLocation.hasChildren) {
      for (final child in startLocation.children) {
        locationList.addAll(
            QuestionnaireLocationIterator.depthFirst(child).locationList);
      }
    }

    // TODO: Add next siblings
  }
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
