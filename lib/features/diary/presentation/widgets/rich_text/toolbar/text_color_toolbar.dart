import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lib_ui/lib_ui.dart';

import '../../../resources/journal_resources.dart';
import '../controller/rich_text_controller.dart';
import '../types.dart';
import 'toolbar_enum.dart';

/// 工具栏高度
const double _kToolBarHeight = 48.0;

/// 文字颜色工具栏
const List<Color> _kToolBarTextColors = <Color>[
  Color(0xFF111A34),
  Color(0xFFEC494A),
  Color(0xFFF97143),
  Color(0xFFF4A644),
  Color(0xFF41AA63),
  Color(0xFF53C5C3),
  Color(0xFF4EB0FB),
  Color(0xFF4472F1),
  Color(0xFFA74AF0),
  Color(0xFFF95BB2),
];

class TextColorToolbar extends StatefulWidget {
  const TextColorToolbar({
    super.key,
    required this.controller,
    this.onTap,
  });

  final RichTextController controller;
  final RichTextToolbarTapCallback? onTap;

  @override
  State<TextColorToolbar> createState() => _TextColorToolbarState();
}

class _TextColorToolbarState extends State<TextColorToolbar> {
  /// 选中的文字颜色
  final ValueNotifier<Color> _selectedTextColor =
      ValueNotifier<Color>(_kToolBarTextColors.first);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_didChangeEditingValue);
    final String? hexColor = widget.controller
        .getSelectionStyle()
        .attributes[Attribute.color.key]
        ?.value;
    if (hexColor != null) {
      final Color color = _hexToColor(hexColor);
      _selectedTextColor.value = color;
      scheduleMicrotask(() {
        widget.controller.textColorNotifier.value = color;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TextColorToolbar oldWidget) {
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
    return Container(
      height: _kToolBarHeight,
      width: double.infinity,
      color: JournalRes.color.COMMON_ALL_WHITE,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          final Color color = _kToolBarTextColors[index];
          return _TextColorItem(
            color: color,
            selectedColor: _selectedTextColor,
            onTap: () => _onTap(color),
          );
        },
        itemCount: _kToolBarTextColors.length,
      ),
    );
  }

  void _didChangeEditingValue() {
    final String? hexColor = widget.controller
        .getSelectionStyle()
        .attributes[Attribute.color.key]
        ?.value;
    if (hexColor != null) {
      _selectedTextColor.value = _hexToColor(hexColor);
    }
  }

  void _onTap(Color color) {
    _selectedTextColor.value = color;
    widget.controller.textColorNotifier.value = color;
    widget.controller.changeTextColor(color);
    widget.onTap?.call(RichTextToolbarType.textColor);
  }

  Color _hexToColor(String hexString) {
    String hexColor = hexString.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  // String _colorToHex(Color color) {
  //   String hexString = color.value.toRadixString(16);
  //   if (hexString.startsWith('ff')) {
  //     hexString = hexString.substring(2);
  //   }
  //   hexString = '#$hexString';
  //   return hexString;
  // }
}

class _TextColorItem extends StatelessWidget {
  const _TextColorItem({
    super.key,
    required this.color,
    required this.selectedColor,
    this.onTap,
  });

  final Color color;
  final ValueNotifier<Color> selectedColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: selectedColor,
      builder: (BuildContext context, Color value, Widget? child) {
        final bool isSelected = color == value;
        return AppTouchableOpacity(
          onTap: onTap,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              child!,
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? color : Colors.transparent,
                    width: 0.5,
                  ),
                ),
                child: isSelected
                    ? UnconstrainedBox(
                        child: AppAssetImage(
                          image: JournalRes
                              .image.journal_ic_editor_text_color_check,
                          width: 12,
                          height: 12,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        );
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
