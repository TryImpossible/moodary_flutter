import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import 'app_button.dart';

class AppTextButton extends AppButton {
  const AppTextButton({
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
    super.text,
    super.textFontSize,
    super.textColor,
    super.textFontWeight,
    super.textStyle,
    super.textAlign,
    super.child,
    super.onTap,
  });

  @override
  TextStyle getUsingTextStyle(BuildContext context) =>
      textStyle ??
      TextStyle(
        color: textColor ?? context.color.primaryText,
        fontSize: textFontSize ?? context.dimen.textNormal,
        fontWeight: textFontWeight,
      );
}
