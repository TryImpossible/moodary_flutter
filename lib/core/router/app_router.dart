import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_route.dart';

class AppRouter {
  static AppRouter? _instance;

  factory AppRouter.getDefault() => _instance ??= AppRouter();

  AppRouter();

  RouterConfig<Object> get routerConfig => _router;

  GoRouter get _router {
    if (_goRouter == null) {
      final List<RouteBase> routes =
          _routes.map((AppRoute route) => route._toGoRoute()).toList();
      _goRouter = GoRouter(
        routes: routes,
        onException: (
          BuildContext context,
          GoRouterState state,
          GoRouter router,
        ) {
          if (_404Route?.isNotEmpty ?? false) {
            _goRouter?.go(_404Route!, extra: state.uri.toString());
          }
        },
        redirect: _redirect == null
            ? null
            : (BuildContext context, GoRouterState state) {
                return _redirect!(
                  context,
                  AppRouterState._fromGoRouterState(state),
                );
              },
        refreshListenable: _refreshListenable,
        initialLocation: _initialRoute,
        observers: _observers,
        navigatorKey: _navigatorKey,
      );
    }
    return _goRouter!;
  }

  GoRouter? _goRouter;

  final List<AppRoute> _routes = <AppRoute>[];

  AppRouter registerRoute(AppRoute route) {
    return registerRoutes(<AppRoute>[route]);
  }

  AppRouter registerRoutes(List<AppRoute> routes) {
    _routes.addAll(routes);
    return this;
  }

  AppRouterRedirect? _redirect;

  AppRouter setRouterRedirect(AppRouterRedirect redirect) {
    _redirect = redirect;
    return this;
  }

  Listenable? _refreshListenable;

  AppRouter setRefreshListenable(Listenable refreshListenable) {
    _refreshListenable = refreshListenable;
    return this;
  }

  List<NavigatorObserver>? _observers;

  AppRouter addObserver(NavigatorObserver observer) {
    addObservers(<NavigatorObserver>[observer]);
    return this;
  }

  AppRouter addObservers(List<NavigatorObserver> observers) {
    if (observers.isEmpty) {
      return this;
    }
    _observers ??= <NavigatorObserver>[];
    _observers?.addAll(observers);
    return this;
  }

  String? _initialRoute;

  AppRouter setInitialRoute(String initialRoute) {
    _initialRoute = initialRoute;
    return this;
  }

  String? _404Route;

  AppRouter set404Route(String notFoundRoute) {
    _404Route = notFoundRoute;
    return this;
  }

  GlobalKey<NavigatorState>? _navigatorKey;

  AppRouter setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
    return this;
  }

  void go(String location, {Object? extra}) {
    _router.go(location, extra: extra);
  }

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    _router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<T?> push<T extends Object?>(
    String location, {
    Object? extra,
  }) {
    return _router.push<T>(location, extra: extra);
  }

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return push<T>(
      _router.namedLocation(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      ),
      extra: extra,
    );
  }

  Future<T?> pushReplacement<T extends Object?>(
    String location, {
    Object? extra,
  }) {
    return _router.pushReplacement<T>(location, extra: extra);
  }

  Future<T?> pushReplacementNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return pushReplacement<T>(
      _router.namedLocation(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      ),
      extra: extra,
    );
  }

  Future<T?> replace<T>(String location, {Object? extra}) {
    return _router.replace<T>(location, extra: extra);
  }

  Future<T?> replaceNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return replace(
      _router.namedLocation(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      ),
      extra: extra,
    );
  }

  bool canPop() {
    return _router.canPop();
  }

  void pop<T extends Object?>([T? result]) {
    _router.pop<T>(result);
  }

  void refresh() {
    _router.refresh();
  }

  void dispose() {
    return _router.dispose();
  }
}
