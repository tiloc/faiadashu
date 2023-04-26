import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:faiadashu/questionnaires/model/model.dart';
import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4/general_types/general_types.dart';
import 'package:flutter/material.dart';

/// Image [Widget] for itemMedia extension
class ItemMediaImage extends StatelessWidget {
  static final _logger = Logger(ItemMediaImage);

  final Widget itemImageWidget;

  const ItemMediaImage._(this.itemImageWidget);

  static Widget? fromItemMedia(
    ItemMediaModel? itemMediaModel, {
    Key? key,
    double? width,
    double? height,
  }) {
    if (itemMediaModel == null) {
      return null;
    }

    return ItemMediaImage._fromAttachment(
      itemMediaModel.attachment,
      mediaProvider: itemMediaModel.mediaProvider,
      key: key,
      width: width,
      height: height,
    );
  }

  static Widget? _fromAttachment(
    Attachment? attachment, {
    FhirResourceProvider? mediaProvider,
    Key? key,
    double? width,
    double? height,
  }) {
    if (attachment == null) {
      return null;
    }
    final itemImageData = attachment.data;
    if (itemImageData != null) {
      final base64Widget = Base64Image(
        itemImageData.value!,
        width: width,
        height: height,
        key: key,
      );

      return ItemMediaImage._(base64Widget);
    }

    final itemImageFhirUri = attachment.url;
    if (itemImageFhirUri == null) {
      return null;
    }

    final itemImageUri = itemImageFhirUri.toString();

    final itemImageWidget = (mediaProvider?.providerFor(itemImageUri)
            as AssetImageAttachmentProvider?)
        ?.getImage(itemImageUri, width: width, height: height);
    if (itemImageWidget == null) {
      _logger.warn('Could not find image asset for $itemImageUri.');

      return null;
    }

    return ItemMediaImage._(itemImageWidget);
  }

  @override
  Widget build(BuildContext context) {
    return itemImageWidget;
  }
}
