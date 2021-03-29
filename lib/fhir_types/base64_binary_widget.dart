import 'dart:convert';

import 'package:flutter/material.dart';

/// Turn a base64 string into an image widget.
/// Uses techniques to reduce flicker and avoid repeat decoding of the base64.
class Base64BinaryWidget extends StatefulWidget {
  // TODO: How can I get rid of the base64String once the image has been constructed?
  final String base64String;
  final String? semanticLabel;
  final double? width;
  final double? height;

  const Base64BinaryWidget(this.base64String,
      {this.semanticLabel, this.width, this.height, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _Base64BinaryWidgetState();
}

class _Base64BinaryWidgetState extends State<Base64BinaryWidget> {
  late final Image _image;

  @override
  void initState() {
    super.initState();
    _image = Image.memory(
      base64.decode(widget.base64String),
      width: widget.width,
      height: widget.height,
      semanticLabel: widget.semanticLabel,
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
