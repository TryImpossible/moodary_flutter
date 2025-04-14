import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../app_checkbox.dart';
import '../app_text.dart';
import '../button/app_filled_button.dart';
import 'app_pop_overlay.dart';

class AppAlertDialogBuilder
    extends AppPopOverlayBuilder<AppAlertDialogBuilder> {
  AppAlertDialogBuilder.of(super.context) : super.of() {
    create((builder) => _AppAlertDialog(builder: this));
  }

  String? _titleText;
  TextStyle? _titleTextStyle;
  TextAlign? _titleTextAlign;
  TextOverflow? _titleOverflow;
  Widget? _titleView;

  AppAlertDialogBuilder setTitle(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) {
    _titleText = text;
    _titleTextStyle = style;
    _titleTextAlign = textAlign;
    _titleOverflow = overflow;
    return this;
  }

  AppAlertDialogBuilder setTitleView(Widget view) {
    _titleView = view;
    return this;
  }

  String? _messageText;
  TextStyle? _messageTextStyle;
  TextAlign? _messageTextAlign;
  TextOverflow? _messageOverflow;
  Widget? _messageView;

  AppAlertDialogBuilder setMessage(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) {
    _messageText = text;
    _messageTextStyle = style;
    _messageTextAlign = textAlign;
    _messageOverflow = overflow;
    return this;
  }

  AppAlertDialogBuilder setMessageView(Widget view) {
    _messageView = view;
    return this;
  }

  String? _backgroundMessageText;
  TextStyle? _backgroundMessageTextStyle;
  TextAlign? _backgroundMessageTextAlign;
  TextOverflow? _backgroundMessageOverflow;
  EdgeInsets? _backgroundMessagePadding;
  BorderRadius? _backgroundMessageRadius;
  Color? _backgroundMessageBackgroundColor;
  Widget? _backgroundMessageView;

  AppAlertDialogBuilder setBackgroundMessage(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    EdgeInsets? padding,
    BorderRadius? radius,
    Color? backgroundColor,
  }) {
    _backgroundMessageText = text;
    _backgroundMessageTextStyle = style;
    _backgroundMessageTextAlign = _titleTextAlign;
    _backgroundMessageOverflow = _titleOverflow;
    _backgroundMessagePadding = padding;
    _backgroundMessageRadius = radius;
    _backgroundMessageBackgroundColor = backgroundColor;
    return this;
  }

  AppAlertDialogBuilder setBackgroundMessageView(Widget view) {
    _backgroundMessageView = view;
    return this;
  }

  String? _secondaryMessageText;
  TextStyle? _secondaryMessageTextStyle;
  TextAlign? _secondaryMessageTextAlign;
  TextOverflow? _secondaryMessageOverflow;
  Widget? _secondaryMessageView;

  AppAlertDialogBuilder setSecondaryMessage(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) {
    _secondaryMessageText = text;
    _secondaryMessageTextStyle = style;
    _secondaryMessageTextAlign = _titleTextAlign;
    _secondaryMessageOverflow = _titleOverflow;
    return this;
  }

  AppAlertDialogBuilder setSecondaryMessageView(Widget view) {
    _secondaryMessageView = view;
    return this;
  }

  bool? _checkboxValue;
  String? _checkboxText;
  TextStyle? _checkboxTextStyle;

  AppAlertDialogBuilder setCheckbox(
    bool isChecked, {
    String? text,
    TextStyle? style,
  }) {
    _checkboxValue = isChecked;
    _checkboxText = text;
    _checkboxTextStyle = _checkboxTextStyle;
    return this;
  }

  String? _positiveButtonText;
  VoidCallback? _onPositiveButtonPress;

  AppAlertDialogBuilder setPositiveButton(
    String text, {
    VoidCallback? onPress,
  }) {
    _positiveButtonText = text;
    _onPositiveButtonPress = onPress;
    return this;
  }

  String? _negativeButtonText;
  VoidCallback? _onNegativeButtonPress;

  AppAlertDialogBuilder setNegativeButton(
    String text, {
    VoidCallback? onPress,
  }) {
    _negativeButtonText = text;
    _onNegativeButtonPress = onPress;
    return this;
  }

// Widget? _view;
//
// AppAlertDialogBuilder setView(Widget view) {
//   _view = view;
//   return this;
// }
}

class _AppAlertDialog extends StatelessWidget {
  const _AppAlertDialog({super.key, required this.builder});

  final AppAlertDialogBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget?>[
        const SizedBox(height: 36),
        _buildTitle(context),
        _buildMessage(context),
        _buildBackgroundMessage(context),
        _buildSecondaryMessage(context),
        _buildCheckbox(context),
        _buildButton(context),
      ].whereType<Widget>().toList(),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    Widget? current;
    if (builder._titleView != null) {
      current = builder._titleView;
    }
    if (builder._titleText != null && builder._titleText!.isNotEmpty) {
      current = Padding(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
        child: Center(
          child: AppText.secondary(
            builder._titleText!,
            textStyle: builder._titleTextStyle ??
                TextStyle(
                  fontSize: context.dimen.textBig,
                  // color: UIRes.color.primaryText,
                  color: const Color(0xE6000000),
                  fontWeight: AppFontWeight.bold,
                ),
            textAlign: builder._titleTextAlign ?? TextAlign.center,
            overflow: builder._titleOverflow ?? TextOverflow.visible,
          ),
        ),
      );
    }
    return current;
  }

  Widget? _buildMessage(BuildContext context) {
    Widget? current;
    if (builder._messageView != null) {
      current = builder._messageView;
    }
    if (builder._messageText != null && builder._messageText!.isNotEmpty) {
      final double bottom = builder._secondaryMessageView != null ||
              builder._secondaryMessageText != null
          ? 12
          : 36;
      current = Padding(
        padding: EdgeInsets.fromLTRB(36, 0, 36, bottom),
        child: AppText.secondary(
          builder._messageText!,
          textStyle: builder._messageTextStyle ??
              TextStyle(
                fontSize: context.dimen.textNormal,
                // color: UIRes.color.primaryText,
                color: const Color(0xE6000000),
                fontWeight: AppFontWeight.regular,
              ),
          textAlign: builder._messageTextAlign ?? TextAlign.left,
          overflow: builder._messageOverflow ?? TextOverflow.visible,
        ),
      );
    }
    return current;
  }

  Widget? _buildBackgroundMessage(BuildContext context) {
    Widget? current;
    if (builder._backgroundMessageView != null) {
      current = builder._backgroundMessageView;
    }
    if (builder._backgroundMessageText != null &&
        builder._backgroundMessageText!.isNotEmpty) {
      current = Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(36, 0, 36, 12),
        padding: builder._backgroundMessagePadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: builder._backgroundMessageBackgroundColor ??
              context.color.scaffoldBackground,
          borderRadius:
              builder._backgroundMessageRadius ?? BorderRadius.circular(8),
        ),
        child: AppText.primary(
          builder._backgroundMessageText!,
          textStyle: builder._backgroundMessageTextStyle ??
              TextStyle(
                fontSize: context.dimen.textNormal,
                color: context.color.primary,
                fontWeight: AppFontWeight.regular,
              ),
          textAlign: builder._backgroundMessageTextAlign ?? TextAlign.left,
          overflow: builder._backgroundMessageOverflow ?? TextOverflow.visible,
        ),
      );
    }
    return current;
  }

  Widget? _buildSecondaryMessage(BuildContext context) {
    Widget? current;
    if (builder._secondaryMessageView != null) {
      current = builder._secondaryMessageView;
    }
    if (builder._secondaryMessageText != null &&
        builder._secondaryMessageText!.isNotEmpty) {
      final double bottom = builder._backgroundMessageView != null ||
              builder._backgroundMessageText != null
          ? 36
          : 12;
      current = Padding(
        padding: EdgeInsets.fromLTRB(36, 0, 36, bottom),
        child: AppText.secondary(
          builder._secondaryMessageText!,
          textStyle: builder._secondaryMessageTextStyle ??
              TextStyle(
                fontSize: context.dimen.textNormal,
                color: context.color.secondaryText,
                fontWeight: AppFontWeight.regular,
              ),
          textAlign: builder._secondaryMessageTextAlign ?? TextAlign.left,
          overflow: builder._secondaryMessageOverflow ?? TextOverflow.visible,
        ),
      );
    }
    return current;
  }

  Widget? _buildCheckbox(BuildContext context) {
    if (builder._checkboxValue == null) {
      return null;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 36, 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AppCheckbox(
          value: builder._checkboxValue!,
          text: builder._checkboxText,
          textStyle: builder._checkboxTextStyle,
        ),
      ),
    );
  }

  Widget? _buildButton(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (builder._negativeButtonText != null &&
        builder._negativeButtonText!.isNotEmpty) {
      children.add(AppFilledButton.secondary(
        width: double.infinity,
        height: 44,
        radiusAll: 22,
        text: builder._negativeButtonText,
        textColor: context.color.primaryText,
        textFontWeight: AppFontWeight.medium,
        onTap: _onNegativeButtonPress,
      ));
    }
    if (builder._positiveButtonText != null &&
        builder._positiveButtonText!.isNotEmpty) {
      children.add(AppFilledButton.primary(
        width: double.infinity,
        height: 44,
        radiusAll: 22,
        text: builder._positiveButtonText,
        textColor: context.color.white,
        textFontWeight: AppFontWeight.medium,
        onTap: _onPositiveButtonPress,
      ));
    }
    Widget? current;
    if (children.length == 1) {
      current = Padding(
        padding: const EdgeInsets.fromLTRB(82, 0, 82, 24),
        child: children.single,
      );
    }
    if (children.length == 2) {
      const SizedBox space = SizedBox(width: 24);
      children
        ..first = Expanded(child: children.first)
        ..last = Expanded(child: children.last)
        ..insert(0, space)
        ..insert(2, space)
        ..add(space);
      current = Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(children: children),
      );
    }
    return current;
  }

  void _onNegativeButtonPress() async {
    await builder.dismiss();
    builder._onNegativeButtonPress?.call();
  }

  void _onPositiveButtonPress() async {
    await builder.dismiss();
    builder._onPositiveButtonPress?.call();
  }
}
