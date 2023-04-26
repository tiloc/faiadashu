import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget createWebView(String xhtml, {Key? key}) => _FullHtmlViewer(
      xhtml,
      key: key,
    );

class _FullHtmlViewer extends StatelessWidget {
  final String xhtml;

  const _FullHtmlViewer(this.xhtml, {super.key});

  @override
  Widget build(BuildContext context) {
    final dataUrl = Uri.dataFromString(
      xhtml,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    return SizedBox.expand(
      child: WebViewWidget(
        controller: WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams(),
        )..loadRequest(
            Uri.parse(dataUrl),
          ),
      ),
    );
  }
}
