import 'package:fhir/r4/general_types/general_types.dart';
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

  static Widget? _fromAttachment(
    Attachment? attachment,
    QuestionnaireModel questionnaireModel, {
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

    final itemImageWidget = (questionnaireModel.fhirResourceProvider
            .providerFor(itemImageUri) as AssetImageAttachmentProvider?)
        ?.getImage(itemImageUri, width: width, height: height);
    if (itemImageWidget == null) {
      _logger.warn('Could not find image asset for $itemImageUri.');

      return null;
    }

    return ItemMediaImage._(itemImageWidget);
  }

  /// Returns the itemImage [Widget] for a given [QuestionnaireItemModel].
  ///
  /// Returns null if no itemImage has been specified for the given item.
  static Widget? fromAnswerOption(
    CodingAnswerOptionModel optionModel, {
    Key? key,
    double? width,
    double? height,
  }) {
    return _fromAttachment(
      optionModel.mediaAttachment,
      optionModel.questionnaireItemModel.questionnaireModel,
    );
  }

  /// Returns the itemImage [Widget] for a given [QuestionnaireItemModel].
  ///
  /// Returns null if no itemImage has been specified for the given item.
  static Widget? fromQuestionnaireItem(
    QuestionnaireItemModel itemModel, {
    Key? key,
    double? width,
    double? height,
  }) {
    final itemImageAttachment = itemModel.questionnaireItem.extension_
        ?.extensionOrNull(
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemMedia',
        )
        ?.valueAttachment;

    return _fromAttachment(
      itemImageAttachment,
      itemModel.questionnaireModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemImageWidget;
  }
}
