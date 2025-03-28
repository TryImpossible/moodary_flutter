part of 'app_router.dart';

typedef AppRouterWidgetBuilder = Widget Function(
  BuildContext context,
  AppRouterState state,
);

typedef AppRouterPageBuilder = Page<dynamic> Function(
  BuildContext context,
  AppRouterState state,
);

typedef AppRouterRedirect = FutureOr<String?> Function(
  BuildContext context,
  AppRouterState state,
);

class AppRouterState {
  static AppRouterState of(BuildContext context) {
    return AppRouterState._fromGoRouterState(GoRouterState.of(context));
  }

  AppRouterState._fromGoRouterState(GoRouterState state)
      : uri = state.uri,
        matchedLocation = state.matchedLocation,
        name = state.name,
        path = state.path,
        fullPath = state.fullPath,
        pathParameters = state.pathParameters,
        extra = state.extra;

  const AppRouterState({
    required this.uri,
    required this.matchedLocation,
    this.name,
    this.path,
    this.fullPath,
    required this.pathParameters,
    this.extra,
  });

  final Uri uri;
  final String matchedLocation;
  final String? name;
  final String? path;
  final String? fullPath;
  final Map<String, String> pathParameters;
  final Object? extra;
}

class AppRoute {
  final String path;
  final String? name;
  final AppRouterWidgetBuilder? builder;
  final AppRouterPageBuilder? pageBuilder;
  final AppRouterRedirect? redirect;
  final List<AppRoute> routes;

  const AppRoute({
    required this.path,
    this.name,
    this.builder,
    this.pageBuilder,
    this.redirect,
    this.routes = const <AppRoute>[],
  });

  GoRoute _toGoRoute() {
    return GoRoute(
      path: path,
      name: name,
      builder: builder == null
          ? null
          : (BuildContext context, GoRouterState state) {
              return builder!(
                context,
                AppRouterState._fromGoRouterState(state),
              );
            },
      pageBuilder: pageBuilder == null
          ? null
          : (BuildContext context, GoRouterState state) {
              return pageBuilder!(
                context,
                AppRouterState._fromGoRouterState(state),
              );
            },
      redirect: redirect == null
          ? null
          : (BuildContext context, GoRouterState state) {
              return redirect?.call(
                context,
                AppRouterState._fromGoRouterState(state),
              );
            },
      routes: routes.map((AppRoute r) => r._toGoRoute()).toList(),
    );
  }
}
