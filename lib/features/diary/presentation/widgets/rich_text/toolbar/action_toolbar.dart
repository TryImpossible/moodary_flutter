import 'package:biz_journal/generated/gen_l10n/biz_journal_localizations.dart';
import 'package:common/utils/assets_picker_util/app_assets_picker.dart';
import 'package:common/utils/assets_picker_util/files_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lib_ui/lib_ui.dart';
import 'package:lib_utils/lib_utils.dart';

import '../../../resources/resources.dart';
import '../controller/rich_text_controller.dart';
import '../types.dart';
import 'toolbar_enum.dart';

/// 工具栏高度
const double _kToolbarHeight = 48.0;

/// 操作栏
class ActionToolbar extends StatelessWidget {
  const ActionToolbar({
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
    return Container(
      height: _kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: JournalRes.color.COMMON_BACK,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 0.5),
            color: JournalRes.color.COMMON_GRAY,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _AlbumButton(
                  controller: controller,
                  onTap: () => onTap?.call(RichTextToolbarType.album),
                ),
                _StickerButton(
                  controller: controller,
                  onTap: () => onTap?.call(RichTextToolbarType.sticker),
                ),
                _AlignmentButton(
                  controller: controller,
                  onTap: () => onTap?.call(RichTextToolbarType.alignment),
                ),
                _TimeStampButton(
                  controller: controller,
                  onTap: () => onTap?.call(RichTextToolbarType.timestamp),
                ),
                _TodoButton(
                  controller: controller,
                  onTap: () => onTap?.call(RichTextToolbarType.todo),
                ),
                _BackgroundButton(
                  controller: controller,
                  onTap: () => onTap?.call(RichTextToolbarType.background),
                ),
                // _LocationButton(),
              ],
            ),
          ),
          Container(
            width: 0.5,
            height: 24,
            color: JournalRes.color.COMMON_GRAY,
          ),
          _KeyboardControlButton(
            onKeyboardWillOpen: onKeyboardWillOpen,
            onKeyboardWillDismiss: onKeyboardWillDismiss,
          ),
        ],
      ),
    );
  }
}

/// 相册按钮
class _AlbumButton extends StatelessWidget {
  const _AlbumButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionButton(
      icon: JournalRes.image.journal_ic_editor_album,
      onTap: () => _onTap(context),
    );
  }

  Future<void> _onTap(
    BuildContext context,
  ) async {
    final int length = controller.getAllImageEmbedNodes()?.length ?? 0;
    if (length == 9) {
      ToastUtils.showShort(
          '${BizJournalLocalizations.of(context)?.actionToolbarbe36fcd3}');
      return;
    }

    /// 插入图片
    final List<FilesEntity>? photos = await AppAssetsPicker().openAlbum(
      context: context,
      maxAssets: 9 - length,
    );
    if (photos?.isEmpty ?? true) {
      return;
    }
    controller.insertImage(photos!);

    /// 点击回调
    onTap?.call();
  }
}

/// 贴纸按钮
class _StickerButton extends StatelessWidget {
  const _StickerButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionButton(
      icon: JournalRes.image.journal_ic_editor_sticker,
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    /// 点击回调
    onTap?.call();
  }
}

/// 对齐操作按钮
class _AlignmentButton extends StatefulWidget {
  const _AlignmentButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final VoidCallback? onTap;

  @override
  State<_AlignmentButton> createState() => _AlignmentButtonState();
}

class _AlignmentButtonState extends State<_AlignmentButton> {
  /// 对齐方式图标
  final Map<Attribute<String?>, AssetImage> _icons =
      <Attribute<String?>, AssetImage>{
    Attribute.leftAlignment: JournalRes.image.journal_ic_editor_alignment_left,
    Attribute.centerAlignment:
        JournalRes.image.journal_ic_editor_alignment_center,
    Attribute.rightAlignment:
        JournalRes.image.journal_ic_editor_alignment_right,
  };

  /// 对齐方式切换
  final Map<Attribute<String?>, Attribute<String?>> _alignmentChanges =
      <Attribute<String?>, Attribute<String?>>{
    Attribute.leftAlignment: Attribute.centerAlignment,
    Attribute.centerAlignment: Attribute.rightAlignment,
    Attribute.rightAlignment: Attribute.leftAlignment,
  };

  /// 对齐方式
  Attribute<String?> _alignment = Attribute.leftAlignment;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_didChangeEditingValue);
    _didChangeEditingValue();
  }

  @override
  void didUpdateWidget(covariant _AlignmentButton oldWidget) {
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
    final AssetImage icon = _icons[_alignment] ??
        JournalRes.image.journal_ic_editor_alignment_center;
    return _ActionButton(icon: icon, onTap: _onTap);
  }

  void _didChangeEditingValue() {
    final dynamic value = widget.controller
        .getSelectionStyle()
        .attributes[Attribute.align.key]
        ?.value;
    if (value == null) {
      setState(() {
        _alignment = Attribute.leftAlignment;
      });
    }
    if (value is String) {
      setState(() {
        _alignment = AlignAttribute(value);
      });
    }
  }

  void _onTap() {
    setState(() {
      _alignment = _alignmentChanges[_alignment] ?? Attribute.leftAlignment;
      _alignContent();
    });

    /// 点击回调
    widget.onTap?.call();
  }

  /// 对齐内容
  void _alignContent() {
    widget.controller.alignContent(_alignment);
  }
}

/// 时间戳按钮
class _TimeStampButton extends StatelessWidget {
  const _TimeStampButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionButton(
      icon: JournalRes.image.journal_ic_editor_time_stamp,
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    /// 插入时间戳
    controller.insertTimeStamp();

    // 点击回调
    onTap?.call();
  }
}

/// 待办按钮
class _TodoButton extends StatelessWidget {
  const _TodoButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionButton(
      icon: JournalRes.image.journal_ic_editor_todo,
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    /// 插入待办
    controller.insertTodo();

    /// 点击回调
    onTap?.call();
  }
}

/// 背景按钮
class _BackgroundButton extends StatelessWidget {
  const _BackgroundButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionButton(
      icon: JournalRes.image.journal_ic_editor_bg,
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    /// 点击回调
    onTap?.call();
  }
}

/// 地理位置按钮
class _LocationButton extends StatelessWidget {
  const _LocationButton({
    super.key,
    required this.controller,
    this.onTap,
  });

  final QuillController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionButton(
      icon: JournalRes.image.journal_ic_editor_location,
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    /// 点击回调
    onTap?.call();
  }
}

/// 键盘收起唤出控制按钮
class _KeyboardControlButton extends StatelessWidget {
  const _KeyboardControlButton({
    super.key,
    this.onKeyboardWillOpen,
    this.onKeyboardWillDismiss,
  });

  final VoidCallback? onKeyboardWillOpen;
  final VoidCallback? onKeyboardWillDismiss;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
      builder: (_, bool visible) {
        return _ActionButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          icon: visible
              ? JournalRes.image.journal_editor_toobar_close
              : JournalRes.image.journal_editor_toobar_open,
          onTap: () => _onTap(visible),
        );
      },
    );
  }

  void _onTap(bool visible) {
    if (visible) {
      onKeyboardWillDismiss?.call();
    } else {
      onKeyboardWillOpen?.call();
    }
  }
}

/// 操作按钮
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.padding,
  });

  final AssetImage icon;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AppTouchableOpacity(
      onTap: onTap,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
        child: AppAssetImage(
          image: icon,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
