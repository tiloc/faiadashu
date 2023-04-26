import 'package:faiabench/exhibit_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AboutPage extends ExhibitPage {
  const AboutPage({super.key});

  @override
  Widget buildExhibit(BuildContext context) {
    return Builder(
      builder: (context) => HTML.toRichText(
        context,
        '''
    <i><h2>Faiadashu™ Faiabench</h2></i>
    <p>Faia Dasshu <i>[(ファイアダッシュ)]</i> — or <i>Fire Dash</i> — is a play with words.</p>
    <p></p>
    <p>It sounds like FHIR 🔥. It pays hommage to Dash 🐣 - the mascot of the Flutter framework.</p>
    <p><i>It is forward motion at breakneck pace — with flying sparks!</i><br>
    <div style="font-size: 10px; color:#888888; font-style:italic">それは猛烈なペースで前進します—飛んでいる火花で！</div></p>
    <p><b>I love the sound of it.</b><br>
    <div style="font-size: 10px; color:#888888">私はその音が大好きです。</div></p> 
    ''',
        defaultTextStyle: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  @override
  String get title => 'About Faiadashu™ Faiabench';
}
