import 'package:flutter/material.dart';

import '../../../../fhir_types/fhir_types.dart';
import '../../../../logging/logging.dart';
import '../../../../resource_provider/resource_provider.dart';
import '../../../model/model.dart';

/// Image [Widget] for itemMedia extension
class ItemMediaImage extends StatelessWidget {
  static final _logger = Logger(ItemMediaImage);

  final Widget itemImageWidget;

  const ItemMediaImage._(this.itemImageWidget, {Key? key}) : super(key: key);

  /// Returns the itemImage [Widget] for a given [QuestionnaireItemModel].
  ///
  /// Returns null if no itemImage has been specified for the given item.
  static Widget? fromQuestionnaireItem(
    QuestionnaireItemModel itemModel, {
    Key? key,
    double? width,
    double? height,
  }) {
    final itemImageUri = itemModel.questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemMedia',
        )
        ?.valueAttachment
        ?.url
        .toString();
    if (itemImageUri == null) {
      return null;
    }

    final itemImageWidget = (itemModel.questionnaireModel.fhirResourceProvider
            .providerFor(itemImageUri) as AssetImageAttachmentProvider?)
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
