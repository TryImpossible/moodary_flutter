import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'app_image.dart';

class AppNetworkImage extends AppImage {
  const AppNetworkImage(
    this.url, {
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
    super.enableLoadState = true,
    super.onDoubleTap,
    super.mode,
    super.cacheWidth,
    super.cacheHeight,
    super.placeholder,
    this.cancelToken,
    this.retries = 3,
    this.timeLimit,
    this.headers,
    this.cache = true,
    this.scale = 1.0,
    this.timeRetry = const Duration(milliseconds: 100),
  });

  final String url;
  final CancellationToken? cancelToken;
  final int retries;
  final Duration? timeLimit;
  final Map<String, String>? headers;
  final bool cache;
  final double scale;
  final Duration timeRetry;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
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
      cancelToken: cancelToken,
      retries: retries,
      timeLimit: timeLimit,
      headers: headers,
      cache: cache,
      scale: scale,
      timeRetry: timeRetry,
    );
  }
}
