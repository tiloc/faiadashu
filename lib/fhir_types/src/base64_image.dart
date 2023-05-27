import 'dart:convert';

import 'package:flutter/material.dart';

/// Turn a base64 string into an image widget.
///
/// Uses techniques to reduce flicker and avoid repeat decoding of the base64.
class Base64Image extends StatefulWidget {
  final String base64String;
  final String? semanticLabel;
  final double? width;
  final double? height;

  /// [key] should be a [ValueKey] for most efficient caching.
  const Base64Image(
    this.base64String, {
    this.semanticLabel,
    this.width,
    this.height,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _Base64ImageState();
}

class _Base64ImageState extends State<Base64Image> {
  late final Image _image;

  @override
  void initState() {
    super.initState();
    final key = widget.key;

    _image = Image.memory(
      base64.decode(widget.base64String),
      width: widget.width,
      height: widget.height,
      semanticLabel: widget.semanticLabel,
      key: (key != null && key is ValueKey)
          ? ValueKey<String>('${key.value}-img')
          : null,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return _image;
  }
}
