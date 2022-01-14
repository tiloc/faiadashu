import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

Widget createWebView(String xhtml, {Key? key}) => _FullHtmlViewer(
      xhtml,
      key: key,
    );

class _FullHtmlViewer extends StatelessWidget {
  final String xhtml;

  const _FullHtmlViewer(this.xhtml, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // required while web support is in preview
    WebView.platform = WebWebViewPlatform();

    final dataUrl = Uri.dataFromString(
      xhtml,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    return SizedBox.expand(
      child: WebView(
        initialUrl: dataUrl,
      ),
    );
  }
}
