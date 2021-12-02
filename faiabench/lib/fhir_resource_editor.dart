import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:faiabench/fhir_resource.dart';
import 'package:fhir/r4/resource/resource.dart';
import 'package:fhir_path/fhir_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/json.dart';

import 'fhir_resource_notifier.dart';

class FhirResourceEditor extends ConsumerStatefulWidget {
  final String title;
  final bool showSubmitButton;
  final bool showFhirPath;
  final StateNotifierProvider<FhirResourceNotifier, AsyncValue<FhirResource>>
      fhirResourceProvider;

  final int fhirPathOutputMinLines;
  final int fhirPathOutputMaxLines;

  FhirResourceEditor(this.title, this.fhirResourceProvider,
      {this.showSubmitButton = true,
      this.showFhirPath = true,
      this.fhirPathOutputMinLines = 3,
      this.fhirPathOutputMaxLines = 3,
      Key? key})
      : super(key: key);

  @override
  _FhirResourceEditorState createState() => _FhirResourceEditorState();
}

class _FhirResourceEditorState extends ConsumerState<FhirResourceEditor> {
  ScrollController? _scrollController;
  CodeController? _codeController;
  CodeController? _fhirPathController;
  CodeController? _fhirPathOutputController;

  bool _fhirPathVisible = false;

  void _fhirPathChanged(String newPath) {
    setState(() {
      try {
        final newResource =
            Resource.fromJson(jsonDecode(_codeController!.rawText));
        final pathResult = walkFhirPath(newResource.toJson(), newPath);
        JsonEncoder encoder = new JsonEncoder.withIndent('  ');
        _fhirPathOutputController!.text =
            encoder.convert(jsonDecode(jsonEncode(pathResult)));
      } catch (e) {
        _fhirPathOutputController!.text = e.toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _codeController = CodeController(
      text: '',
      language: json,
      theme: monokaiSublimeTheme,
    );

    _fhirPathController = CodeController(
      text: '',
      language: javascript,
      theme: githubTheme,
      onChange: _fhirPathChanged,
    );

    _fhirPathOutputController = CodeController(
      text: '',
      language: json,
      theme: githubTheme,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    _fhirPathController?.dispose();
    _fhirPathOutputController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<FhirResource> fhirResource =
        ref.watch(widget.fhirResourceProvider);

    return fhirResource.when(
      data: (value) {
        final codeController = ArgumentError.checkNotNull(_codeController);
        final fhirPathController =
            ArgumentError.checkNotNull(_fhirPathController);

        final fhirPathOutputController =
            ArgumentError.checkNotNull(_fhirPathOutputController);

        codeController.text = value.jsonString;

        return Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: CodeField(
                controller: codeController,
                textStyle: TextStyle(fontFamily: 'SourceCode'),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _fhirPathVisible = !_fhirPathVisible;
                    });
                  },
                  icon: Icon(
                    Icons.local_fire_department,
                    color: _fhirPathVisible ? Colors.white : Colors.deepOrange,
                  ),
                ),
                Expanded(child: SizedBox.shrink()),
                if (widget.showSubmitButton)
                  IconButton(
                    onPressed: () {
                      final rawText = codeController.rawText.trim();

                      final fhirResource = (rawText.isNotEmpty)
                          ? FhirResource.fromJsonString(rawText)
                          : emptyFhirResource;

                      if (fhirResource.hasError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Theme.of(context).errorColor,
                          content: Text(fhirResource.errorMessage!),
                        ));
                      }

                      ref
                          .read(widget.fhirResourceProvider.notifier)
                          .updateFhirResource(fhirResource);
                    },
                    icon: Icon(
                      Icons.drive_file_move,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _fhirPathVisible
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: CodeField(
                              minLines: 1,
                              maxLines: 1,
                              controller: fhirPathController),
                        ),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          child: CodeField(
                              minLines: widget.fhirPathOutputMinLines,
                              maxLines: widget.fhirPathOutputMaxLines,
                              enabled: false,
                              controller: fhirPathOutputController),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ],
        );
      },
      error: (error, stack) => Text('Error: $error'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
