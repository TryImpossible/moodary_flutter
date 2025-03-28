import 'package:flutter/material.dart';
import 'package:moodary_flutter/core/router/app_router.dart';
import 'package:moodary_flutter/features/settings/presentation/settings/settings_screen.dart';

import 'route_name.dart';

abstract class RouteTable {
  static List<AppRoute> get routes => _routes;
  static final List<AppRoute> _routes = <AppRoute>[
    AppRoute(
      path: RouteName.settings.path,
      name: RouteName.settings.name,
      pageBuilder: (_, AppRouterState state) {
        return const _TransitionPage(child: SettingsScreen());
      },
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
