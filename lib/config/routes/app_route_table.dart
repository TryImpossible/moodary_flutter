import 'package:flutter/material.dart';
import 'package:moodary_flutter/core/router/app_router.dart';
import 'package:moodary_flutter/features/settings/presentation/language_settings/language_settings_screen.dart';
import 'package:moodary_flutter/features/settings/presentation/settings/settings_screen.dart';
import 'package:moodary_flutter/features/settings/presentation/theme_settings/theme_settings_screen.dart';

import 'app_route_name.dart';

abstract class AppRouteTable {
  static List<AppRoute> get routes => _routes;
  static final List<AppRoute> _routes = <AppRoute>[
    AppRoute(
      path: AppRouteName.settings.path,
      name: AppRouteName.settings.name,
      pageBuilder: (_, AppRouterState state) {
        return _TransitionPage(
          name: AppRouteName.settings.name,
          child: const SettingsScreen(),
        );
      },
      routes: <AppRoute>[
        AppRoute(
          path: AppRouteName.themeSettings.path,
          name: AppRouteName.themeSettings.name,
          pageBuilder: (_, AppRouterState state) {
            return _TransitionPage(
              name: AppRouteName.themeSettings.name,
              child: const ThemeSettingsScreen(),
            );
          },
        ),
        AppRoute(
          path: AppRouteName.languageSettings.path,
          name: AppRouteName.languageSettings.name,
          pageBuilder: (_, AppRouterState state) {
            return _TransitionPage(
              name: AppRouteName.languageSettings.name,
              child: const LanguageSettingsScreen(),
            );
          },
        ),
      ],
    ),
  ];
}

class _TransitionPage<T> extends MaterialPage<T> {
  const _TransitionPage({
    required super.child,
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.allowSnapshotting = true,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });
}
