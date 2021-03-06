import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'disclaimer_page.dart';
import 'observation_page.dart';
import 'primitive_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widgets on FHIR® Example',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('de', ''),
        Locale('es', ''),
        Locale('ar', ''),
      ],
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets on FHIR® Gallery'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Disclaimers'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisclaimerPage()));
            },
          ),
          ListTile(
            title: const Text('Primitive Types'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrimitivePage()));
            },
          ),
          ListTile(
            title: const Text('Observation'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ObservationPage()));
            },
          ),
        ],
      ),
    );
  }
}
