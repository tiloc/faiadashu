import 'package:flutter/foundation.dart';

/// Evaluate an expression.
///
/// Takes other expressions - referred to as 'upstream' expressions into account.
abstract class ExpressionEvaluator with DiagnosticableTreeMixin {
  /// The name of the expression
  final String? name;

  bool get hasName => name != null;

  /// A debug label that is used for diagnostic output.
  ///
  /// Will always return null in release builds.
  String? get debugLabel => _debugLabel;
  String? _debugLabel;
  set debugLabel(String? value) {
    assert(
      () {
        // Only set the value in debug builds.
        _debugLabel = value;

        return true;
      }(),
    );
  }

  final Iterable<ExpressionEvaluator> upstreamExpressions;

  /// Evaluate the current value.
  ///
  /// [generation] can be used to provide an identifier for the point in time,
  /// when this expression was last evaluated. This can allow for caching of
  /// expensive evaluations.
  dynamic evaluate({int? generation});

  ExpressionEvaluator(
    this.name,
    this.upstreamExpressions, {
    String? debugLabel,
  }) {
    // Set it via the setter so that it does nothing on release builds.
    this.debugLabel = debugLabel;
  }

  @override
  String toStringShort() {
    final bool hasDebugLabel = debugLabel != null && debugLabel!.isNotEmpty;
    final String extraData = '${hasDebugLabel ? debugLabel : ''}'
        '${hasName && hasDebugLabel ? ' ' : ''}'
        '${hasName ? '$name' : ''}';

    return '${describeIdentity(this)}${extraData.isNotEmpty ? '($extraData)' : ''}';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(StringProperty('name', name, ifEmpty: 'NO NAME'));
    properties.add(IterableProperty('upstream', upstreamExpressions));
  }
}
