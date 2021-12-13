import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../fhir_types/fhir_types.dart';
import '../../../logging/logging.dart';
import '../../model/model.dart';

// OPTIMIZE: Can this wrapper around a child be avoided?

/// Display XHTML formatted texts.
class Xhtml extends StatelessWidget {
  static final Logger _logger = Logger(Xhtml);

  final Widget _child;

  const Xhtml._(this._child);

  factory Xhtml.fromPlainTextAndExtensions(
    BuildContext context,
    String plainText, {
    List<FhirExtension>? extensions,
    QuestionnaireModel? questionnaireModel,
    double? imageWidth,
    double? imageHeight,
    TextStyle? defaultTextStyle,
    Key? key,
  }) {
    final xhtmlString =
        RenderingString.fromText(plainText, extensions: extensions);

    return Xhtml.fromXhtmlString(
      context,
      xhtmlString,
      questionnaireModel: questionnaireModel,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      defaultTextStyle: defaultTextStyle,
      key: key,
    );
  }

  factory Xhtml.fromXhtmlString(
    BuildContext context,
    RenderingString xhtmlString, {
    QuestionnaireModel? questionnaireModel,
    double? imageWidth,
    double? imageHeight,
    TextStyle? defaultTextStyle,
    Key? key,
  }) {
    _logger.trace('enter fromXhtmlString $xhtmlString');

    final xhtml = xhtmlString.xhtmlText;
    final plainText = xhtmlString.plainText;

    if (xhtmlString.isPlain) {
      return Xhtml._(
        Text(
          plainText,
          style: defaultTextStyle,
          semanticsLabel: plainText,
          key: key,
        ),
      );
    }

    const imgSuffix = "'/>";

    for (final contentType in [
      'image/png',
      'image/jpeg',
    ]) {
      final imgPrefix = "<img src='data:$contentType;base64,";

      if (xhtml.startsWith(imgPrefix)) {
        final base64String = xhtml.substring(
          imgPrefix.length,
          xhtml.length - imgSuffix.length,
        );

        _logger.debug('Length of base64: ${base64String.length}');

        return Xhtml._(
          Base64Image(
            base64String,
            width: imageWidth,
            height: imageHeight,
            semanticLabel: plainText,
            key: key,
          ),
        );
      }
    }

    const imgHashPrefix = "<img src='#";
    if (xhtml.startsWith(imgHashPrefix)) {
      final elementId = xhtml.substring(
        imgHashPrefix.length,
        xhtml.length - imgSuffix.length + 1,
      );
      if (questionnaireModel == null) {
        throw StateError(
          'questionnaireModel missing. Cannot resolve #$elementId.',
        );
      }

      final base64Binary =
          questionnaireModel.findContainedByElementId(elementId) as Binary?;
      final base64String = base64Binary?.data?.value;
      if (base64String == null) {
        throw QuestionnaireFormatException(
          'Malformed base64 string for image element ID $elementId',
          elementId,
        );
      }

      return Xhtml._(
        Base64Image(
          base64String,
          width: imageWidth,
          height: imageHeight,
          semanticLabel: plainText,
          key: key,
        ),
      );
    } else {
      return Xhtml._(
        RichText(
          key: key,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          text: HTML.toTextSpan(
            context,
            xhtml,
            defaultTextStyle:
                defaultTextStyle ?? Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
