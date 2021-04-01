import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import 'exhibit_page.dart';

class AboutPage extends ExhibitPage {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget buildExhibit(BuildContext context) {
    return Builder(builder: (context) => HTML.toRichText(context, '''
    <i><h2>Faiadashu™ FHIRDash</h2></i>
    <p>Faia Dasshu <i>[(ファイアダッシュ)]</i> — or Fire Dash — is a play with words.</p>
    <p>It sounds like FHIR. It pays hommage to Dash - the mascot of the Flutter framework.</p>
    <p>It expresses forward speed.</p>
    <p>I love the sound of it.</p> 
    '''));
  }

  @override
  String get title => 'About Faiadashu™ FHIRDash';
}
