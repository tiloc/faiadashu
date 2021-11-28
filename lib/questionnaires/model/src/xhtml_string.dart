import 'dart:convert';

import 'package:fhir/r4/basic_types/fhir_extension.dart';

import '../../../fhir_types/fhir_types.dart';

/// Representation of a Fhir string which is plain text with optional
/// information regarding styled rendering.
class XhtmlString {
  /// The plain, unstyled text. Suitable as a semantic label.
  final String plainText;

  /// The XHTML representation of the string.
  ///
  /// Might be constructed by combining plainText with renderStyle
  ///
  /// Is escaped for immediate output.
  final String xhtmlText;

  /// Is this an unstyled, plain text?
  final bool isPlain;

  /// The unaltered rendering-style extension
  final String? renderingStyle;

  /// The unaltered rendering-xhtml extension
  final String? renderingXhtml;

  /// Construct an [XhtmlString] from the provided attributes.
  ///
  /// No alterations of the attributes will take place, in particular,
  /// [xhtmlText] will not be calculated or escaped.
  const XhtmlString._(
    this.plainText,
    this.xhtmlText,
    this.isPlain, {
    this.renderingStyle,
    this.renderingXhtml,
  });

  /// Construct an [XhtmlString] from plainText and optional extensions.
  ///
  /// The XHTML representation can be either explicitly provided, or will be
  /// generated from plainText and the provided extensions.
  ///
  /// CAUTION: Explicitly provided xhtmlText must be escaped by the caller!
  ///
  /// Extensions:
  /// -----------
  /// * rendering-style
  /// * rendering-xhtml
  factory XhtmlString.fromText(
    String plainText, {
    List<FhirExtension>? extensions,
    String? xhtmlText,
  }) {
    final renderingXhtml = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/rendering-xhtml',
        )
        ?.valueString;

    final renderingStyle = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/rendering-style',
        )
        ?.valueString;

    final escapedPlainText = _htmlEscape.convert(plainText);

    final outputXhtmlText = (xhtmlText != null)
        ? xhtmlText
        : (renderingXhtml != null)
            ? ((renderingStyle != null)
                ? '<span style="$renderingStyle">$renderingXhtml</span>'
                : renderingXhtml)
            : (renderingStyle != null)
                ? '<span style="$renderingStyle">$escapedPlainText</span>'
                : plainText;

    return XhtmlString._(
      plainText,
      outputXhtmlText,
      xhtmlText == null && renderingStyle == null && renderingXhtml == null,
      renderingStyle: renderingStyle,
      renderingXhtml: renderingXhtml,
    );
  }

  static const _htmlEscape = HtmlEscape();

  static const nullText = XhtmlString._('——', '&mdash;&mdash;', false);
}

extension FDashXhtmlIterableExtension on Iterable<XhtmlString> {
  /// Concatenate Xhtml strings.
  ///
  /// * For an empty list: Returns the given empty string.
  /// * For a list with a single element: Returns the original.
  /// * For a list with multiple elements: Combines plain texts and XHTML texts with separator. Discards the extensions.
  XhtmlString concatenateXhtml(
    String plainSeparator, [
    String? xhtmlSeparator,
    XhtmlString emptyString = XhtmlString.nullText,
  ]) {
    if (isEmpty) {
      return emptyString;
    }

    if (length == 1) {
      return first;
    }

    final plainTextList = map<String>((element) => element.plainText);
    final xhtmlTextList = map<String>(
      (element) => element.xhtmlText,
    );

    final isPlainList =
        fold<bool>(true, (prev, element) => prev && element.isPlain);

    return XhtmlString._(
      plainTextList.join(plainSeparator),
      xhtmlTextList.join(xhtmlSeparator ?? plainSeparator),
      isPlainList,
    );
  }
}
