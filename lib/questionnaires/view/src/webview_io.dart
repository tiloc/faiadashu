import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget createWebView(String xhtml, {Key? key}) =>
    Platform.isAndroid || Platform.isIOS
        ? _FullHtmlViewer(
            xhtml,
            key: key,
          )
        : _SimpleHtmlViewer(
            xhtml,
            key: key,
          );

class _FullHtmlViewer extends StatelessWidget {
  final String xhtml;

  const _FullHtmlViewer(this.xhtml, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class _SimpleHtmlViewer extends StatelessWidget {
  final String xhtml;

  const _SimpleHtmlViewer(this.xhtml, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: HTML.toRichText(
          context,
          xhtml,
          defaultTextStyle: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
