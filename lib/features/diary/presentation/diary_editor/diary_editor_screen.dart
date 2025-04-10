import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DiaryEditorScreen extends StatelessWidget {
  const DiaryEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    return Scaffold(
      body: Column(
        children: <Widget>[
          QuillSimpleToolbar(
            controller: _controller,
            configurations: const QuillSimpleToolbarConfigurations(),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              configurations: const QuillEditorConfigurations(),
            ),
          )
        ],
      ),
    );
  }
}
