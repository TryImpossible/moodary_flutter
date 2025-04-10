import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../button/app_action_buttons.dart';
import './app_overlay.dart';

enum AppPopOverlayAnimation { opacity, zoomOut, zoomIn }

class AppPopOverlayBuilder<T>
    extends AppOverlayBuilder<AppPopOverlayBuilder<T>> {
  AppPopOverlayBuilder.of(super.context) : super.of();

  AppPopOverlayAnimation get animationType => _animationType;
  AppPopOverlayAnimation _animationType = AppPopOverlayAnimation.opacity;

  T setAnimation(AppPopOverlayAnimation type) {
    _animationType = type;
    return this as T;
  }

  EdgeInsets? _containerMargin;

  T setContainerMargin(EdgeInsets margin) {
    _containerMargin = margin;
    return this as T;
  }

  Color? _containerBackgroundColor;

  T setContainerBackgroundColor(Color color) {
    _containerBackgroundColor = color;
    return this as T;
  }

  BorderRadius? _containerBorderRadius;

  T setContainerBorderRadius(BorderRadius borderRadius) {
    _containerBorderRadius = borderRadius;
    return this as T;
  }

  bool? _closeVisible;

  T setCloseVisible(bool closeVisible) {
    _closeVisible = closeVisible;
    return this as T;
  }

  VoidCallback? _onClosePressed;

  T setOnClosePressed(VoidCallback onClosePressed) {
    _onClosePressed = onClosePressed;
    return this as T;
  }

  @override
  Future<void> doShowAction() async {
    await showGeneralDialog<void>(
      context: context,
      barrierLabel: runtimeType.toString(),
      // 是否点击背景关闭
      barrierDismissible: false,
      // 转场动画时长
      transitionDuration: duration,
      // 背景的颜色
      barrierColor: barrierColor,
      // 转场动画
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        child = FadeTransition(
          opacity: animation,
          child: child,
        );

        if (_animationType == AppPopOverlayAnimation.zoomIn) {
          child = ScaleTransition(
            scale: animation
                .drive(CurveTween(curve: Curves.decelerate))
                .drive(Tween<double>(begin: 0.3, end: 1.0)),
            child: child,
          );
        }
        if (_animationType == AppPopOverlayAnimation.zoomOut) {
          child = ScaleTransition(
            scale: animation
                .drive(CurveTween(curve: Curves.decelerate))
                .drive(Tween<double>(begin: 1.3, end: 1.0)),
            child: child,
          );
        }
        return child;
      },
      // 视图构建
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: Duration.zero,
          child: AppPopOverlay<T>(builder: this),
        );
      },
    );
    onShowCompleted?.call();
  }
}

class AppPopOverlay<T> extends AppOverlay<AppPopOverlayBuilder<T>> {
  const AppPopOverlay({super.key, required super.builder});

  @override
  Widget buildChild(BuildContext context) {
    Widget current = builder.viewBuilder(builder);
    if (builder._closeVisible ?? true) {
      current = Stack(
        children: <Widget>[
          current,
          Positioned(
            top: 6,
            right: 6,
            child: AppOverlayCloseButton(onPressed: _onCloseButtonPress),
          ),
        ],
      );
    }
    current = Container(
      margin: builder._containerMargin ??
          const EdgeInsets.symmetric(horizontal: 16),
      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: BoxDecoration(
        color:
            builder._containerBackgroundColor ?? context.color.dialogBackground,
        borderRadius:
            builder._containerBorderRadius ?? BorderRadius.circular(16),
      ),
      child: current,
    );
    current = Center(
      child: GestureDetector(
        onTap: () => {},
        child: current,
      ),
    );
    return current;
  }

  void _onCloseButtonPress() async {
    await builder.dismiss();
    builder._onClosePressed?.call();
  }
}
