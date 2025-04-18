// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Used with [TabBar.indicator] to draw a horizontal line below the
/// selected tab.
///
/// The selected tab underline is inset from the tab's boundary by [insets].
/// The [borderSide] defines the line's color and weight.
///
/// The [TabBar.indicatorSize] property can be used to define the indicator's
/// bounds in terms of its (centered) widget with [TabBarIndicatorSize.label],
/// or the entire tab with [TabBarIndicatorSize.tab].
class AppUnderlineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const AppUnderlineTabIndicator({
    this.borderRadius,
    this.borderSide = const BorderSide(width: 2.0, color: Colors.black),
    this.insets = EdgeInsets.zero,
    this.width = 12,
    this.gradient,
  });

  /// The radius of the indicator's corners.
  ///
  /// If this value is non-null, rounded rectangular tab indicator is
  /// drawn, otherwise rectangular tab indictor is drawn.
  final BorderRadius? borderRadius;

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the tab
  /// indicator's bounds in terms of its (centered) tab widget with
  /// [TabBarIndicatorSize.label], or the entire tab with
  /// [TabBarIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  final double? width;

  final Gradient? gradient;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is AppUnderlineTabIndicator) {
      return AppUnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is AppUnderlineTabIndicator) {
      return AppUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _AppUnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    if (width != null) {
      //取中间坐标
      final double middle = (indicator.left + indicator.right) / 2;
      return Rect.fromLTWH(
        middle - width! / 2,
        indicator.bottom - borderSide.width,
        width!,
        borderSide.width,
      );
    } else {
      return Rect.fromLTWH(
        indicator.left,
        indicator.bottom - borderSide.width,
        indicator.width,
        borderSide.width,
      );
    }
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    if (borderRadius != null) {
      return Path()
        ..addRRect(
            borderRadius!.toRRect(_indicatorRectFor(rect, textDirection)));
    }
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _AppUnderlinePainter extends BoxPainter {
  _AppUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final AppUnderlineTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Paint paint;
    final BorderRadius? borderRadius = decoration.borderRadius;
    if (borderRadius != null) {
      final Rect indicator = decoration
          ._indicatorRectFor(rect, textDirection)
          .inflate(decoration.borderSide.width / 4.0);
      paint = Paint()
        ..color = decoration.borderSide.color
        ..shader = decoration.gradient?.createShader(indicator);
      final RRect rrect = RRect.fromRectAndCorners(
        indicator,
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomRight: borderRadius.bottomRight,
        bottomLeft: borderRadius.bottomLeft,
      );
      canvas.drawRRect(rrect, paint);
    } else {
      final Rect indicator = decoration
          ._indicatorRectFor(rect, textDirection)
          .deflate(decoration.borderSide.width / 2.0);
      final Paint paint = decoration.borderSide.toPaint()
        ..strokeCap = StrokeCap.round
        ..shader = decoration.gradient?.createShader(indicator);
      canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
    }
  }
}
