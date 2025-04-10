import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_ui/lib_ui.dart';

import '../../../resources/journal_resources.dart';

/// 工具栏高度
const double _kToolBarHeight = 48.0;

/// 文字颜色工具栏
const List<Color> _kToolBarTextColors = <Color>[
  Color(0xFF111A34),
  Color(0xFFFFFFFF),
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

class ColorToolBar extends StatefulWidget {
  const ColorToolBar({
    super.key,
    this.onColorSelected,
    this.selectedColor,
  });

  final ValueSetter<Color>? onColorSelected;
  final Color? selectedColor;
  @override
  State<ColorToolBar> createState() => _ColorToolBarState();
}

class _ColorToolBarState extends State<ColorToolBar>
    with WidgetsBindingObserver {
  /// 选中的文字颜色
  final ValueNotifier<Color> _selectedTextColor =
      ValueNotifier<Color>(_kToolBarTextColors.first);

  double keyboardHeight = 0;
  @override
  void initState() {
    _selectedTextColor.value =
        widget.selectedColor ?? _kToolBarTextColors.first;
    WidgetsBinding.instance.addObserver(this); // 在初始化方法中添加监听

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 在 dispose 方法中移除监听
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // 当窗口的尺寸改变时调用
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        keyboardHeight = MediaQuery.of(context).viewInsets.bottom; // 获取键盘高度
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kToolBarHeight,
      width: double.infinity,
      color: JournalRes.color.COMMON_ALL_WHITE,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(bottom: keyboardHeight),
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

  void _onTap(Color color) {
    _selectedTextColor.value = color;
    widget.onColorSelected?.call(color);
  }
}

class _TextColorItem extends StatelessWidget {
  _TextColorItem({
    super.key,
    required this.color,
    required this.selectedColor,
    this.onTap,
  });

  Color color;
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
                    color: isSelected
                        ? color == const Color(0xFFFFFFFF)
                            ? UIRes.color.TITLE_BLACK
                            : color
                        : Colors.transparent,
                    width: 0.5,
                  ),
                ),
                child: isSelected
                    ? UnconstrainedBox(
                        child: AppAssetImage(
                          color: color == const Color(0xFFFFFFFF)
                              ? UIRes.color.COMMON_GRAY
                              : null,
                          image: JournalRes
                              .image.journal_ic_editor_text_color_check,
                          width: 12,
                          height: 12,
                        ),
                      )
                    : null,
              ),
              Visibility(
                visible: color == const Color(0xFFFFFFFF),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: UIRes.color.COMMON_GRAY,
                      width: 0.5,
                    ),
                  ),
                ),
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
