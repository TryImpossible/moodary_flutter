import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    super.key,
    required this.child,
  });

  final Widget? child;

  /// 显示Loading
  static Future<void> show({
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    return EasyLoading.show(
      status: status,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }

  /// 隐藏Loading
  static Future<void> dismiss({bool animation = true}) {
    return EasyLoading.dismiss(animation: animation);
  }

  @override
  Widget build(BuildContext context) {
    _configEasyLoading(context);
    return EasyLoading.init()(context, child);
  }

  /// 设置EasyLoading
  void _configEasyLoading(BuildContext context) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..maskType = EasyLoadingMaskType.none
      ..toastPosition = EasyLoadingToastPosition.center
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..textAlign = TextAlign.center
      ..contentPadding = const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      )
      ..indicatorSize = 30.0
      ..lineWidth = 2
      ..radius = 8.0
      ..fontSize = 14
      ..displayDuration = const Duration(milliseconds: 1500)
      ..textColor = context.color.toastText
      ..indicatorColor = context.color.toastText
      ..progressColor = context.color.toastBackground
      ..backgroundColor = context.color.toastBackground
      ..boxShadow = <BoxShadow>[BoxShadow(color: context.color.transparent)]
      ..maskColor = Colors.transparent
      ..userInteractions = false
      ..dismissOnTap = false;
    // ..indicatorWidget = const SizedBox(
    //   width: 40,
    //   height: 40,
    //   child: SpinKitRing(color: Colors.white, size: 30, lineWidth: 2),
    // );
  }
}
