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
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.radius,
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
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final double? radius;
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
      radius != null ||
      topLeftRadius != null ||
      topRightRadius != null ||
      bottomLeftRadius != null ||
      bottomRightRadius != null;

  /// 圆角
  BorderRadius? get usingBorderRadius {
    if (!_checkSetRadius) return null;
    return borderRadius ??
        BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius ?? radius ?? 0),
          topRight: Radius.circular(topRightRadius ?? radius ?? 0),
          bottomLeft: Radius.circular(bottomLeftRadius ?? radius ?? 0),
          bottomRight: Radius.circular(bottomRightRadius ?? radius ?? 0),
        );
  }

  /// 是否设置边框
  bool get _checkSetBorder =>
      borderColor != null || borderWidth != null || border != null;

  /// 边框
  Border? get usingBorder {
    if (!_checkSetBorder) return null;
    return border ??
        Border.all(
          width: borderWidth ?? 0.0,
          color: borderColor ?? Colors.transparent,
        );
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
