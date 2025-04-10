import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../controller/rich_text_controller.dart';
import '../types.dart';
import 'action_toolbar.dart';
import 'text_color_toolbar.dart';

class RichTextToolbar extends StatelessWidget {
  const RichTextToolbar({
    super.key,
    required this.controller,
    this.onTap,
    this.onKeyboardWillOpen,
    this.onKeyboardWillDismiss,
  });

  final RichTextController controller;
  final RichTextToolbarTapCallback? onTap;

  final VoidCallback? onKeyboardWillOpen;
  final VoidCallback? onKeyboardWillDismiss;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ActionToolbar(
          controller: controller,
          onTap: onTap,
          onKeyboardWillOpen: onKeyboardWillOpen,
          onKeyboardWillDismiss: onKeyboardWillDismiss,
        ),
        TextColorToolbar(controller: controller, onTap: onTap),
      ],
    );
  }
}
