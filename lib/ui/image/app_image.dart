import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

abstract class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.shape,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomLeft,
    this.radiusBottomRight,
    this.radiusAll,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.border,
    this.enableLoadState = false,
    this.onDoubleTap,
    this.mode = ExtendedImageMode.none,
    this.cacheWidth,
    this.cacheHeight,
    this.placeholder,
  });

  /// 默认的图片状态加载
  static Widget Function(
    BuildContext context,
    ExtendedImageState state,
  ) defaultLoadStateBuilder = (
    BuildContext context,
    ExtendedImageState state,
  ) {
    return ExtendedImage.globalStateWidgetBuilder(context, state);
  };

  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final BoxShape? shape;
  final double? radiusTopLeft;
  final double? radiusTopRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final double? radiusAll;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Border? border;
  final bool enableLoadState;
  final DoubleTap? onDoubleTap;
  final ExtendedImageMode mode;
  final int? cacheWidth;
  final int? cacheHeight;
  final Widget? placeholder;

  /// 是否设置圆角
  bool get _checkSetRadius =>
      radiusAll != null ||
      radiusTopLeft != null ||
      radiusTopRight != null ||
      radiusBottomLeft != null ||
      radiusBottomRight != null;

  /// 圆角
  BorderRadius? get usingBorderRadius {
    if (borderRadius != null) {
      return borderRadius;
    }
    final Radius topLeft =
        Radius.circular(radiusTopLeft ?? radiusAll ?? double.infinity);
    final Radius topRight =
        Radius.circular(radiusTopRight ?? radiusAll ?? double.infinity);
    final Radius bottomLeft =
        Radius.circular(radiusBottomLeft ?? radiusAll ?? double.infinity);
    final Radius bottomRight =
        Radius.circular(radiusBottomRight ?? radiusAll ?? double.infinity);
    final BorderRadius value = BorderRadius.only(
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
    if (value != BorderRadius.circular(double.infinity)) {
      return value;
    }
    return null;
  }

  /// 边框
  Border? get usingBorder {
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

  Widget? buildLoadState(BuildContext context, ExtendedImageState state) {
    if (placeholder != null) {
      return switch (state.extendedImageLoadState) {
        LoadState.loading => placeholder,
        LoadState.completed => state.completedWidget,
        LoadState.failed => placeholder,
      };
    }
    return AppImage.defaultLoadStateBuilder(context, state);
  }

  @override
  Widget build(BuildContext context);
}
