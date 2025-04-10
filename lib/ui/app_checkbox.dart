import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import 'app_text.dart';
import 'app_touchable_opacity.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({
    super.key,
    this.value = false,
    this.onChanged,
    this.enabled = true,
    this.padding = EdgeInsets.zero,
    this.iconSize = const Size(20, 20),
    this.checkIcon,
    this.uncheckIcon,
    this.text,
    this.textColor,
    this.textFontSize,
    this.textFontWeight,
    this.textStyle,
    this.textView,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final EdgeInsets padding;
  final Size iconSize;
  final AssetImage? checkIcon;
  final AssetImage? uncheckIcon;
  final String? text;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final TextStyle? textStyle;
  final Widget? textView;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant AppCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    Widget current = _buildIcon();
    final Widget? text = _buildText();
    if (text != null) {
      current = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          current,
          const SizedBox(width: 8),
          text,
        ],
      );
    }
    current = AppTouchableOpacity(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Padding(padding: widget.padding, child: current),
    );
    return current;
  }

  Widget _buildIcon() {
    final AssetImage uncheckedIcon =
        widget.uncheckIcon ?? context.image.ic_unchecked;
    final AssetImage checkedIcon = widget.checkIcon ?? context.image.ic_checked;
    return AnimatedCrossFade(
      firstChild: Image(
        image: uncheckedIcon,
        width: widget.iconSize.width,
        height: widget.iconSize.height,
      ),
      secondChild: Image(
        image: checkedIcon,
        width: widget.iconSize.width,
        height: widget.iconSize.height,
      ),
      crossFadeState:
          _value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
    );
  }

  Widget? _buildText() {
    if (widget.textView != null) {
      return widget.textView!;
    }
    if (widget.text == null || widget.text!.isEmpty) {
      return null;
    }
    return AppText(
      widget.text!,
      textStyle: TextStyle(
        fontSize: widget.textFontSize ?? context.dimen.textNormal,
        color: widget.textColor ?? context.color.secondaryText,
        fontWeight: widget.textFontWeight,
      ).merge(widget.textStyle),
    );
  }

  void _onTap() {
    if (!widget.enabled) return;
    if (!mounted) return;
    setState(() {
      _value = !_value;
    });
    widget.onChanged?.call(_value);
  }
}
