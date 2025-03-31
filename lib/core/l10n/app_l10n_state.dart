import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_l10n_state.freezed.dart';

@freezed
class AppL10nState with _$AppL10nState {
  const factory AppL10nState({
    required bool isFollowSystem,
    required Locale? locale,
    required List<Locale> supportedLocales,
  }) = _AppL10nState;
}
