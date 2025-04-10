import 'dart:math' as math;

import 'package:common/utils/assets_picker_util/files_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/src/widgets/raw_editor/raw_editor_state_text_input_client_mixin.dart';

import '../embed/image_embed.dart';
import '../embed/todo_embed.dart';

class RichTextController {
  RichTextController()
      : _controller = QuillController(
          document: Document(),
          selection: const TextSelection.collapsed(offset: 0),
          keepStyleOnNewLine: true,
        ) {
    _controller.onSelectionCompleted = () {
      // 选中内容改变时，勾选Todo
      tickTodo();
    };
  }

  GlobalKey<QuillEditorState> get key => _key;
  final GlobalKey<QuillEditorState> _key = GlobalKey();

  /// QuillController控制器
  QuillController get quillController => _controller;
  final QuillController _controller;

  /// 当前选中的文本
  TextSelection get selection => _controller.selection;

  TextEditingValue get plainTextEditingValue =>
      _controller.plainTextEditingValue;

  /// 是否处于预输入状态（例如中文拼音输入）
  bool get isComposingRangeValid {
    final EditorState? editorState =
        _key.currentState?.editableTextKey.currentState;
    if (editorState is RawEditorStateTextInputClientMixin) {
      final TextEditingValue? value = editorState.currentTextEditingValue;
      if (value != null) {
        return value.isComposingRangeValid;
      }
    }
    return false;
  }

  TextEditingValue? get textEditingValue {
    final EditorState? editorState =
        _key.currentState?.editableTextKey.currentState;
    if (editorState is RawEditorStateTextInputClientMixin) {
      final TextEditingValue? value = editorState.currentTextEditingValue;
      if (value != null) {
        print(
            'barry a: ${value.composing}, ${value.composing.isValid}, ${value.isComposingRangeValid}');
      }
      return value;
    }
    return null;
  }

  /// 文字颜色
  final ValueNotifier<Color> textColorNotifier =
      ValueNotifier<Color>(const Color(0xFF111A34));

  /// 设置json格式数据
  void updateJsonDocument(List<dynamic> json) {
    _controller
      ..document = Document.fromJson(json) // 内容
      ..moveCursorToEnd();
  }

  /// 设置json格式数据
  void setJsonDocument(List<dynamic> json) {
    _controller
      ..skipRequestKeyboard = true // 不显示光标和键盘
      ..document = Document.fromJson(json); // 内容
  }

  /// 获取json格式数据
  List<dynamic> getJsonDocument() {
    return _controller.document.toDelta().toJson();
  }

  /// 获取纯文本格式的数据
  String getPlainText() {
    return _controller.document.toPlainText(
      <EmbedBuilder>[TodoEmbedBuilder(), ImageEmbedBuilder()],
    );
  }

  /// 移动光标至内容尾部
  void moveCursorToEnd() {
    _controller.moveCursorToEnd();
  }

  /// 获取选中内容样式
  Style getSelectionStyle() {
    return _controller.getSelectionStyle();
  }

  /// 添加监听器
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  /// 移除监听器
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  // /// 格式化选中内容
  // void formatSelection(Attribute? attribute) {
  //   _controller.formatSelection(attribute);
  // }
  //
  // /// 替换内容
  // void replaceText(
  //   int index,
  //   int len,
  //   Object? data,
  //   TextSelection? textSelection, {
  //   bool ignoreFocus = false,
  // }) {
  //   _controller.replaceText(index, len, data, textSelection);
  // }
  //
  // /// 格式化内容
  // void formatText(int index, int len, Attribute? attribute) {
  //   _controller.formatText(index, len, attribute);
  // }
  //
  // /// 更换选中内容
  // void updateSelection(TextSelection textSelection, ChangeSource source) {
  //   _controller.updateSelection(textSelection, source);
  // }
  //
  // /// 从指定位置删除固定长度内容
  // void delete(int index, int len) {
  //   _controller.document.delete(index, len);
  // }

  /// 从指定位置查找Embed节点
  /// [start] 开始位置
  Embed? getEmbedNode(int start) {
    return _controller.getEmbedNode(start);
  }

  /// 从后往前查找换行符的索引
  /// [start] 开始位置
  int lastIndexOfLF(int start) {
    return _controller.lastIndexOfLF(start);
  }

  /// 是否需要插入换行
  /// 一般用于富文本插入自定义块之前，判断前一个字符是否为\n，是的话不换行，否的话插入换行
  void resolveInsertNewLine() {
    _controller.resolveInsertNewLine();
  }

  /// 插入换行
  /// 一般用于富文本插入自定义块之后
  void insertNewLine() {
    _controller.insertNewLine();
  }

  /// 获取所有的ImageEmbed节点
  List<ImageEmbed>? getAllImageEmbedNodes() {
    return _controller.getAllImageEmbedNodes();
  }

  /// 插入图片
  void insertImage(List<FilesEntity> photos) {
    // 1.判断是否需要插入换行符
    resolveInsertNewLine();
    for (final FilesEntity entity in photos) {
      // 2. 插入图片
      // final BlockEmbed block = BlockEmbed.custom(ImageEmbed.fromAlbum(
      //   originFile: Uri.file(entity.originFile.path).toString(),
      //   thumbFile: Uri.file(entity.thumbFile.path).toString(),
      // ));
      final BlockEmbed block = ImageEmbed.fromAlbum(
        originFile: Uri.file(entity.originFile.path).toString(),
        thumbFile: Uri.file(entity.thumbFile.path).toString(),
      );
      final int index = selection.extentOffset;
      _controller.replaceText(
        index,
        0,
        block,
        TextSelection.collapsed(offset: selection.extentOffset + 1),
        ignoreFocus: true,
      );
      // 3. 插入换行
      insertNewLine();
    }
  }

  /// 对齐内容
  void alignContent(Attribute<String?> alignment) {
    // 对齐所有内容
    _controller.formatText(
      0,
      plainTextEditingValue.text.length - 0,
      alignment,
    );
    // 对齐选择的内容（当前光标对应的行）
    // controller.formatSelection(alignment);
  }

  /// 插入时间戳
  void insertTimeStamp() {
    // 1. 判断是否需要插入换行符
    resolveInsertNewLine();
    // 2. 插件时间戳
    final DateTime now = DateTime.now();
    final String hour = now.hour.toString().padLeft(2, '0');
    final String minute = now.minute.toString().padLeft(2, '0');
    final String time = '【$hour:$minute】';
    _controller.replaceText(
      selection.extentOffset,
      0,
      time,
      TextSelection.collapsed(offset: selection.extentOffset + time.length),
    );
    // 3.插件换行符
    insertNewLine();
  }

  /// 从指定位置查找TodoEmbed节点
  /// [start] 开始位置
  TodoEmbed? getTodoEmbedNode(int start) {
    return _controller.getTodoEmbedNode(start);
  }

  /// 勾选待办
  void tickTodo() {
    int index = _controller.selection.baseOffset;
    // 1. 根据当前光标位置查找TodoEmbed
    TodoEmbed? embed = getTodoEmbedNode(index);
    if (embed == null) {
      // 2. 光标前移一位，查找TodoEmbed
      index = math.max(0, index - 1);
      embed = getTodoEmbedNode(index);
    }
    if (embed == null) {
      // 2. 光标后移一位，查找TodoEmbed
      index = math.min(
          _controller.plainTextEditingValue.text.length - 1, index + 1);
      embed = getTodoEmbedNode(index);
    }
    if (embed == null) {
      // 3. 没有找到TodoEmbed，退出
      return;
    }
    // 4. 找到TodoEmbed，判断是否勾选
    // final BlockEmbed block = BlockEmbed.custom(
    //   embed.isChecked ? TodoEmbed.unchecked() : TodoEmbed.checked(),
    // );
    final BlockEmbed block =
        embed.isChecked ? TodoEmbed.unchecked() : TodoEmbed.checked();
    // 5. 将光标固定在TodoEmbed的后面
    final TextSelection selection =
        TextSelection.fromPosition(TextPosition(offset: index + 1));
    // 6. 替换新的TodoEmbed
    _controller.replaceText(index, 1, block, selection);
  }

  /// 插入待办
  void insertTodo() {
    // 1. 查找当前光标所在行的开头（换行符）位置（待办只会插入在每一行的开头）
    final int position = selection.extentOffset;
    int index = position;
    if (position == 0) {
      index = 0;
    } else {
      index = lastIndexOfLF(position - 1);
      index += 1;
    }
    // 2. 查找到todo自定义块
    final TodoEmbed? todoEmbed = getTodoEmbedNode(index);
    if (todoEmbed == null) {
      // 3.1 不存在，插入todo自定义块并更新光标位置
      // final BlockEmbed blockEmbed = BlockEmbed.custom(TodoEmbed.unchecked());
      final BlockEmbed blockEmbed = TodoEmbed.unchecked();
      final TextSelection textSelection =
          TextSelection.collapsed(offset: selection.extentOffset + 1);
      _controller.replaceText(index, 0, blockEmbed, textSelection);
    } else {
      // 3.2 存在，删除todo自定义块并更新光标位置
      _controller.document.delete(index, 1);
      _controller.updateSelection(
        TextSelection.collapsed(offset: selection.extentOffset - 1),
        ChangeSource.LOCAL,
      );
    }
  }

  /// 修改文字颜色
  void changeTextColor(Color color) {
    String hexColor = color.value.toRadixString(16);
    if (hexColor.startsWith('ff')) {
      hexColor = hexColor.substring(2);
    }
    hexColor = '#$hexColor';
    _controller.formatSelection(ColorAttribute(hexColor));
  }
}

extension QuillControllerExtension on QuillController {
  /// 获取所有的ImageEmbed节点
  List<ImageEmbed>? getAllImageEmbedNodes() {
    List<ImageEmbed>? imageEmbeds;

    final List<Operation> operations = document.toDelta().toList();
    for (final Operation operation in operations) {
      final Object? data = operation.data;
      if (data is Map<dynamic, dynamic>) {
        final String? custom = data['custom'];
        if (custom != null) {
          final CustomBlockEmbed blockEmbed =
              CustomBlockEmbed.fromJsonString(custom);
          if (blockEmbed.type == ImageEmbed.imageType) {
            imageEmbeds ??= <ImageEmbed>[];
            imageEmbeds.add(ImageEmbed(blockEmbed.data));
          }
        }
      }
    }

    return imageEmbeds;
  }

  /// 从指定位置查找第一个Embed节点
  /// [start] 开始位置
  // OffsetValue<Embed>? getEmbedNode2(int start) {
  // Embed? embed = getEmbedNode(start);
  // if (embed == null) {
  //   // 向前查询
  //   final int forward = math.max(0, start - 1);
  //   embed = getEmbedNode(forward);
  //   if (embed == null) {
  //     // 向后查询
  //     final int backward =
  //         math.min(plainTextEditingValue.text.length - 1, start + 1);
  //     embed = getEmbedNode(backward);
  //     if (embed == null) {}
  //   } else {
  //     return OffsetValue<Embed>(forward, embed);
  //   }
  // } else {
  //   return OffsetValue<Embed>(start, embed);
  // }
  // }

  /// 从指定位置查找TodoEmbed节点
  /// [start] 开始位置
  TodoEmbed? getTodoEmbedNode(int start) {
    final Embed? embed = getEmbedNode(start);
    if (embed == null) {
      return null;
    }

    if (embed.value.type == BlockEmbed.customType) {
      final CustomBlockEmbed blockEmbed =
          CustomBlockEmbed.fromJsonString(embed.value.data);
      if (blockEmbed.type == TodoEmbed.todoType) {
        return TodoEmbed(blockEmbed.data);
      }
    }
    if (embed.value.type == TodoEmbed.todoType) {
      return TodoEmbed(embed.value.data);
    }
    return null;
  }

  /// 从指定位置查找Embed节点
  /// [start] 开始位置
  Embed? getEmbedNode(int start) {
    final Leaf? node = queryNode(start);
    if (node != null && node is Embed) {
      return node;
    }
    return null;
  }

  /// 从后往前查找换行符的索引
  /// [start] 开始位置
  int lastIndexOfLF(int start) {
    return document.toPlainText().lastIndexOf('\n', start);
  }

  /// 是否需要插入换行
  /// 一般用于富文本插入自定义块之前，判断前一个字符是否为\n，是的话不换行，否的话插入换行
  void resolveInsertNewLine() {
    // 是否需要插入换行符，默认false
    bool isInsertNewLine = false;
    if (selection.baseOffset > 0) {
      final String line = document.toPlainText()[selection.baseOffset - 1];
      // 查找当前光标前一个位置是否换行符
      isInsertNewLine = line != '\n';
    }
    if (isInsertNewLine) {
      replaceText(
        selection.baseOffset,
        0,
        '\n',
        TextSelection.collapsed(offset: selection.baseOffset + 1),
      );
    }
  }

  /// 插入换行
  /// 一般用于富文本插入自定义块之后
  void insertNewLine() {
    final int index = selection.extentOffset;
    const int length = 0;
    final TextSelection textSelection =
        TextSelection.collapsed(offset: selection.extentOffset + 1);
    replaceText(index, length, '\n', textSelection);
  }

// void _testing() {
//   controller.replaceText(
//     controller.selection.extentOffset,
//     0,
//     '\n',
//     TextSelection.collapsed(offset: controller.selection.extentOffset + 1),
//   );
//
//   controller.replaceText(
//     controller.selection.extentOffset,
//     0,
//     TimeStampEmbed(DateTime.now().toString()),
//     TextSelection.collapsed(offset: controller.selection.extentOffset + 1),
//   );
//
//   controller.replaceText(
//     controller.selection.extentOffset,
//     0,
//     ' ',
//     TextSelection.collapsed(offset: controller.selection.extentOffset + 1),
//   );
//
//   controller.replaceText(
//     controller.selection.extentOffset,
//     0,
//     '\n',
//     TextSelection.collapsed(offset: controller.selection.extentOffset + 1),
//   );
// }
}
