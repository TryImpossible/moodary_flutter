import 'dart:ui';

import 'package:moodary_flutter/core/theme/app_color.dart';

abstract class ThemeDark {
  static AppColor color = AppColor(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    transparent: const Color(0x00FFFFFF),
    background: const Color(0xFF121212), // 深色背景
    primary: const Color(0xFFFFD91A),
    secondary: const Color(0x66FFD91A),
    info: const Color(0xFF909399),
    success: const Color(0xFF67C23A),
    waning: const Color(0xFFE6A23C),
    error: const Color(0xFFFF475D),
    scaffoldBackground: const Color(0xFF181818), // 深色页面背景
    cardBackground: const Color(0xFF1E1E1E), // 深色卡片背景
    border: const Color(0xFF2C2C2C), // 深色边框
    barrierColor: const Color(0x99000000),
    primaryText: const Color(0xFFFFFFFF), // 主要文本白色
    secondaryText: const Color(0xFFB0B3B8), // 次要文本浅灰色
    disableText: const Color(0x99FFFFFF), // 60% 透明的白色
    primaryButtonBackground: const Color(0xFFFFD91A),
    primaryButtonText: const Color(0xFF111A34),
    primaryButtonPressedBackground: const Color(0xFFFFD91A),
    primaryButtonDisabledBackground: const Color(0xFF3A3A3A),
    primaryButtonDisabledText: const Color(0xFFB0B3B8),
    secondaryButtonBackground: const Color(0xFF282828),
    secondaryButtonText: const Color(0xFFFFFFFF),
    secondaryButtonPressedBackground: const Color(0xFF3A3A3A),
    secondaryButtonDisabledBackground: const Color(0xFF2C2C2C),
    secondaryButtonDisabledText: const Color(0x66FFFFFF),
    textButton: const Color(0xFFFFFFFF),
    textButtonPressed: const Color(0xFFB0B3B8),
    textButtonDisabled: const Color(0xFF2C2C2C),
    inputBackground: const Color(0xFF1E1E1E),
    inputBorder: const Color(0xFF3A3A3A),
    inputFocusedBorder: const Color(0xFF909399),
    inputErrorBorder: const Color(0xFFFF475D),
    inputText: const Color(0xFFFFFFFF),
    inputHintText: const Color(0xFFB0B3B8),
    inputDisabledText: const Color(0x99FFFFFF),
    listTileTitle: const Color(0xFFFFFFFF),
    listTileSubtitle: const Color(0xFFB0B3B8),
    listTileDivider: const Color(0xFF3A3A3A),
    tabBarIndicator: const Color(0xFFFFD91A),
    tabBarUnselected: const Color(0xFFB0B3B8),
    tabBarSelected: const Color(0xFFFFFFFF),
    appBarBackground: const Color(0xFF181818),
    appBarText: const Color(0xFFFFFFFF),
    appBarIcon: const Color(0xFFFFFFFF),
    statusBarBackground: const Color(0xFF181818),
    statusBarText: const Color(0xFFFFFFFF),
    toastBackground: const Color(0xCC1E1E1E),
    toastText: const Color(0xFFFFFFFF),
    dialogBackground: const Color(0xFF1E1E1E),
    dialogTitle: const Color(0xFFFFFFFF),
    dialogContent: const Color(0xFFB0B3B8),
    switchActive: const Color(0xFFFFD91A),
    switchInactive: const Color(0xFFE2E4EA),
    switchThumb: const Color(0xFFFFFFFF),
    sliderActive: const Color(0xFFFF475D),
    sliderInactive: const Color(0x66FF475D),
    sliderThumb: const Color(0xFFFFD91A),
    progressBar: const Color(0xFFFFD91A),
    progressBarBackground: const Color(0xFF3A3A3A),
    bottomNavBackground: const Color(0xFF181818),
    bottomNavSelected: const Color(0xFFFFD91A),
    bottomNavUnselected: const Color(0xFFB0B3B8),
  );
}