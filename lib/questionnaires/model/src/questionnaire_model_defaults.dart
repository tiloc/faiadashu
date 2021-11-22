import 'package:fhir/primitive_types/code.dart';

import '../item/item.dart';

/// The default-settings for model properties.
///
/// Extensions always take precedence over the values specified here.
class QuestionnaireModelDefaults {
  // this is just an assumption what makes sense to your average human...
  static const defaultMaxDecimal = 3;

  final int maxDecimal;

  static const defaultSliderMaxValue = 100.0;
  final double sliderMaxValue;

  final Code usageMode;

  const QuestionnaireModelDefaults({
    this.maxDecimal = defaultMaxDecimal,
    this.sliderMaxValue = defaultSliderMaxValue,
    this.usageMode = usageModeCaptureDisplayNonEmptyCode,
  });
}
