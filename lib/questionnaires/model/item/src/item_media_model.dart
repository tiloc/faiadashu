import 'dart:convert';

import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4/general_types/general_types.dart';
import 'package:meta/meta.dart';

/// Represents an itemMedia, or itemAnswerMedia.
@immutable
class ItemMediaModel {
  static const _htmlEscape = HtmlEscape();

  final Attachment attachment;
  final FhirResourceProvider? mediaProvider;
  final RenderingString? altText;

  const ItemMediaModel._(this.attachment, {this.mediaProvider, this.altText});

  String toXhtml() {
    final altText = this.altText;
    final attachmentTitle = attachment.title;

    final altTagContent = attachmentTitle != null
        ? _htmlEscape.convert(attachmentTitle)
        : altText != null
            ? _htmlEscape.convert(altText.plainText)
            : '';

    return '<img alt="$altTagContent" src="data:${attachment.contentType?.value!};base64,${attachment.data!}" />';
  }

  static ItemMediaModel? fromAttachment(
    Attachment? attachment, {
    FhirResourceProvider? mediaProvider,
    RenderingString? altText,
  }) {
    final supportedAttachment = attachment != null &&
        (attachment.contentType?.value?.startsWith('image/') ?? false) &&
        attachment.data != null;

    return supportedAttachment
        ? ItemMediaModel._(
            attachment,
            mediaProvider: mediaProvider,
            altText: altText,
          )
        : null;
  }
}
