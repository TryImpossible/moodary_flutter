import 'package:flutter/material.dart';

class ThemeColor extends ThemeExtension<ThemeColor> {
  ThemeColor({
    required this.white,
    required this.black,
    required this.transparent,
    required this.background,
    required this.primary,
    required this.secondary,
    required this.info,
    required this.success,
    required this.waning,
    required this.error,
    required this.scaffoldBackground,
    required this.cardBackground,
    required this.border,
    required this.barrierColor,
    required this.primaryText,
    required this.secondaryText,
    required this.disableText,
    required this.primaryButtonBackground,
    required this.primaryButtonText,
    required this.primaryButtonPressedBackground,
    required this.primaryButtonDisabledBackground,
    required this.primaryButtonDisabledText,
    required this.secondaryButtonBackground,
    required this.secondaryButtonText,
    required this.secondaryButtonPressedBackground,
    required this.secondaryButtonDisabledBackground,
    required this.secondaryButtonDisabledText,
    required this.textButton,
    required this.textButtonPressed,
    required this.textButtonDisabled,
    required this.inputBackground,
    required this.inputBorder,
    required this.inputFocusedBorder,
    required this.inputErrorBorder,
    required this.inputText,
    required this.inputHintText,
    required this.inputDisabledText,
    required this.listTileTitle,
    required this.listTileSubtitle,
    required this.listTileDivider,
    required this.tabBarIndicator,
    required this.tabBarUnselected,
    required this.tabBarSelected,
    required this.appBarBackground,
    required this.appBarText,
    required this.appBarIcon,
    required this.statusBarBackground,
    required this.statusBarText,
    required this.toastBackground,
    required this.toastText,
    required this.dialogBackground,
    required this.dialogTitle,
    required this.dialogContent,
    required this.switchActive,
    required this.switchInactive,
    required this.switchThumb,
    required this.sliderActive,
    required this.sliderInactive,
    required this.sliderThumb,
    required this.progressBar,
    required this.progressBarBackground,
    required this.bottomNavBackground,
    required this.bottomNavSelected,
    required this.bottomNavUnselected,
  });

  /// 白色
  final Color white;

  /// 黑色
  final Color black;

  /// 透明色
  final Color transparent;

  /// 普通背景色
  final Color background;

  // ========== 基础颜色 ==========

  /// 主色
  final Color primary;

  /// 辅助色
  final Color secondary;

  /// 信息颜色
  final Color info;

  /// 成功的颜色
  final Color success;

  /// 警告颜色
  final Color waning;

  /// 错误颜色
  final Color error;

  /// 页面背景色
  final Color scaffoldBackground;

  /// 卡片背景色
  final Color cardBackground;

  /// 普通边框颜色
  final Color border;

  /// 蒙层、背景遮罩颜色。
  final Color barrierColor;

  // ========== 文字颜色 ==========

  /// 主要文字颜色
  final Color primaryText;

  /// 次要文字颜色
  final Color secondaryText;

  /// 禁用文字颜色
  final Color disableText;

  // ========== 按钮颜色 ==========

  /// 主按钮背景色
  final Color primaryButtonBackground;

  /// 主按钮文字色
  final Color primaryButtonText;

  /// 主按钮按下时背景色
  final Color primaryButtonPressedBackground;

  /// 主按钮禁用时背景色
  final Color primaryButtonDisabledBackground;

  /// 主按钮禁用时文字色
  final Color primaryButtonDisabledText;

  /// 次要按钮背景色
  final Color secondaryButtonBackground;

  /// 次要钮文字色
  final Color secondaryButtonText;

  /// 次要按钮按下时背景色
  final Color secondaryButtonPressedBackground;

  /// 次要按钮禁用时背景色
  final Color secondaryButtonDisabledBackground;

  /// 次要按钮禁用时文字色
  final Color secondaryButtonDisabledText;

  /// 文本按钮文字色
  final Color textButton;

  /// 文本按钮按下时文字色
  final Color textButtonPressed;

  /// 文本按钮禁用时文字色
  final Color textButtonDisabled;

  // ========== 输入框颜色 ==========

  /// 输入框背景色
  final Color inputBackground;

  /// 输入框边框颜色
  final Color inputBorder;

  /// 输入框获取焦点时边框颜色
  final Color inputFocusedBorder;

  /// 输入框获错误时边框颜色
  final Color inputErrorBorder;

  /// 输入框文字颜色
  final Color inputText;

  /// 输入框占位符颜色
  final Color inputHintText;

  /// 输入禁用文字颜色
  final Color inputDisabledText;

  // ========== 列表 (ListTile) ==========

  /// ListTile标题颜色
  final Color listTileTitle;

  /// ListTile副标题颜色
  final Color listTileSubtitle;

  /// ListTile分隔线颜色
  final Color listTileDivider;

  // ========== TabBar ==========

  /// TabBar指示器颜色
  final Color tabBarIndicator;

  /// TabBar未选中状态颜色
  final Color tabBarUnselected;

  /// TabBar选中状态颜色
  final Color tabBarSelected;

  // ========== AppBar ==========

  /// AppBar背景颜色
  final Color appBarBackground;

  /// AppBar文字颜色
  final Color appBarText;

  /// AppBar图标颜色
  final Color appBarIcon;

  // ========== 状态栏 ==========

  /// 状态栏背景颜色
  final Color statusBarBackground;

  /// 状态栏文字颜色
  final Color statusBarText;

  // ========== Toast ==========

  /// Toast背景颜色
  final Color toastBackground;

  /// Toast文字颜色
  final Color toastText;

  // ========== 对话框 (Dialog) ==========

  /// 弹窗背景色
  final Color dialogBackground;
  /// 弹窗标题文字颜色
  final Color dialogTitle;
  /// 弹窗内容文字颜色
  final Color dialogContent;

  // ========== Switch 开关 ==========

  /// Switch启用状态颜色
  final Color switchActive;

  /// Switch未启用状态颜色
  final Color switchInactive;

  /// Switch指示器颜色
  final Color switchThumb;

  // ==========  滑块 (Slider) ==========

  /// Slider启用状态颜色
  final Color sliderActive;

  /// Slider未启用状态颜色
  final Color sliderInactive;

  /// Slider指示器颜色
  final Color sliderThumb;

  // ==========  进度条 ==========

  /// 进度条颜色
  final Color progressBar;

  /// 进度条背景颜色
  final Color progressBarBackground;

  // ========== 底部导航栏 (BottomNavigationBar) ==========

  /// 底部导航栏背景颜色
  final Color bottomNavBackground;

  /// 底部导航栏选中颜色
  final Color bottomNavSelected;

  /// 底部导航栏未选中颜色
  final Color bottomNavUnselected;

  @override
  ThemeExtension<ThemeColor> copyWith({
    Color? white,
    Color? black,
    Color? transparent,
    Color? background,
    Color? primary,
    Color? secondary,
    Color? info,
    Color? success,
    Color? waning,
    Color? error,
    Color? scaffoldBackground,
    Color? cardBackground,
    Color? border,
    Color? barrierColor,
    Color? primaryText,
    Color? secondaryText,
    Color? disableText,
    Color? primaryButtonBackground,
    Color? primaryButtonText,
    Color? primaryButtonPressedBackground,
    Color? primaryButtonDisabledBackground,
    Color? primaryButtonDisabledText,
    Color? secondaryButtonBackground,
    Color? secondaryButtonText,
    Color? secondaryButtonPressedBackground,
    Color? secondaryButtonDisabledBackground,
    Color? secondaryButtonDisabledText,
    Color? textButton,
    Color? textButtonPressed,
    Color? textButtonDisabled,
    Color? inputBackground,
    Color? inputBorder,
    Color? inputFocusedBorder,
    Color? inputErrorBorder,
    Color? inputText,
    Color? inputHintText,
    Color? inputDisabledText,
    Color? listTileTitle,
    Color? listTileSubtitle,
    Color? listTileDivider,
    Color? tabBarIndicator,
    Color? tabBarUnselected,
    Color? tabBarSelected,
    Color? appBarBackground,
    Color? appBarText,
    Color? appBarIcon,
    Color? statusBarBackground,
    Color? statusBarText,
    Color? toastBackground,
    Color? toastText,
    Color? dialogBackground,
    Color? dialogTitle,
    Color? dialogContent,
    Color? switchActive,
    Color? switchInactive,
    Color? switchThumb,
    Color? sliderActive,
    Color? sliderInactive,
    Color? sliderThumb,
    Color? progressBar,
    Color? progressBarBackground,
    Color? bottomNavBackground,
    Color? bottomNavSelected,
    Color? bottomNavUnselected,
  }) {
    return ThemeColor(
      white: white ?? this.white,
      black: black ?? this.black,
      transparent: transparent ?? this.transparent,
      background: background ?? this.background,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      info: info ?? this.info,
      success: success ?? this.success,
      waning: waning ?? this.waning,
      error: error ?? this.error,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      border: border ?? this.border,
      barrierColor: barrierColor ?? this.barrierColor,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      disableText: disableText ?? this.disableText,
      primaryButtonBackground:
          primaryButtonBackground ?? this.primaryButtonBackground,
      primaryButtonText: primaryButtonText ?? this.primaryButtonText,
      primaryButtonPressedBackground:
          primaryButtonPressedBackground ?? this.primaryButtonPressedBackground,
      primaryButtonDisabledBackground: primaryButtonDisabledBackground ??
          this.primaryButtonDisabledBackground,
      primaryButtonDisabledText:
          primaryButtonDisabledText ?? this.primaryButtonDisabledText,
      secondaryButtonBackground:
          secondaryButtonBackground ?? this.secondaryButtonBackground,
      secondaryButtonText: secondaryButtonText ?? this.secondaryButtonText,
      secondaryButtonPressedBackground: secondaryButtonPressedBackground ??
          this.secondaryButtonPressedBackground,
      secondaryButtonDisabledBackground: secondaryButtonDisabledBackground ??
          this.secondaryButtonDisabledBackground,
      secondaryButtonDisabledText:
          secondaryButtonDisabledText ?? this.secondaryButtonDisabledText,
      textButton: textButton ?? this.textButton,
      textButtonPressed: textButtonPressed ?? this.textButtonPressed,
      textButtonDisabled: textButtonDisabled ?? this.textButtonDisabled,
      inputBackground: inputBackground ?? this.inputBackground,
      inputBorder: inputBorder ?? this.inputBorder,
      inputFocusedBorder: inputFocusedBorder ?? this.inputFocusedBorder,
      inputErrorBorder: inputErrorBorder ?? this.inputErrorBorder,
      inputText: inputText ?? this.inputText,
      inputHintText: inputHintText ?? this.inputHintText,
      inputDisabledText: inputDisabledText ?? this.inputDisabledText,
      listTileTitle: listTileTitle ?? this.listTileTitle,
      listTileSubtitle: listTileSubtitle ?? this.listTileSubtitle,
      listTileDivider: listTileDivider ?? this.listTileDivider,
      tabBarIndicator: tabBarIndicator ?? this.tabBarIndicator,
      tabBarUnselected: tabBarUnselected ?? this.tabBarUnselected,
      tabBarSelected: tabBarSelected ?? this.tabBarSelected,
      appBarBackground: appBarBackground ?? this.appBarBackground,
      appBarText: appBarText ?? this.appBarText,
      appBarIcon: appBarIcon ?? this.appBarIcon,
      statusBarBackground: statusBarBackground ?? this.statusBarBackground,
      statusBarText: statusBarText ?? this.statusBarText,
      toastBackground: toastBackground ?? this.toastBackground,
      toastText: toastText ?? this.toastText,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogContent: dialogContent ?? this.dialogContent,
      switchActive: switchActive ?? this.switchActive,
      switchInactive: switchInactive ?? this.switchInactive,
      switchThumb: switchThumb ?? this.switchThumb,
      sliderActive: sliderActive ?? this.sliderActive,
      sliderInactive: sliderInactive ?? this.sliderInactive,
      sliderThumb: sliderThumb ?? this.sliderThumb,
      progressBar: progressBar ?? this.progressBar,
      progressBarBackground:
          progressBarBackground ?? this.progressBarBackground,
      bottomNavBackground: bottomNavBackground ?? this.bottomNavBackground,
      bottomNavSelected: bottomNavSelected ?? this.bottomNavSelected,
      bottomNavUnselected: bottomNavUnselected ?? this.bottomNavUnselected,
    );
  }

  @override
  ThemeExtension<ThemeColor> lerp(
    covariant ThemeExtension<ThemeColor>? other,
    double t,
  ) {
    if (other is! ThemeColor) {
      return this;
    }
    return ThemeColor(
      // white: Color.lerp(white, other.white, t) ?? white,
      white: white,
      black: black,
      transparent: transparent,
      background: background,
      primary: primary,
      secondary: secondary,
      info: info,
      success: success,
      waning: waning,
      error: error,
      scaffoldBackground: scaffoldBackground,
      cardBackground: cardBackground,
      border: border,
      barrierColor: barrierColor,
      primaryText: primaryText,
      secondaryText: secondaryText,
      disableText: disableText,
      primaryButtonBackground: primaryButtonBackground,
      primaryButtonText: primaryButtonText,
      primaryButtonPressedBackground: primaryButtonPressedBackground,
      primaryButtonDisabledBackground: primaryButtonDisabledBackground,
      primaryButtonDisabledText: primaryButtonDisabledText,
      secondaryButtonBackground: secondaryButtonBackground,
      secondaryButtonText: secondaryButtonText,
      secondaryButtonPressedBackground: secondaryButtonPressedBackground,
      secondaryButtonDisabledBackground: secondaryButtonDisabledBackground,
      secondaryButtonDisabledText: secondaryButtonDisabledText,
      textButton: textButton,
      textButtonPressed: textButtonPressed,
      textButtonDisabled: textButtonDisabled,
      inputBackground: inputBackground,
      inputBorder: inputBorder,
      inputFocusedBorder: inputFocusedBorder,
      inputErrorBorder: inputErrorBorder,
      inputText: inputText,
      inputHintText: inputHintText,
      inputDisabledText: inputDisabledText,
      listTileTitle: listTileTitle,
      listTileSubtitle: listTileSubtitle,
      listTileDivider: listTileDivider,
      tabBarIndicator: tabBarIndicator,
      tabBarUnselected: tabBarUnselected,
      tabBarSelected: tabBarSelected,
      appBarBackground: appBarBackground,
      appBarText: appBarText,
      appBarIcon: appBarIcon,
      statusBarBackground: statusBarBackground,
      statusBarText: statusBarText,
      toastBackground: toastBackground,
      toastText: toastText,
      dialogBackground: dialogBackground,
      dialogTitle: dialogTitle,
      dialogContent: dialogContent,
      switchActive: switchActive,
      switchInactive: switchInactive,
      switchThumb: switchThumb,
      sliderActive: sliderActive,
      sliderInactive: sliderInactive,
      sliderThumb: sliderThumb,
      progressBar: progressBar,
      progressBarBackground: progressBarBackground,
      bottomNavBackground: bottomNavBackground,
      bottomNavSelected: bottomNavSelected,
      bottomNavUnselected: bottomNavUnselected,
    );
  }
}
