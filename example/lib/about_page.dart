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
    <p></p>
    <p>It sounds like FHIR. It pays hommage to Dash - the mascot of the Flutter framework.</p>
    <p><i>It expresses forward motion at breakneck pace - with flying sparks!</i><br>
    <div style="font-size: 10px; color:#888888">火花を散らしながら、猛スピードで前進する様子を表現しています。</div></p>
    <p>I love the sound of it.<br>
    <div style="font-size: 10px; color:#888888">私はその音が大好きです。</div></p> 
    '''));
  }

  @override
  String get title => 'About Faiadashu™ FHIRDash';
}
