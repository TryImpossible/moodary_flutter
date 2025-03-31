import 'dart:ui';

import 'package:moodary_flutter/core/theme/app_color.dart';

abstract class ThemeLight {
  static AppColor color = AppColor(
    white: const Color(0xFFFFFFFF),
    black: const Color(0xFF000000),
    transparent: const Color(0x00FFFFFF),
    background: const Color(0xFFFFFFFF),
    primary: const Color(0xFFFFD91A),
    secondary: const Color(0x66FFD91A),
    info: const Color(0xFF909399),
    success: const Color(0xFF67C23A),
    waning: const Color(0xFFE6A23C),
    error: const Color(0xFFFF475D),
    scaffoldBackground: const Color(0xFFF5F6F7),
    cardBackground: const Color(0xFFFFFFFF),
    border: const Color(0xFFE2E4EA),
    barrierColor: const Color(0x99000000),
    primaryText: const Color(0xFF111A34),
    secondaryText: const Color(0xFF858B9C),
    disableText: const Color(0xFF111A34).withOpacity(0.6),
    primaryButtonBackground: const Color(0xFFFFD91A),
    primaryButtonText: const Color(0xFF111A34),
    primaryButtonPressedBackground: const Color(0xFFFFD91A),
    primaryButtonDisabledBackground: const Color(0xFFE2E4EA),
    primaryButtonDisabledText: const Color(0xFFFFFFFF),
    secondaryButtonBackground: const Color(0xFFF5F6F7),
    secondaryButtonText: const Color(0xFF111A34),
    secondaryButtonPressedBackground: const Color(0xFFEBEDF0),
    secondaryButtonDisabledBackground: const Color(0xFFE2E4EA),
    secondaryButtonDisabledText: const Color(0x66111A34),
    textButton: const Color(0xFF111A34),
    textButtonPressed: const Color(0xFF111A34),
    textButtonDisabled: const Color(0xFFE2E4EA),
    inputBackground: const Color(0x00FFFFFF),
    inputBorder: const Color(0xFFE2E4EA),
    inputFocusedBorder: const Color(0xFF262A33),
    inputErrorBorder: const Color(0xFFFF475D),
    inputText: const Color(0xFF111A34),
    inputHintText: const Color(0xFFC5CAD5),
    inputDisabledText: const Color(0xFF111A34).withOpacity(0.6),
    listTileTitle: const Color(0xFF111A34),
    listTileSubtitle: const Color(0xFF555C72),
    listTileDivider: const Color(0xFFE2E4EA),
    tabBarIndicator: const Color(0xFFFFD91A),
    tabBarUnselected: const Color(0xFF858B9C),
    tabBarSelected: const Color(0xFF111A34),
    appBarBackground: const Color(0xFFFFFFFF),
    appBarText: const Color(0xFF111A34),
    appBarIcon: const Color(0xFF111A34),
    statusBarBackground: const Color(0x00FFFFFF),
    statusBarText: const Color(0xFF000000),
    toastBackground: const Color(0xCC111A34),
    toastText: const Color(0xFFFFFFFF),
    dialogBackground: const Color(0xFFFFFFFF),
    dialogTitle: const Color(0xFF111A34),
    dialogContent: const Color(0xFF555C72),
    switchActive: const Color(0xFFFFD91A),
    switchInactive: const Color(0xFFE2E4EA),
    switchThumb: const Color(0xFFFFFFFF),
    sliderActive: const Color(0xFFFF475D),
    sliderInactive: const Color(0x66FF475D),
    sliderThumb: const Color(0xFFFFD91A),
    progressBar: const Color(0xFFFFD91A),
    progressBarBackground: const Color(0xFFE2E4EA),
    bottomNavBackground: const Color(0xFFFFFFFF),
    bottomNavSelected: const Color(0xFFFFD91A),
    bottomNavUnselected: const Color(0xFF858B9C),
  );
}
