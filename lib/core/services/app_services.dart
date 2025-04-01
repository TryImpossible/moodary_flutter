import 'navigation_service.dart';

abstract class AppServices {
  static NavigationService get navigation =>
      _navigation ??= defaultNavigationService;
  static NavigationService? _navigation;
}
