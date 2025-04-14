import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'app_image.dart';

class AppAssetImage extends AppImage {
  const AppAssetImage(
    this.image, {
    super.key,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.shape,
    super.radiusTopLeft,
    super.radiusTopRight,
    super.radiusBottomLeft,
    super.radiusBottomRight,
    super.radiusAll,
    super.borderRadius,
    super.borderColor,
    super.borderWidth,
    super.border,
    super.enableLoadState = false,
    super.onDoubleTap,
    super.mode,
    super.cacheWidth,
    super.cacheHeight,
    super.placeholder,
  });

  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.asset(
      image.assetName,
      bundle: image.bundle,
      package: image.package,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      loadStateChanged: (ExtendedImageState state) {
        return buildLoadState(context, state);
      },
      shape: shape,
      border: usingBorder,
      borderRadius: usingBorderRadius,
      enableLoadState: enableLoadState,
      onDoubleTap: onDoubleTap,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }
}
