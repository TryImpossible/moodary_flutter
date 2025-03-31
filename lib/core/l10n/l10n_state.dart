import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'l10n_state.freezed.dart';

@freezed
class L10nState with _$L10nState {
  const factory L10nState({
    required bool isFollowSystem,
    required Locale? locale,
    required List<Locale> supportedLocales,
  }) = _L10nState;
}
