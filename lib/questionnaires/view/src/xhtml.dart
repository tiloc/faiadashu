import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../fhir_types/fhir_types.dart';
import '../../../logging/logging.dart';
import '../../model/model.dart';

/// Extract Xhtml from SDC extensions and build Widgets from Xhtml.
class Xhtml {
  static final Logger _logger = Logger(Xhtml);
  const Xhtml._();

  static Widget? toWidget(
    BuildContext context,
    QuestionnaireModel questionnaireModel,
    String? plainText,
    List<FhirExtension>? extension, {
    double? width,
    double? height,
    Key? key,
  }) {
    _logger.trace('enter toWidget $plainText');
    final xhtml = Xhtml.toXhtml(plainText, extension);

    if (xhtml == null) {
      return null;
    }
    const imgPngBase64Prefix = "<img src='data:image/png;base64,";
    const imgJpgBase64Prefix = "<img src='data:image/jpeg;base64,";
    const imgHashPrefix = "<img src='#";
    const imgSuffix = "'/>";
    if (xhtml.startsWith(imgPngBase64Prefix)) {
      final base64String = xhtml.substring(
        imgPngBase64Prefix.length,
        xhtml.length - imgSuffix.length,
      );
      _logger.debug('Length of base64: ${base64String.length}');

      return Base64Image(
        base64String,
        width: width,
        height: height,
        semanticLabel: plainText,
      );
    }
    if (xhtml.startsWith(imgJpgBase64Prefix)) {
      final base64String = xhtml.substring(
        imgJpgBase64Prefix.length,
        xhtml.length - imgSuffix.length,
      );
      _logger.debug('Length of base64: ${base64String.length}');

      return Base64Image(
        base64String,
        width: width,
        height: height,
        semanticLabel: plainText,
      );
    }
    if (xhtml.startsWith(imgHashPrefix)) {
      final elementId = xhtml.substring(
        imgHashPrefix.length,
        xhtml.length - imgSuffix.length + 1,
      );
      final base64Binary =
          questionnaireModel.findContainedByElementId(elementId) as Binary?;
      final base64String = base64Binary?.data?.value;
      if (base64String == null) {
        throw QuestionnaireFormatException(
          'Malformed base64 string for image element ID $elementId',
          elementId,
        );
      }

      return Base64Image(
        base64String,
        width: width,
        height: height,
        semanticLabel: plainText,
      );
    } else {
      return HTML.toRichText(
        context,
        xhtml,
        defaultTextStyle: Theme.of(context).textTheme.bodyText1,
      );
    }
  }

  static String? toXhtml(String? plainText, List<FhirExtension>? extension) {
    final xhtml = extension
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/rendering-xhtml',
        )
        ?.valueString;

    final renderingStyle = extension
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/rendering-style',
        )
        ?.valueString;

    return (xhtml != null)
        ? ((renderingStyle != null)
            ? '<span style="$renderingStyle">$xhtml</span>'
            : xhtml)
        : (renderingStyle != null)
            ? '<span style="$renderingStyle">$plainText</span>'
            : plainText;
  }
}
