import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodary_flutter/config/resources/resources.dart';
import 'package:moodary_flutter/config/theme/app_theme_dark.dart';
import 'package:moodary_flutter/config/theme/app_theme_light.dart';
import 'package:moodary_flutter/core/theme/app_theme_colors.dart';

part 'app_theme_state.freezed.dart';

/// 主题风格
enum ThemeStyle {
  /// 浅色主题
  light,

  /// 暗色主题
  dark;

  String getString(BuildContext context) {
    return switch (this) {
      ThemeStyle.light => context.string.light,
      ThemeStyle.dark => context.string.dark,
    };
  }

  factory ThemeStyle.fromBrightness(Brightness brightness) {
    return switch (brightness) {
      Brightness.light => ThemeStyle.light,
      Brightness.dark => ThemeStyle.dark,
    };
  }

  factory ThemeStyle.fromString(String? name) {
    if (name == ThemeStyle.light.name) {
      return ThemeStyle.light;
    } else if (name == ThemeStyle.dark.name) {
      return ThemeStyle.dark;
    } else {
      return ThemeStyle.light;
    }
  }
}

final Map<ThemeStyle, ThemeData> _sharedThemes = <ThemeStyle, ThemeData>{};

@freezed
class AppThemeState with _$AppThemeState {
  const factory AppThemeState({
    required bool isFollowSystem,
    required ThemeStyle style,
    required List<ThemeStyle> supportedStyles,
  }) = _AppThemeState;

  const AppThemeState._();

  AppThemeColors get color {
    return switch (style) {
      ThemeStyle.light => AppThemeLight.color,
      ThemeStyle.dark => AppThemeDark.color,
    };
  }

  ThemeData get theme {
    if (!_sharedThemes.containsKey(style)) {
      final ThemeData themeData = ThemeData(
        extensions: <ThemeExtension<dynamic>>[color],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 16,
            color: color.inputText,
            height: 14.5 / 15,
          ),
          helperStyle: TextStyle(
            fontSize: 16,
            color: color.info,
            height: 1.2,
          ),
          hintStyle: TextStyle(
            color: color.inputHintText,
            fontSize: 16,
            height: 15.5 / 16,
          ),
          errorStyle: TextStyle(
            color: color.error,
            fontSize: 16,
            height: 15.5 / 16,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
              // horizontal: 45,
              // vertical: 36,
              ),
          isCollapsed: true,
          filled: false,
          fillColor: color.background,
          errorBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
            borderSide: BorderSide(color: color.inputErrorBorder),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
            borderSide: BorderSide(color: color.inputFocusedBorder),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
            borderSide: BorderSide(color: color.inputErrorBorder),
          ),
          disabledBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
            borderSide: BorderSide(color: color.inputDisabledText, width: 0.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
            borderSide: BorderSide(color: color.inputBorder, width: 0.5),
          ),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide(color: color.inputBorder, width: 0.5),
          //   borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          // ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        scrollbarTheme: const ScrollbarThemeData(),
        splashFactory: NoSplash.splashFactory,
        useMaterial3: true,
        canvasColor: color.background,
        cardColor: color.cardBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: color.primary),
        dialogBackgroundColor: color.dialogBackground,
        disabledColor: color.inputDisabledText,
        dividerColor: color.border,
        focusColor: color.transparent,
        highlightColor: color.transparent,
        hintColor: color.inputHintText,
        hoverColor: color.transparent,
        indicatorColor: color.primary,
        primaryColor: color.primary,
        scaffoldBackgroundColor: color.scaffoldBackground,
        shadowColor: color.transparent,
        splashColor: color.transparent,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            fontSize: 16,
            color: color.primaryText,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: color.secondaryText,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: color.appBarBackground,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: color.transparent,
          iconTheme: IconThemeData(color: color.appBarIcon),
          centerTitle: true,
          toolbarHeight: 44,
          titleTextStyle: TextStyle(
            color: color.appBarText,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 16 / 17,
          ),
          toolbarTextStyle: TextStyle(
            color: color.appBarText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: color.background,
          elevation: 0,
          height: 49,
          shadowColor: color.transparent,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: color.bottomNavBackground,
          elevation: 0,
          selectedIconTheme: IconThemeData(
            size: 22,
            color: color.bottomNavSelected,
          ),
          unselectedIconTheme: IconThemeData(
            size: 22,
            color: color.bottomNavUnselected,
          ),
          selectedItemColor: color.bottomNavSelected,
          unselectedItemColor: color.bottomNavUnselected,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            height: 10 / 11,
            color: color.bottomNavSelected,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            height: 10 / 11,
            color: color.bottomNavUnselected,
          ),
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: color.dialogBackground,
          elevation: 0,
          modalBarrierColor: color.barrierColor,
          shadowColor: color.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: color.dialogBackground,
          elevation: 0,
          shadowColor: color.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color.dialogTitle,
          ),
          contentTextStyle: TextStyle(
            fontSize: 16,
            color: color.dialogContent,
          ),
          barrierColor: color.barrierColor,
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: color.border,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(color.primary),
            elevation: WidgetStateProperty.all(0),
            minimumSize: WidgetStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        listTileTheme: ListTileThemeData(
          selectedColor: color.primary,
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: color.listTileTitle,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            color: color.listTileSubtitle,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(color.primary),
            elevation: WidgetStateProperty.all(0),
            minimumSize: WidgetStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(color.primary),
            elevation: WidgetStateProperty.all(0),
            minimumSize: WidgetStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        tabBarTheme: TabBarTheme(
          // indicator: AppUnderlineTabIndicator(
          //   borderRadius: BorderRadius.zero,
          //   borderSide: BorderSide(width: 4, color: color.primary),
          //   insets: const EdgeInsets.only(bottom: 18),
          //   width: null,
          // ),
          indicatorColor: color.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: color.primaryText,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          unselectedLabelColor: color.secondaryText,
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: color.primary,
          selectionColor: color.primary.withOpacity(0.3),
          selectionHandleColor: color.primary,
        ),
      );
      _sharedThemes[style] = themeData;
    }
    return _sharedThemes[style]!;
  }
}
