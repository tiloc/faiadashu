import 'package:faiadashu/fhir_types/fhir_types.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:flutter/material.dart';

class JsonTree extends StatefulWidget {
  final Resource resource;

  const JsonTree(this.resource, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JsonTreeState createState() => _JsonTreeState();
}

class _JsonTreeState extends State<JsonTree> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ResourceJsonTree(
            widget.resource.toJson(),
          ),
        ),
      ),
    );
  }
}
