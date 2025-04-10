import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/src/widgets/raw_editor.dart';

import '../../../resources/resources.dart';
import '../controller/rich_text_controller.dart';
import '../embed/image_embed.dart';
import '../embed/todo_embed.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({
    super.key,
    this.controller,
    this.scrollController,
    this.focusNode,
    this.placeHolder,
    this.placeHolderStyle,
    this.readOnly = false,
    this.minHeight,
  });

  final RichTextController? controller;
  final ScrollController? scrollController;
  final FocusNode? focusNode;
  final String? placeHolder;
  final TextStyle? placeHolderStyle;
  final bool readOnly;
  final double? minHeight;

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  late RichTextController _controller;
  late ScrollController _scrollController;
  late FocusNode _focusNode;

  // final GlobalKey<QuillEditorState> _key = GlobalKey();
  GlobalKey<QuillEditorState> get _key => _controller.key;

  final DefaultStyles _customStyles = DefaultStyles(
    paragraph: DefaultTextBlockStyle(
      TextStyle(
        fontSize: 15,
        height: 1.5,
        color: JournalRes.color.TITLE_BLACK,
        decoration: TextDecoration.none,
        fontWeight: Platform.isIOS ? FontWeight.w500 : FontWeight.w600,
        fontFamilyFallback: const <String>['PingFang SC', "Heiti SC"],
      ),
      const VerticalSpacing(0, 0),
      const VerticalSpacing(0, 0),
      null,
    ),
    //   placeHolder: DefaultTextBlockStyle(
    //     TextStyle(
    //       fontSize: 15,
    //       height: 18 / 15,
    //       color: JournalRes.color.COMMON_C5C9D5,
    //     ),
    //     const VerticalSpacing(0, 0),
    //     const VerticalSpacing(0, 0),
    //     null,
    //   ),
  );

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? RichTextController();
    _scrollController = widget.scrollController ?? ScrollController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RichTextEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? RichTextController();
    }
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController = widget.scrollController ?? ScrollController();
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Widget child = QuillEditor(
      key: _key,
      controller: _controller.quillController,
      scrollController: _scrollController,
      scrollable: false,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: widget.readOnly,
      expands: false,
      minHeight: widget.minHeight,
      showCursor: !widget.readOnly,
      padding: EdgeInsets.zero,
      // placeholder: placeHolder,
      enableInteractiveSelection: !widget.readOnly,
      enableSelectionToolbar: !widget.readOnly,
      customStyles: _customStyles,
      onLaunchUrl: _onLaunchUrl,
      embedBuilders: <EmbedBuilder>[
        ImageEmbedBuilder(),
        TodoEmbedBuilder(),
      ],
      onTapUp: _onTapUp,
      contextMenuBuilder: (BuildContext context, RawEditorState state) {
        /// TODO(barry):不推荐这种解决方式，后续flutter_quill插件自己修复后，及时替换
        return _QuillContextMenu(
          controller: _controller.quillController,
          state: state,
        );
      },
    );
    if (widget.placeHolder?.isNotEmpty ?? false) {
      child = Stack(
        children: <Widget>[
          Positioned.fill(
            bottom: null,
            child: _PlaceHolder(
              controller: _controller,
              data: widget.placeHolder!,
              style: widget.placeHolderStyle,
            ),
          ),
          child,
        ],
      );
    }
    if (!widget.readOnly) {
      child = ValueListenableBuilder<Color>(
        valueListenable: _controller.textColorNotifier,
        builder: (BuildContext context, Color value, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme:
                  TextSelectionTheme.of(context).copyWith(cursorColor: value),
            ),
            child: child!,
          );
        },
        child: child,
      );
    }
    return child;
  }

  void _onLaunchUrl(String url) {
    // print('rich text editor: onLaunchUrl');
  }

  bool _onTapUp(
    TapUpDetails details,
    TextPosition Function(Offset offset) function,
  ) {
    ///here we go, delay 500 milliseconds for waiting keyboard show up
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final RenderEditor? renderEditor =
            _key.currentState?.editableTextKey.currentState?.renderEditor;
        if (renderEditor == null) {
          return;
        }

        ///this scroll controller is the same controller you set to the editor
        final RenderAbstractViewport viewport =
            RenderAbstractViewport.of(renderEditor);
        final Offset editorOffset =
            renderEditor.localToGlobal(Offset.zero, ancestor: viewport);
        final double offsetInViewport =
            _scrollController.offset + editorOffset.dy;

        final double? offset = renderEditor.getOffsetToRevealCursor(
          _scrollController.position.viewportDimension,
          _scrollController.offset,
          offsetInViewport,
        );

        if (offset != null) {
          _scrollController.animateTo(
            math.min(offset, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 100),
            curve: Curves.fastOutSlowIn,
          );
        }
      });
    });
    return false;
  }
}

class _QuillContextMenu extends StatefulWidget {
  const _QuillContextMenu({
    super.key,
    required this.controller,
    required this.state,
  });

  final QuillController controller;
  final RawEditorState state;

  @override
  State<_QuillContextMenu> createState() => _QuillContextMenuState();
}

class _QuillContextMenuState extends State<_QuillContextMenu> {
  final ClipboardStatusNotifier _clipboardStatus = ClipboardStatusNotifier();

  void _onChangedClipboardStatus() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _clipboardStatus.addListener(_onChangedClipboardStatus);
  }

  @override
  void dispose() {
    _clipboardStatus
      ..removeListener(_onChangedClipboardStatus)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      child: AdaptiveTextSelectionToolbar.buttonItems(
        buttonItems: EditableText.getEditableButtonItems(
          clipboardStatus: _clipboardStatus.value,
          onCopy: widget.state.copyEnabled
              ? () => widget.state.copySelection(SelectionChangedCause.toolbar)
              : null,
          onCut: widget.state.cutEnabled
              ? () => widget.state.cutSelection(SelectionChangedCause.toolbar)
              : null,
          onPaste: widget.state.pasteEnabled
              ? () async {
                  final Style toggledStyle = widget.controller.toggledStyle;
                  widget.controller.toggledStyle = Style();
                  await widget.state.pasteText(SelectionChangedCause.toolbar);
                  widget.controller.toggledStyle = toggledStyle;
                }
              : null,
          onSelectAll: widget.state.selectAllEnabled
              ? () => widget.state.selectAll(SelectionChangedCause.toolbar)
              : null,
          onLiveTextInput: null,
          // onLiveTextInput: widget.state.liveTextInputEnabled
          //     ? () => widget.state.startLiveTextInput(SelectionChangedCause.toolbar)
          //     : null,
        ),
        anchors: widget.state.contextMenuAnchors,
      ),
    );
  }
}

class _PlaceHolder extends StatefulWidget {
  const _PlaceHolder({
    super.key,
    required this.controller,
    required this.data,
    required this.style,
  });

  final RichTextController controller;
  final String data;
  final TextStyle? style;

  @override
  State<_PlaceHolder> createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<_PlaceHolder> {
  double _opacity = 1;
  late TextAlign _textAlign;

  void _didChangeEditingValue() {
    setState(() {
      _updateState();
    });
  }

  void _updateState() {
    final String content =
        widget.controller.getPlainText().replaceAll('\n', '');
    _opacity = content.isEmpty ? 1 : 0;
    final Attribute<dynamic>? attribute =
        widget.controller.getSelectionStyle().attributes[Attribute.align.key];
    _textAlign = TextAlign.left;
    if (attribute == Attribute.centerAlignment) {
      _textAlign = TextAlign.center;
    } else if (attribute == Attribute.leftAlignment) {
      _textAlign = TextAlign.left;
    } else if (attribute == Attribute.rightAlignment) {
      _textAlign = TextAlign.right;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_didChangeEditingValue);
    _updateState();
  }

  @override
  void didUpdateWidget(covariant _PlaceHolder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      widget.controller.removeListener(_didChangeEditingValue);
      widget.controller.addListener(_didChangeEditingValue);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeEditingValue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration.zero,
      child: Text(
        widget.data,
        textAlign: _textAlign,
        style: widget.style ??
            TextStyle(
              fontSize: 15,
              height: 18 / 15,
              color: JournalRes.color.COMMON_C5C9D5,
            ),
      ),
    );
  }
}
