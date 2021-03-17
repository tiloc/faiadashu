import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../util/safe_access_extensions.dart';

/// Build Widgets from Xhtml
class Xhtml {
  static Widget? buildFromString(BuildContext context, String? xhtml,
      {Key? key}) {
    if (xhtml == null) {
      return null;
    }
    const imgBase64Prefix = "<img src='data:image/png;base64,";
    if (xhtml.startsWith(imgBase64Prefix)) {
      final base64String =
          xhtml.substring(imgBase64Prefix.length, xhtml.length - "'/>".length);
      return Image.memory(base64.decode(base64String));
    } else {
      return HTML.toRichText(context, xhtml);
    }
  }

  static Widget? buildFromExtension(
      BuildContext context, List<FhirExtension>? extension,
      {Key? key}) {
    final xhtml = extension
        ?.extensionOrNull(
            'http://hl7.org/fhir/StructureDefinition/rendering-xhtml')
        ?.valueString;

    return Xhtml.buildFromString(context, xhtml);
  }
}
