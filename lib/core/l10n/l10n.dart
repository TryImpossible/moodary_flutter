import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'l10n.freezed.dart';

part 'l10n.g.dart';

extension LocalExt on Locale {
  String toLanguageText() {
    return switch (this) {
      const Locale.fromSubtags(languageCode: 'en') => 'English',
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans') => '简体中文',
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant') => '繁體中文',
      _ => 'English',
    };
  }
}

@freezed
class L10nState with _$L10nState {
  const factory L10nState({
    required Locale locale,
    required List<Locale> supportedLocales,
  }) = _L10nState;
}

@riverpod
class L10n extends _$L10n {
  @override
  L10nState build() {
    return L10nState(
      locale: const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  void change(Locale local) {
    state = state.copyWith(locale: local);
  }
}
