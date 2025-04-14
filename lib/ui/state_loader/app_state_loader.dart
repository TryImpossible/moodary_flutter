import 'package:flutter/widgets.dart';

import 'app_empty_view.dart';
import 'app_error_view.dart';
import 'app_loading_view.dart';

enum AppLoaderStatus {
  loading,
  empty,
  error,
  success;

  bool get isLoading => this == loading;

  bool get isEmpty => this == empty;

  bool get isError => this == error;

  bool get isSuccess => this == success;
}

class AppStateLoaderController {
  AppStateLoaderController({
    AppLoaderStatus initialStatus = AppLoaderStatus.loading,
  }) : _statusNotifier = ValueNotifier<AppLoaderStatus>(initialStatus);

  AppLoaderStatus get status => _statusNotifier.value;
  final ValueNotifier<AppLoaderStatus> _statusNotifier;

  void showLoading() => _statusNotifier.value = AppLoaderStatus.loading;

  void showEmpty() => _statusNotifier.value = AppLoaderStatus.empty;

  void showError() => _statusNotifier.value = AppLoaderStatus.error;

  void showSuccess() => _statusNotifier.value = AppLoaderStatus.success;
}

class AppStateLoader extends StatelessWidget {
  const AppStateLoader({
    super.key,
    required this.controller,
    required this.child,
    this.loading,
    this.empty,
    this.error,
    this.onRetry,
  });

  final AppStateLoaderController controller;
  final Widget child;
  final Widget? loading;
  final Widget? empty;
  final Widget? error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller._statusNotifier,
      builder: (BuildContext context, AppLoaderStatus value, Widget? child) {
        return switch (value) {
          AppLoaderStatus.loading => loading ?? const AppLoadingView(),
          AppLoaderStatus.empty => empty ?? const AppEmptyView(),
          AppLoaderStatus.error => error ?? const AppErrorView(),
          AppLoaderStatus.success => child!,
        };
      },
      child: child,
    );
  }
}
