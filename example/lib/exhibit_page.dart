import 'package:flutter/material.dart';

abstract class ExhibitPage extends StatelessWidget {
  const ExhibitPage({super.key});

  String get title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: buildExhibit(context),
          ),
        ),
      ),
    );
  }

  Widget buildExhibit(BuildContext context);
}
