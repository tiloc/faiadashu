import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:fhir/primitive_types/code.dart';

/// The default-settings for model properties.
///
/// Properties and extensions of the FHIR resource always take precedence over the values specified here.
class QuestionnaireModelDefaults {
  // this is just an assumption what makes sense to your average human...
  static const defaultMaxDecimal = 3;

  final int maxDecimal;

  static const defaultSliderMaxValue = 100.0;
  final double sliderMaxValue;

  final Code usageMode;

  final RenderingString? Function(FillerItemModel)? prefixBuilder;

  final QuestionnaireDisabledDisplay disabledDisplay;

  /// Returns whether questions should offer an option to not answer the question
  final bool implicitNullOption;

  /// Returns whether boolean items should be tri-state.
  ///
  /// Boolean items will be tri-state if [true], or bi-state if [false].
  final bool booleanTriState;

  /// Returns a prefix, starting with 1, that provides the number
  /// of the [QuestionItemModel] within the ordered sequence of [QuestionItemModels].
  ///
  /// Returns null if the model is not answerable.
  static RenderingString? questionNumeralPrefixBuilder(
    FillerItemModel fillerItemModel,
  ) {
    if (fillerItemModel is! QuestionItemModel) {
      return null;
    }

    final thisQuestionIndex = fillerItemModel.questionnaireResponseModel
        .orderedQuestionItemModels()
        .where((qim) => qim.isAnswerable)
        .toList()
        .indexOf(fillerItemModel);

    final plainIndex = (thisQuestionIndex + 1).toString();

    return (thisQuestionIndex != -1)
        ? RenderingString.fromText(
            plainIndex,
            xhtmlText: '<b>$plainIndex</b>',
          )
        : null;
  }

  const QuestionnaireModelDefaults({
    this.maxDecimal = defaultMaxDecimal,
    this.sliderMaxValue = defaultSliderMaxValue,
    this.usageMode = usageModeCaptureDisplayNonEmptyCode,
    this.prefixBuilder,
    this.disabledDisplay = QuestionnaireDisabledDisplay.hidden,
    this.implicitNullOption = true,
    this.booleanTriState = false,
  });
}
