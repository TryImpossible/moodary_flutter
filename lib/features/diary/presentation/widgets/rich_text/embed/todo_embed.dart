import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lib_ui/lib_ui.dart';

import '../../../resources/resources.dart';

class TodoEmbed extends CustomBlockEmbed {
  TodoEmbed(String data) : super(todoType, data);

  TodoEmbed.checked() : super(todoType, 'checked');

  TodoEmbed.unchecked() : super(todoType, 'unchecked');

  static const String todoType = 'todo';

  bool get isChecked => data == 'checked';

  bool get isUnChecked => data == 'unchecked';

  Document get document => Document.fromJson(jsonDecode(data));

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class TodoEmbedBuilder extends EmbedBuilder {
  @override
  String get key => TodoEmbed.todoType;

  @override
  bool get expanded => false;

  @override
  String toPlainText(Embed node) {
    return ' [待办] ';
  }

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final TodoEmbed todoEmbed = TodoEmbed(node.value.data);
    CrossFadeState state = CrossFadeState.showFirst;
    if (todoEmbed.isChecked) {
      state = CrossFadeState.showSecond;
    }
    if (todoEmbed.isUnChecked) {
      state = CrossFadeState.showFirst;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 1, right: 8),
      child: AnimatedCrossFade(
        firstChild: AppAssetImage(
          image: JournalRes.image.journal_ic_editor_todo_unchecked,
          width: 20,
          height: 20,
        ),
        secondChild: AppAssetImage(
          image: JournalRes.image.journal_ic_editor_todo_checked,
          width: 20,
          height: 20,
        ),
        crossFadeState: state,
        duration: kThemeAnimationDuration,
      ),
    );
  }

// void _onTap(
//   QuillController controller, {
//   required bool readOnly,
//   required bool isChecked,
// }) {
//   if (readOnly) {
//     return;
//   }
//   try {
//     int index = controller.selection.baseOffset;
//     index = getEmbedNode(controller, index).offset;
//     final BlockEmbed block = BlockEmbed.custom(
//       isChecked ? TodoEmbed.unchecked() : TodoEmbed.checked(),
//     );
//     controller.replaceText(index, 1, block, null);
//   } catch (_) {}
// }
}
