import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../logging/logger.dart';

/// Provide ValueSets based on a Uri.
/// Time-consuming prep operations need to go into init().
/// init() needs to be invoked before getValueSet can be used.
abstract class ExternalResourceProvider {
  Future<void> init();

  Resource? getResource(String uri);
}

class NestedExternalResourceProvider extends ExternalResourceProvider {
  final List<ExternalResourceProvider> externalResourceProviders;

  NestedExternalResourceProvider(this.externalResourceProviders);

  @override
  Future<void> init() async {
    for (final externalResourceProvider in externalResourceProviders) {
      await externalResourceProvider.init();
    }
  }

  @override
  Resource? getResource(String uri) {
    for (final externalResourceProvider in externalResourceProviders) {
      final resource = externalResourceProvider.getResource(uri);
      if (resource != null) {
        return resource;
      }
    }
    return null;
  }
}

class AssetResourceProvider extends ExternalResourceProvider {
  static final _logger = Logger(AssetResourceProvider);

  final Map<String, Resource> resources = {};
  final Map<String, String> assetMap;

  AssetResourceProvider(String key, String assetPath)
      : assetMap = {key: assetPath};

  AssetResourceProvider.singleton(String uri, String assetPath)
      : assetMap = {uri: assetPath} {
    _logger.debug('AssetResourceProvider.singleton $uri -> $assetPath');
  }

  AssetResourceProvider.fromMap(this.assetMap);

  @override
  Future<void> init() async {
    for (final assetEntry in assetMap.entries) {
      final resourceJsonString = await rootBundle.loadString(assetEntry.value);
      resources[assetEntry.key] = Resource.fromJson(
          json.decode(resourceJsonString) as Map<String, dynamic>);
    }
  }

  @override
  Resource? getResource(String uri) {
    _logger.debug('getResource $uri from: ${resources.keys}');
    return resources.containsKey(uri) ? resources[uri] : null;
  }
}

/// Provide a resource from in-memory.
///
/// Mainly for development and testing purposes.
class InMemoryResourceProvider extends ExternalResourceProvider {
  final Resource? resource;
  final Type resourceType;
  InMemoryResourceProvider.inMemory(this.resourceType, this.resource);

  @override
  Resource? getResource(String uri) {
    return (uri == resourceType.toString()) ? resource : null;
  }

  @override
  Future<void> init() async {
    // Do nothing
    return;
  }
}
