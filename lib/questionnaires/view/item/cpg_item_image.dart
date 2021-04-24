import 'package:flutter/material.dart';

import '../../../fhir_types/fhir_types_extensions.dart';
import '../../../logging/logger.dart';
import '../../../resource_provider/asset_image_attachment_provider.dart';
import '../../model/questionnaire_location.dart';

/// Image [Widget] for CPG itemImage extension
class CpgItemImage extends StatelessWidget {
  static final _logger = Logger(CpgItemImage);

  final Widget itemImageWidget;

  const CpgItemImage._(this.itemImageWidget, {Key? key}) : super(key: key);

  /// Return the itemImage [Widget] for a given [QuestionnaireLocation].
  ///
  /// Returns null if no itemImage has been specified for the given item.
  static Widget? forLocation(QuestionnaireLocation location,
      {Key? key, double? width, double? height}) {
    final itemImageUri = location.questionnaireItem.extension_
        ?.extensionOrNull(
            'http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-itemImage')
        ?.valueAttachment
        ?.url
        .toString();
    if (itemImageUri == null) {
      return null;
    }

    final itemImageWidget = (location.top.fhirResourceProvider
            .providerFor(itemImageUri) as AssetImageAttachmentProvider?)
        ?.getImage(itemImageUri, width: width, height: height);
    if (itemImageWidget == null) {
      _logger.warn('Could not find image asset for $itemImageUri.');
      return null;
    }
    return CpgItemImage._(itemImageWidget);
  }

  @override
  Widget build(BuildContext context) {
    return itemImageWidget;
  }
}