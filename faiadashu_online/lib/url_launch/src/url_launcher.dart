import 'package:faiadashu/faiadashu.dart' show QuestionnaireScrollerPage;
import 'package:flutter/material.dart' show BuildContext;
import 'package:url_launcher/url_launcher.dart';

/// Launches a URL through a web browser.
///
/// Can be used as the 'onLinkTap' parameter in [QuestionnaireScrollerPage]
Future<void> launchLink(BuildContext context, Uri url) async {
  // TODO: canLaunchUrl can likely be removed
  // TODO: Catch PlatformException
  if (await canLaunchUrl(url)) {
    if (url.scheme == 'https') {
      await launchUrl(url);
    } else {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration:
            const WebViewConfiguration(enableJavaScript: false),
      );
    }
  } else {
    // TODO: Can something better than a string be thrown?
    throw 'Could not launch $url';
  }
}
