import 'package:flutter/material.dart';

import 'app_button.dart';

class AppIconButton extends AppButton {
  AppIconButton({
    super.key,
    super.enabled,
    super.activeOpacity,
    double width = 36,
    double height = 36,
    super.paddingStart,
    super.paddingTop,
    super.paddingEnd,
    super.paddingBottom,
    super.paddingHorizontal,
    super.paddingVertical,
    super.paddingAll,
    super.padding,
    super.icon,
    Color? color,
    super.child,
    super.onTap,
  }) : super(iconSize: Size(width, height), iconColor: color);
}
