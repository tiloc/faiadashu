import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import 'exhibit_page.dart';

class AboutPage extends ExhibitPage {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return HTML.toRichText(context, '''
    <h2>Faiadashu™ FHIRDash</h2>
    <h3><i>[(ファイアダッシュ)]</i></h3>
    <p>
    
    </p> 
    ''');
  }

  @override
  String get title => 'About Faiadashu™ FHIRDash';
}
