import 'package:faiadashu/faiadashu.dart' show QuestionnaireScrollerPage;
import 'package:flutter/material.dart' show BuildContext;
import 'package:url_launcher/url_launcher.dart';

/// Launches a URL through a web browser.
///
/// Can be used as the 'onLinkTap' parameter in [QuestionnaireScrollerPage]
Future<void> launchUrl(BuildContext context, Uri url) async {
  if (await canLaunch(url.toString())) {
    if (url.scheme == 'https') {
      await launch(url.toString(), forceWebView: true, enableJavaScript: true);
    } else {
      await launch(
        url.toString(),
      );
    }
  } else {
    throw 'Could not launch $url';
  }
}
