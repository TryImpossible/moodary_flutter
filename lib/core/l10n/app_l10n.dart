import 'dart:ui';

import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:moodary_flutter/core/storages/app_storage.dart';
import 'package:moodary_flutter/core/utils/locale_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_l10n_state.dart';

part 'app_l10n.g.dart';

@riverpod
class AppL10n extends _$AppL10n {
  @override
  AppL10nState build() {
    final bool isFollowSystem =
        AppStorage.sharedPrefs.readBool('l10n_is_follow_system') ?? false;
    final Locale? locale =
        _getLocale(isFollowSystem, AppLocalizations.delegate.supportedLocales);
    return AppL10nState(
      locale: locale,
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      isFollowSystem: isFollowSystem,
    );
  }

  Locale? _getLocale(bool isFollowSystem, List<Locale> supportedLocales) {
    if (isFollowSystem) {
      // 跟随系统 返回null
      return null;
    }
    Locale? locale = LocaleUtils.tryParse(
      AppStorage.sharedPrefs.readString('l10n_selected_locale'),
    );
    if (locale == null) {
      // 如果不是跟随系统并且存储的locale为空时，则读取系统的locale
      final Locale systemLocale = PlatformDispatcher.instance.locale;
      for (final Locale supportedLocale in supportedLocales) {
        if (systemLocale.languageCode == supportedLocale.languageCode) {
          return supportedLocale;
        }
      }
    }
    return locale;
  }

  Future<void> followSystem(bool value) async {
    if (value) {
      state = state.copyWith(isFollowSystem: true, locale: null);
      await AppStorage.sharedPrefs.writeBool('l10n_is_follow_system', true);
    } else {
      state = state.copyWith(
        isFollowSystem: false,
        locale: _getLocale(false, state.supportedLocales),
      );
      await AppStorage.sharedPrefs.writeBool('l10n_is_follow_system', false);
    }
  }

  Future<void> changeLocale(Locale local) async {
    state = state.copyWith(locale: local, isFollowSystem: false);
    await Future.wait([
      AppStorage.sharedPrefs.writeString('l10n_selected_locale', local.toString()),
      AppStorage.sharedPrefs.writeBool('l10n_is_follow_system', false),
    ]);
  }
}
