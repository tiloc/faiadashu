import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../fhir_types/fhir_types.dart';
import '../../../logging/logging.dart';
import '../../model/model.dart';

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
    final xhtmlString = XhtmlString.fromText(plainText, extensions: extensions);

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
    XhtmlString xhtmlString, {
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
    if (xhtml.startsWith(imgJpgBase64Prefix)) {
      final base64String = xhtml.substring(
        imgJpgBase64Prefix.length,
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
