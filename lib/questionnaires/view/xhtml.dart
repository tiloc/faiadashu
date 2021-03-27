import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:widgets_on_fhir/questionnaires/model/model.dart';

import '../../fhir_types/fhir_types_extensions.dart';

/// Extract Xhtml from SDC extensions and build Widgets from Xhtml.
class Xhtml {
  const Xhtml._();

  static Widget? toWidget(
      BuildContext context,
      QuestionnaireTopLocation topLocation,
      String? plainText,
      List<FhirExtension>? extension,
      {double? width,
      double? height,
      Key? key}) {
    final xhtml = Xhtml.toXhtml(plainText, extension);

    if (xhtml == null) {
      return null;
    }
    const imgBase64Prefix = "<img src='data:image/png;base64,";
    const imgHashPrefix = "<img src='#";
    const imgSuffix = "'/>";
    if (xhtml.startsWith(imgBase64Prefix)) {
      final base64String = xhtml.substring(
          imgBase64Prefix.length, xhtml.length - imgSuffix.length);
      return Image.memory(
        base64.decode(base64String),
        width: width,
        height: height,
        semanticLabel: plainText,
      );
    }
    if (xhtml.startsWith(imgHashPrefix)) {
      final base64Binary = topLocation.findContainedByElementId(xhtml.substring(
              imgHashPrefix.length, xhtml.length - imgSuffix.length + 1))
          as Binary?;
      final base64String = base64Binary?.data?.value;
      return Image.memory(
        base64.decode(base64String!),
        width: width,
        height: height,
        semanticLabel: plainText,
      );
    } else {
      return HTML.toRichText(context, xhtml);
    }
  }

  static String? toXhtml(String? plainText, List<FhirExtension>? extension) {
    final xhtml = extension
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/rendering-xhtml')
        ?.valueString;

    final renderingStyle = extension
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/rendering-style')
        ?.valueString;

    return (xhtml != null)
        ? ((renderingStyle != null)
            ? '<div style="$renderingStyle">$xhtml</div>'
            : xhtml)
        : (renderingStyle != null)
            ? '<div style="$renderingStyle">$plainText</div>'
            : plainText;
  }
}
