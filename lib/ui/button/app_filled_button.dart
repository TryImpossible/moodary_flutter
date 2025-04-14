import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../app_text.dart';
import 'app_button.dart';

class AppFilledButton extends AppButton {
  const AppFilledButton({
    super.key,
    super.enabled,
    super.activeOpacity,
    super.width,
    super.height,
    super.paddingStart,
    super.paddingTop,
    super.paddingEnd,
    super.paddingBottom,
    super.paddingAll,
    super.padding,
    super.backgroundColor,
    super.radiusTopStart,
    super.radiusTopEnd,
    super.radiusBottomStart,
    super.radiusBottomEnd,
    super.radiusAll,
    super.borderRadius,
    super.boxDecoration,
    super.icon,
    super.iconColor,
    super.iconSize,
    super.iconSpacing,
    super.iconPosition,
    super.text,
    super.textFontSize,
    super.textColor,
    super.textFontWeight,
    super.textStyle,
    super.textAlign,
    super.child,
    super.onTap,
  }) : _mode = AppButtonMode.default$;

  const AppFilledButton.primary({
    super.key,
    super.enabled,
    super.activeOpacity,
    super.width,
    super.height,
    super.paddingStart,
    super.paddingTop,
    super.paddingEnd,
    super.paddingBottom,
    super.paddingAll,
    super.padding,
    super.backgroundColor,
    super.radiusTopStart,
    super.radiusTopEnd,
    super.radiusBottomStart,
    super.radiusBottomEnd,
    super.radiusAll = 22,
    super.borderRadius,
    super.boxDecoration,
    super.icon,
    super.iconColor,
    super.iconSize,
    super.iconSpacing,
    super.iconPosition,
    super.text,
    super.textFontSize,
    super.textColor,
    super.textFontWeight = AppFontWeight.medium,
    super.textStyle,
    super.textAlign,
    super.child,
    super.onTap,
  }) : _mode = AppButtonMode.primary;

  const AppFilledButton.secondary({
    super.key,
    super.enabled,
    super.activeOpacity,
    super.width,
    super.height,
    super.paddingStart,
    super.paddingTop,
    super.paddingEnd,
    super.paddingBottom,
    super.paddingAll,
    super.padding,
    super.backgroundColor,
    super.radiusTopStart,
    super.radiusTopEnd,
    super.radiusBottomStart,
    super.radiusBottomEnd,
    super.radiusAll = 22,
    super.borderRadius,
    super.boxDecoration,
    super.icon,
    super.iconColor,
    super.iconSize,
    super.iconSpacing,
    super.iconPosition,
    super.text,
    super.textFontSize,
    super.textColor,
    super.textFontWeight = AppFontWeight.medium,
    super.textStyle,
    super.textAlign,
    super.child,
    super.onTap,
  }) : _mode = AppButtonMode.secondary;

  final AppButtonMode _mode;

  @override
  Color? getUsingBackgroundColor(BuildContext context) {
    return switch (_mode) {
      AppButtonMode.default$ => null,
      AppButtonMode.primary => backgroundColor ?? context.color.primary,
      AppButtonMode.secondary => backgroundColor ?? context.color.white,
    };
  }

  @override
  TextStyle? getUsingTextStyle(BuildContext context) {
    if (textStyle != null) {
      return textStyle!;
    }
    return switch (_mode) {
      AppButtonMode.default$ => null,
      AppButtonMode.primary => TextStyle(
          color: textColor ?? context.color.white,
          fontSize: textFontSize ?? context.dimen.textBig,
          fontWeight: textFontWeight,
        ),
      AppButtonMode.secondary => TextStyle(
          color: textColor ?? context.color.primaryText,
          fontSize: textFontSize ?? context.dimen.textBig,
          fontWeight: textFontWeight,
        ),
    };
  }
}
