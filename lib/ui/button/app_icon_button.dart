import 'package:flutter/material.dart';

import 'app_button.dart';

class AppIconButton extends AppButton {
  AppIconButton({
    super.key,
    super.enabled,
    super.activeOpacity,
    double? width,
    double? height,
    super.paddingStart,
    super.paddingTop,
    super.paddingEnd,
    super.paddingBottom,
    super.paddingAll,
    super.padding,
    super.icon,
    Color? color,
    super.child,
    super.onTap,
  }) : super(iconSize: Size(width ?? 36, height ?? 36), iconColor: color);
}
