import 'dart:ui';

import 'package:moodary_flutter/config/l10n/l10n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'l10n_state.dart';

part 'l10n_manager.g.dart';


@riverpod
class L10nManager extends _$L10nManager {
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
