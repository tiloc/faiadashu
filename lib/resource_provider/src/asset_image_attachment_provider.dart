import 'package:faiadashu/resource_provider/resource_provider.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:flutter/material.dart';

/// Provide images based on urls.
///
/// Urls are being matched to Flutter assets.
class AssetImageAttachmentProvider extends FhirResourceProvider {
  final Pattern urlMatch;
  final String assetPath;

  AssetImageAttachmentProvider(this.urlMatch, this.assetPath);

  Widget? getImage(String uri, {double? width, double? height}) {
    if (!uri.startsWith(urlMatch)) {
      return null;
    }

    return Image.asset(
      uri.replaceFirst(urlMatch, assetPath),
      width: width,
      height: height,
    );
  }

  @override
  Future<void> init() async {
    // Do nothing
    return;
  }

  @override
  Resource? getResource(String uri) {
    return null;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    return (uri.startsWith(urlMatch)) ? this : null;
  }
}
