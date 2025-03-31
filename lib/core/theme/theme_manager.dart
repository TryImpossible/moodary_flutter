import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moodary_flutter/core/storages/app_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_state.dart';

part 'theme_manager.g.dart';

@riverpod
class ThemeManager extends _$ThemeManager with WidgetsBindingObserver {
  @override
  ThemeState build() {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
    });

    final bool isFollowSystem =
        AppStorage.sharedPrefs.readBool('theme_is_follow_system') ?? false;
    return ThemeState(
      isFollowSystem: isFollowSystem,
      style: _getThemeStyle(isFollowSystem),
      supportedStyles: ThemeStyle.values,
    );
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (state.isFollowSystem) {
      state = state.copyWith(style: ThemeStyle.fromBrightness(_brightness));
    }
  }

  Brightness get _brightness => PlatformDispatcher.instance.platformBrightness;

  ThemeStyle _getThemeStyle(bool isFollowSystem) {
    if (isFollowSystem) {
      return ThemeStyle.fromBrightness(_brightness);
    } else {
      final String? name =
          AppStorage.sharedPrefs.readString('theme_selected_theme');
      return ThemeStyle.fromString(name);
    }
  }

  Future<void> followSystem(bool value) async {
    state = state.copyWith(
      isFollowSystem: value,
      style: _getThemeStyle(value),
    );
    await AppStorage.sharedPrefs.writeBool('theme_is_follow_system', value);
  }

  Future<void> changeTheme(ThemeStyle style) async {
    state = state.copyWith(style: style, isFollowSystem: false);
    await Future.wait([
      AppStorage.sharedPrefs.writeString('theme_selected_theme', style.name),
      AppStorage.sharedPrefs.writeBool('theme_is_follow_system', false),
    ]);
  }
}
