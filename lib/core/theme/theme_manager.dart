import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_state.dart';

part 'theme_manager.g.dart';

@riverpod
class ThemeManager extends _$ThemeManager {
  @override
  ThemeState build() {
    return const ThemeState(
      style: ThemeStyle.light,
      supportedStyles: ThemeStyle.values,
    );
  }

  void change(ThemeStyle style) {
    state = state.copyWith(style: style);
  }
}
