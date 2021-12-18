import 'package:faiabench/fhir_resource.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FhirResourceNotifier extends StateNotifier<AsyncValue<FhirResource>> {
  final String? assetPath;

  FhirResourceNotifier(this.assetPath) : super(const AsyncValue.loading()) {
    _fetchInitialAsset();
  }

  void updateFhirResource(FhirResource resource) {
    state = AsyncValue.data(resource);
  }

  Future<void> _fetchInitialAsset() async {
    final assetPath = this.assetPath;

    if (assetPath != null) {
      final jsonString = await rootBundle.loadString(assetPath);
      final fhirResource = FhirResource.fromJsonString(jsonString);

      state = AsyncValue.data(fhirResource);
    } else {
      state = const AsyncValue.data(emptyFhirResource);
    }
  }
}
