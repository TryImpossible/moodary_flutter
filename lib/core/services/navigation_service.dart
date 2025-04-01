import 'package:moodary_flutter/config/routes/app_route_name.dart';
import 'package:moodary_flutter/core/router/app_router.dart';

abstract class NavigationService {
  final AppRouter _appRouter = AppRouter.getDefault();

  Future<void> goThemeSettings();

  Future<void> goLangeSettings();
}

class _NavigationServiceImpl extends NavigationService {
  @override
  Future<void> goLangeSettings() async {
    return _appRouter.goNamed(AppRouteName.languageSettings.name);
  }

  @override
  Future<void> goThemeSettings() async {
    return _appRouter.pushNamed<void>(AppRouteName.themeSettings.name);
  }
}

final NavigationService defaultNavigationService = _NavigationServiceImpl();