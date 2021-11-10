import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';

import '../../../fhir_types/fhir_types.dart';
import '../../../logging/logging.dart';
import '../../../resource_provider/resource_provider.dart';
import '../../questionnaires.dart';

part 'questionnaire_model.dart';

/// Models an individual item of a questionnaire.
///
/// Represents the [QuestionnaireItem] of the FHIR domain model.
///
/// Provides properties of the item.
///
/// Provides access to adjacent items (parent, siblings, children).
class QuestionnaireItemModel with Diagnosticable {
  final Questionnaire questionnaire;
  final QuestionnaireItem questionnaireItem;
  final String linkId;
  final QuestionnaireItemModel? parent;
  late QuestionnaireModel? _questionnaireModel;
  final int siblingIndex;
  final int level;
//  static final _qimLogger = Logger(QuestionnaireItemModel);

  QuestionnaireModel get questionnaireModel => _questionnaireModel!;

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

  /// Returns whether the item allows repetition.
  ///
  /// This will not return `true` for repeating `choice` or `open-choice` items,
  /// as these are multiple choice, rather than truly repeating.
  bool get isRepeating =>
      questionnaireItem.repeats == Boolean(true) && !isCodingType;

  bool get isRequired => questionnaireItem.required_ == Boolean(true);

  bool get hasConstraint => constraintExpression != null;

  String? get constraintExpression {
    return questionnaireItem.extension_
        ?.firstWhereOrNull(
          (ext) =>
              ext.url?.value.toString() ==
              'http://hl7.org/fhir/StructureDefinition/questionnaire-constraint',
        )
        ?.extension_
        ?.firstWhereOrNull((ext) => ext.url?.value.toString() == 'expression')
        ?.valueString;
  }

  String? get constraintHuman {
    return questionnaireItem.extension_
        ?.firstWhereOrNull(
          (ext) =>
              ext.url?.value.toString() ==
              'http://hl7.org/fhir/StructureDefinition/questionnaire-constraint',
        )
        ?.extension_
        ?.firstWhereOrNull((ext) => ext.url?.value.toString() == 'human')
        ?.valueString;
  }

  /// Is this item's value calculated?
  bool get isCalculated {
    return isCalculatedExpression || isTotalScore;
  }

  /// Is this item a total score calculation?
  bool get isTotalScore {
    // Checking for read-only is relevant,
    // as there are also input fields (e.g. pain score) with unit {score}.
    return (questionnaireItem.type == QuestionnaireItemType.quantity ||
            questionnaireItem.type == QuestionnaireItemType.decimal) &&
        ((questionnaireItem.readOnly == Boolean(true) &&
                questionnaireItem.unit?.display == '{score}') ||
            questionnaireItem.extension_
                    ?.firstWhereOrNull(
                      (ext) =>
                          ext.url?.value.toString() ==
                          calculatedExpressionExtensionUrl,
                    )
                    ?.valueExpression
                    ?.name
                    .toString() ==
                'score');
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

  /// Is this itemModel unable to hold a value?
  bool get isStatic => isGroup || isDisplay;

  bool get isGroup => questionnaireItem.type == QuestionnaireItemType.group;

  bool get isDisplay => questionnaireItem.type == QuestionnaireItemType.display;

  bool get isQuestion => !isDisplay && !isGroup;

  bool get isCodingType {
    return questionnaireItem.type == QuestionnaireItemType.choice ||
        questionnaireItem.type == QuestionnaireItemType.open_choice;
  }

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

  /// Returns the `shortText` provided for the item, or null.
  String? get shortText {
    return questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-shortText',
        )
        ?.valueString;
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
