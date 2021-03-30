import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Provide ValueSets based on a Uri.
/// Time-consuming prep operations need to go into init().
/// init() needs to be invoked before getValueSet can be used.
abstract class ValueSetProvider {
  Future<void> init();

  ValueSet? getValueSet(String uri);
}

class NestedValueSetProvider extends ValueSetProvider {
  final List<ValueSetProvider> valueSetProviders;

  NestedValueSetProvider(this.valueSetProviders);

  @override
  Future<void> init() async {
    for (final valueSetProvider in valueSetProviders) {
      await valueSetProvider.init();
    }
  }

  @override
  ValueSet? getValueSet(String uri) {
    for (final valueSetProvider in valueSetProviders) {
      final valueSet = valueSetProvider.getValueSet(uri);
      if (valueSet != null) {
        return valueSet;
      }
    }
    return null;
  }
}

class AssetValueSetProvider extends ValueSetProvider {
  late final Map<String, ValueSet> valueSets;
  final Map<String, String> assetMap;

  AssetValueSetProvider(this.assetMap);

  @override
  Future<void> init() async {
    for (final assetEntry in assetMap.entries) {
      final valueSetJsonString = await rootBundle.loadString(assetEntry.value);
      valueSets[assetEntry.key] = ValueSet.fromJson(
          json.decode(valueSetJsonString) as Map<String, dynamic>);
    }
  }

  @override
  ValueSet? getValueSet(String uri) {
    return valueSets.containsKey(uri) ? valueSets[uri] : null;
  }
}
