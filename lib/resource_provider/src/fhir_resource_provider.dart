import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:faiadashu/logging/logging.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Provide [Resource]s based on a Uri.
///
/// __Two-staged access:__
/// Allows the separation between an expensive initialization phase and later
/// synchronous, fail-safe access to the resource.
/// Time-consuming prep operations need to go into [init]. This can fail
/// and throw.
/// [init] needs to be invoked before [getResource] can be used.
///
/// __Single-staged access:__
/// Access to the resource happens lazily and asynchronously through
/// [getAsyncResource]. This is not fail-safe.
abstract class FhirResourceProvider {
  /// Prepare the resource(s) for synchronous access through [getResource].
  ///
  /// All time-consuming and error-prone activities such as network access
  /// should go here.
  Future<void> init();

  /// Return a [Resource] based on an uri.
  /// Returns null if no resource with this uri is known to the provider.
  Resource? getResource(String uri);

  Future<Resource?> getAsyncResource(String uri) async {
    await init();

    return getResource(uri);
  }

  /// Return the provider for the given [uri].
  FhirResourceProvider? providerFor(String uri);
}

/// Provide resources from a multitude of other [FhirResourceProvider]s.
///
/// This resource provider does not provide resources by itself but provides
/// a single point to obtain resources from a multitude of other providers.
///
/// For example, one could provide a Questionnaire from a FHIR server,
/// a QuestionnaireResponse from a local JSON store, ValueSets from Flutter
/// assets and the Subject from an authentication module.
class RegistryFhirResourceProvider extends FhirResourceProvider {
  final List<FhirResourceProvider> fhirResourceProviders;

  RegistryFhirResourceProvider(this.fhirResourceProviders);

  @override
  Future<void> init() async {
    await Future.wait<void>(
      fhirResourceProviders.map<Future<void>>(
        (externalResourceProvider) => externalResourceProvider.init(),
      ),
      eagerError: true,
    );
  }

  @override
  Resource? getResource(String uri) {
    for (final externalResourceProvider in fhirResourceProviders) {
      final resource = externalResourceProvider.getResource(uri);
      if (resource != null) {
        return resource;
      }
    }

    return null;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    for (final externalResourceProvider in fhirResourceProviders) {
      final resourceProvider = externalResourceProvider.providerFor(uri);
      if (resourceProvider != null) {
        return resourceProvider;
      }
    }

    return null;
  }
}

/// Provide resources from Flutter assets.
class AssetResourceProvider extends FhirResourceProvider {
  static final _logger = Logger(AssetResourceProvider);

  final Map<String, Resource> resources = {};
  final Map<String, String> assetMap;

  AssetResourceProvider(String uri, String assetPath)
      : assetMap = {uri: assetPath};

  AssetResourceProvider.singleton(String uri, String assetPath)
      : assetMap = {uri: assetPath} {
    _logger.debug('AssetResourceProvider.singleton $uri -> $assetPath');
  }

  AssetResourceProvider.fromMap(this.assetMap);

  @override
  Future<void> init() async {
    final resourceJsonStrings = await Future.wait<String>(
      assetMap.values
          .map<Future<String>>((assetPath) => rootBundle.loadString(assetPath)),
      eagerError: true,
    );

    assetMap.keys.forEachIndexed((i, resourceUrl) {
      resources[resourceUrl] = Resource.fromJson(
        json.decode(resourceJsonStrings[i]) as Map<String, dynamic>,
      );
    });
  }

  @override
  Resource? getResource(String uri) {
    _logger.debug('getResource $uri from: ${resources.keys}');

    return resources.containsKey(uri) ? resources[uri] : null;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    return resources.containsKey(uri) ? this : null;
  }
}

/// Provide a resource from in-memory.
///
/// For short-term caching, development and testing purposes.
class InMemoryResourceProvider extends FhirResourceProvider {
  final Resource? resource;
  final String uri;
  InMemoryResourceProvider.inMemory(this.uri, this.resource);

  @override
  Resource? getResource(String uri) {
    return (uri == this.uri) ? resource : null;
  }

  @override
  Future<void> init() async {
    // Do nothing
    return;
  }

  @override
  FhirResourceProvider? providerFor(String uri) {
    return (this.uri == uri) ? this : null;
  }
}
