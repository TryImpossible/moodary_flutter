import 'package:flutter/material.dart';

import '../app_touchable_opacity.dart';
import '../image/app_asset_image.dart';

enum AppButtonMode {
  default$,
  primary,
  secondary;
}

enum AppButtonIconPosition {
  start,
  top,
  end,
  bottom;

  Axis get _direction => switch (this) {
        start || end => Axis.horizontal,
        top || bottom => Axis.vertical,
      };

  bool get _isStart => switch (this) {
        start || top => true,
        end || bottom => false,
      };

  bool get _isEnd => !_isStart;
}

abstract class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.enabled = true,
    this.activeOpacity = 0.6,
    this.width,
    this.height,
    this.paddingStart,
    this.paddingTop,
    this.paddingEnd,
    this.paddingBottom,
    this.paddingAll,
    this.padding,
    this.backgroundColor,
    this.borderWidth,
    this.borderColor,
    this.border,
    this.radiusTopStart,
    this.radiusTopEnd,
    this.radiusBottomStart,
    this.radiusBottomEnd,
    this.radiusAll,
    this.borderRadius,
    this.boxDecoration,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.iconSpacing,
    this.iconPosition = AppButtonIconPosition.start,
    this.text,
    this.textFontSize,
    this.textColor,
    this.textFontWeight,
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.child,
    this.onTap,
  });

  /// 是否启用
  final bool enabled;

  /// 触摸操作激活时以多少不透明度显示，默认0.6
  final double activeOpacity;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 左边方向内边距
  final double? paddingStart;

  /// 上边方向内边距
  final double? paddingTop;

  /// 右边方向内边距
  final double? paddingEnd;

  /// 下边方向内边距
  final double? paddingBottom;

  /// 四个方向内边距
  final double? paddingAll;

  /// 内边距
  final EdgeInsetsDirectional? padding;

  /// 背景颜色
  final Color? backgroundColor;

  /// 边框大小
  final double? borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 边框
  final BoxBorder? border;

  /// 左上角圆角大小
  final double? radiusTopStart;

  /// 右上角圆角大小
  final double? radiusTopEnd;

  /// 左下角圆角大小
  final double? radiusBottomStart;

  /// 右下角圆角大小
  final double? radiusBottomEnd;

  /// 圆角大小
  final double? radiusAll;

  /// 圆角
  final BorderRadiusDirectional? borderRadius;

  /// 背景
  final BoxDecoration? boxDecoration;

  /// 图标
  final AssetImage? icon;

  /// 图标颜色
  final Color? iconColor;

  /// 图标大小
  final Size? iconSize;

  /// 图标与文字间距
  final double? iconSpacing;

  /// 图标位置
  final AppButtonIconPosition iconPosition;

  /// 文字
  final String? text;

  /// 文字颜色
  final Color? textColor;

  /// 文字大小
  final double? textFontSize;

  /// 文字字体
  final FontWeight? textFontWeight;

  /// 文字样式
  final TextStyle? textStyle;

  /// 文字对齐方式
  final TextAlign textAlign;

  /// child存在，图标与文字相关设置都不生效
  final Widget? child;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget? icon = buildIcon(context);
    final Widget? text = buildText(context);
    Widget? current = composeIconText(context, icon, text);
    current = buildBox(context, current);
    current = AppTouchableOpacity(
      behavior: HitTestBehavior.opaque,
      enabled: enabled,
      activeOpacity: activeOpacity,
      onTap: onTap,
      child: current,
    );
    return current;
  }

  /// 图标
  Widget? buildIcon(BuildContext context) {
    Widget? current;
    if (icon != null) {
      current = AppAssetImage(
        icon!,
        width: iconSize?.width,
        height: iconSize?.height,
        color: iconColor,
        fit: BoxFit.contain,
      );
    }
    return current;
  }

  /// 文字样式
  TextStyle? getUsingTextStyle(BuildContext context) =>
      textStyle ??
      TextStyle(
        color: textColor,
        fontSize: textFontSize,
        fontWeight: textFontWeight,
      );

  /// 文字
  Widget? buildText(BuildContext context) {
    Widget? current;
    if (text != null) {
      return Text(
        text!,
        style: getUsingTextStyle(context),
        textAlign: textAlign,
      );
    }
    return current;
  }

  /// 组合图标和文字
  Widget? composeIconText(BuildContext context, Widget? icon, Widget? text) {
    Widget? current;
    if (icon != null) {
      current = icon;
    }
    if (text != null) {
      current = text;
    }
    if (icon != null && text != null) {
      current = Flex(
        direction: iconPosition._direction,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (iconPosition._isStart) icon else Flexible(child: text),
          if (iconSpacing != null && iconSpacing! > 0)
            SizedBox(width: iconSpacing),
          if (iconPosition._isEnd) icon else Flexible(child: text),
        ],
      );
    }
    return current;
  }

  /// 边框
  BoxBorder? getUsingBoxBorder(BuildContext context) {
    if (border != null) {
      return border;
    }
    if (borderWidth != null && borderColor != null) {
      return Border.all(width: borderWidth!, color: borderColor!);
    }
    if (borderWidth != null && borderColor == null) {
      return Border.all(width: borderWidth!);
    }
    if (borderWidth == null && borderColor != null) {
      return Border.all(color: borderColor!);
    }
    return null;
  }

  EdgeInsetsDirectional? getUsingPadding(BuildContext context) {
    final double start =
        paddingStart ?? paddingAll ?? padding?.start ?? double.infinity;
    final double top =
        paddingTop ?? paddingAll ?? padding?.top ?? double.infinity;
    final double end =
        paddingEnd ?? paddingAll ?? padding?.end ?? double.infinity;
    final double bottom =
        paddingBottom ?? paddingAll ?? padding?.bottom ?? double.infinity;
    final EdgeInsetsDirectional insets = EdgeInsetsDirectional.only(
      start: start,
      top: top,
      end: end,
      bottom: bottom,
    );
    if (insets != const EdgeInsetsDirectional.all(double.infinity)) {
      return insets;
    }
    return null;
  }

  /// 圆角
  BorderRadiusDirectional? getUsingBorderRadius(BuildContext context) {
    if (borderRadius != null) {
      return borderRadius;
    }
    final Radius topStart =
        Radius.circular(radiusTopStart ?? radiusAll ?? double.infinity);
    final Radius topEnd =
        Radius.circular(radiusTopEnd ?? radiusAll ?? double.infinity);
    final Radius bottomStart =
        Radius.circular(radiusBottomStart ?? radiusAll ?? double.infinity);
    final Radius bottomEnd =
        Radius.circular(radiusBottomEnd ?? radiusAll ?? double.infinity);
    final BorderRadiusDirectional value = BorderRadiusDirectional.only(
      topStart: topStart,
      topEnd: topEnd,
      bottomStart: bottomStart,
      bottomEnd: bottomEnd,
    );
    if (value != BorderRadiusDirectional.circular(double.infinity)) {
      return value;
    }
    return null;
  }

  Color? getUsingBackgroundColor(BuildContext context) => backgroundColor;

  /// 盒子装饰器
  BoxDecoration getUsingBoxDecoration(BuildContext context) =>
      boxDecoration ??
      BoxDecoration(
        border: getUsingBoxBorder(context),
        borderRadius: getUsingBorderRadius(context),
        color: getUsingBackgroundColor(context),
      );

  /// 容器
  Widget buildBox(BuildContext context, Widget? child) {
    Widget current = SizedBox(
      width: width,
      height: height,
      child: Center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: this.child ?? child,
      ),
    );

    final EdgeInsetsGeometry? usingPadding = getUsingPadding(context);
    if (usingPadding != null) {
      current = Padding(
        padding: usingPadding,
        child: current,
      );
    }

    current = DecoratedBox(
      decoration: getUsingBoxDecoration(context),
      child: current,
    );

    return current;
  }
}
