import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/json.dart';

class JsonEditor extends StatefulWidget {
  final String title;
  final String initialContent;
  final void Function() onChange;

  late _JsonEditorState _jsonEditorState;

  JsonEditor(this.title, this.initialContent, this.onChange, {Key? key})
      : super(key: key);

  String getValue(BuildContext context) {
    return _jsonEditorState._codeController?.text ?? '';
  }

  @override
  _JsonEditorState createState() {
    // FIXME: createState can be invoked numerous times.
    _jsonEditorState = _JsonEditorState();
    return _jsonEditorState;
  }
}

class _JsonEditorState extends State<JsonEditor> {
  ScrollController? _scrollController;
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _codeController = CodeController(
      text: widget.initialContent,
      language: json,
      theme: monokaiSublimeTheme,
    );
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: CodeField(
            controller: _codeController!,
            textStyle: TextStyle(fontFamily: 'SourceCode'),
          ),
        ),
        Row(
          children: [
            Expanded(child: SizedBox.shrink()),
            ElevatedButton(
              onPressed: () {
                widget.onChange.call();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
