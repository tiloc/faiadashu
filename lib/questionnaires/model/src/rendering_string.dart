import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/foundation.dart';
import 'package:markdown/markdown.dart';

import '../../../fhir_types/fhir_types.dart';

/// Representation of a Fhir string which is plain text with optional
/// information regarding styled rendering.
///
/// See: http://hl7.org/fhir/R4/rendering-extensions.html
class RenderingString with Diagnosticable {
  /// The plain, unstyled text. Suitable as a semantic label.
  final String plainText;

  /// The XHTML representation of the string.
  ///
  /// Might be constructed by combining plainText with renderStyle
  /// Will not include the media attachment.
  ///
  /// Is escaped for immediate output.
  final String xhtmlText;

  /// Is this an unstyled, plain text?
  final bool isPlain;

  /// The unaltered rendering-style extension
  final String? renderingStyle;

  /// The unaltered rendering-xhtml extension
  final String? renderingXhtml;

  /// The unaltered rendering-markdown extension
  final Markdown? renderingMarkdown;

  /// A media attachment associated with this text
  final Attachment? mediaAttachment;

  bool get hasMedia => mediaAttachment != null;

  /// For [RenderingString]s without media attachment: same as [xhtmlText].
  ///
  /// With media attachment:
  /// Will place image media into an <img> tag as base64 encoded binary.
  /// plainText will be used for the alt-attribute.
  ///
  /// This will include the media attachment and might thus be very large.
  ///
  /// As a fallback, for unsupported media types: same as [xhtmlText].
  String get xhtmlTextWithMedia {
    final mediaAttachment = this.mediaAttachment;

    return mediaAttachment == null
        ? xhtmlText
        : (mediaAttachment.contentType?.value?.startsWith('image/') ?? false) &&
                mediaAttachment.data != null
            ? '<img alt="${_htmlEscape.convert(plainText)}" src="data:${mediaAttachment.contentType?.value!};base64,${mediaAttachment.data!}">'
            : xhtmlText;
  }

  /// Construct an [RenderingString] from the provided attributes.
  ///
  /// No alterations of the attributes will take place, in particular,
  /// [xhtmlText] will not be calculated or escaped.
  const RenderingString._(
    this.plainText,
    this.xhtmlText,
    this.isPlain, {
    this.renderingStyle,
    this.renderingXhtml,
    this.renderingMarkdown,
    this.mediaAttachment,
  });

  /// Construct an [RenderingString] from plainText and optional extensions.
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
  factory RenderingString.fromText(
    String plainText, {
    List<FhirExtension>? extensions,
    String? xhtmlText,
    Attachment? mediaAttachment,
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

    final renderingMarkdown = extensions
        ?.extensionOrNull(
          'http://hl7.org/fhir/StructureDefinition/rendering-markdown',
        )
        ?.valueMarkdown;

    final escapedPlainText = _htmlEscape.convert(plainText);

    final outputXhtmlText = (xhtmlText != null)
        ? xhtmlText
        : (renderingXhtml != null)
            ? ((renderingStyle != null)
                ? '<span style="$renderingStyle">$renderingXhtml</span>'
                : renderingXhtml)
            : (renderingMarkdown != null)
                ? markdownToHtml(
                    renderingMarkdown.value ?? '',
                    extensionSet: ExtensionSet.gitHubFlavored,
                  )
                : (renderingStyle != null)
                    ? '<span style="$renderingStyle">$escapedPlainText</span>'
                    : plainText;

    return RenderingString._(
      plainText,
      outputXhtmlText,
      xhtmlText == null &&
          renderingStyle == null &&
          renderingXhtml == null &&
          renderingMarkdown == null,
      renderingStyle: renderingStyle,
      renderingXhtml: renderingXhtml,
      renderingMarkdown: renderingMarkdown,
      mediaAttachment: mediaAttachment,
    );
  }

  static const _htmlEscape = HtmlEscape();

  static const nullText = RenderingString._('——', '&mdash;&mdash;', false);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('plainText', plainText));
    properties.add(
      FlagProperty(
        'media',
        value: hasMedia,
        ifTrue: 'HAS MEDIA',
      ),
    );
  }
}

extension FDashXhtmlIterableExtension on Iterable<RenderingString> {
  /// Concatenate Xhtml strings.
  ///
  /// * For an empty list: Returns the given empty string.
  /// * For a list with a single element: Returns the original.
  /// * For a list with multiple elements: Combines plain texts and XHTML texts with separator. Discards the extensions.
  RenderingString concatenateXhtml(
    String plainSeparator, [
    String? xhtmlSeparator,
    RenderingString emptyString = RenderingString.nullText,
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

    return RenderingString._(
      plainTextList.join(plainSeparator),
      xhtmlTextList.join(xhtmlSeparator ?? plainSeparator),
      isPlainList,
    );
  }
}
