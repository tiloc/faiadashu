import 'dart:math' show pi;

import 'package:flutter/material.dart';

/// Circling arrows.
class SyncIndicator extends StatefulWidget {
  final Color? color;

  const SyncIndicator({this.color, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SyncIndicatorState createState() => _SyncIndicatorState();
}

class _SyncIndicatorState extends State<SyncIndicator>
    with SingleTickerProviderStateMixin {
  final _ingKey = UniqueKey();
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: _ingKey,
      animation: _animationController,
      builder: (BuildContext context, Widget? _widget) {
        return Transform.rotate(
          angle: _animationController.value * 2 * pi,
          child: _widget,
        );
      },
      child: Icon(Icons.sync, color: widget.color),
    );
  }
}
