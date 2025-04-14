import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import 'app_button.dart';

class AppOutlinedButton extends AppButton {
  const AppOutlinedButton({
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
    super.borderWidth,
    super.borderColor,
    super.radiusTopStart,
    super.radiusTopEnd,
    super.radiusBottomStart,
    super.radiusBottomEnd,
    super.radiusAll,
    super.borderRadius,
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

  const AppOutlinedButton.primary({
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
    super.borderWidth,
    super.borderColor,
    super.radiusTopStart,
    super.radiusTopEnd,
    super.radiusBottomStart,
    super.radiusBottomEnd,
    super.radiusAll = 22,
    super.borderRadius,
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
  }) : _mode = AppButtonMode.primary;

  const AppOutlinedButton.secondary({
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
    super.borderWidth,
    super.borderColor,
    super.radiusTopStart,
    super.radiusTopEnd,
    super.radiusBottomStart,
    super.radiusBottomEnd,
    super.radiusAll = 22,
    super.borderRadius,
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
  }) : _mode = AppButtonMode.secondary;

  final AppButtonMode _mode;

  @override
  BoxBorder? getUsingBoxBorder(BuildContext context) {
    if (border != null) {
      return border;
    }
    return switch (_mode) {
      AppButtonMode.default$ => null,
      AppButtonMode.primary => Border.all(
          width: borderWidth ?? context.dimen.borderNormal,
          color: borderColor ?? context.color.border,
        ),
      AppButtonMode.secondary => Border.all(
          width: borderWidth ?? context.dimen.borderNormal,
          color: borderColor ?? context.color.border,
        ),
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
          color: textColor ?? context.color.primaryButtonText,
          fontSize: textFontSize ?? context.dimen.textBig,
          fontWeight: textFontWeight,
        ),
      AppButtonMode.secondary => TextStyle(
          color: textColor ?? context.color.secondaryButtonText,
          fontSize: textFontSize ?? context.dimen.textBig,
          fontWeight: textFontWeight,
        ),
    };
  }
}
