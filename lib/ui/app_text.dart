import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

enum _AppTextMode {
  default$,
  primary,
  secondary;

  Color? getColor(BuildContext context) {
    return switch (this) {
      default$ => null,
      primary => context.color.primaryText,
      secondary => context.color.secondaryText,
    };
  }
}

class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;

  static const FontWeight medium = FontWeight.w600;

  static const FontWeight bold = FontWeight.w700;
}

/// 通用文字组件
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.textAlign = TextAlign.start,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.selectionColor,
    this.color,
    this.backgroundColor,
    this.fontSize = 16,
    this.fontWeight = AppFontWeight.regular,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily,
    this.height = 1.2,
    this.textStyle,
  }) : _mode = _AppTextMode.default$;

  const AppText.primary(
    this.data, {
    super.key,
    this.textAlign = TextAlign.start,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.selectionColor,
    this.backgroundColor,
    this.fontSize = 16,
    this.fontWeight = AppFontWeight.regular,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily,
    this.height = 1.2,
    this.textStyle,
  })  : color = null,
        _mode = _AppTextMode.primary;

  const AppText.secondary(
    this.data, {
    super.key,
    this.textAlign = TextAlign.start,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.selectionColor,
    this.backgroundColor,
    this.fontSize = 16,
    this.fontWeight = AppFontWeight.regular,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily,
    this.height = 1.2,
    this.textStyle,
  })  : color = null,
        _mode = _AppTextMode.secondary;

  final String data;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? selectionColor;

  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final String? fontFamily;
  final double? height;
  final TextStyle? textStyle;

  final _AppTextMode _mode;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      selectionColor: selectionColor,
      style: TextStyle(
        color: _mode.getColor(context) ?? color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
        height: height,
      ).merge(textStyle),
    );
  }
}
