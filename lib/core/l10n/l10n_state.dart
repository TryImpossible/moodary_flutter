import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:ui';

part 'l10n_state.freezed.dart';

extension LocalExt on Locale {
  String toLanguageText() {
    return switch (this) {
      const Locale.fromSubtags(languageCode: 'en') => 'English',
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans') =>
        '简体中文',
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant') =>
        '繁體中文',
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
