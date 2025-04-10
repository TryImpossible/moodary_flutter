import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../button/app_action_buttons.dart';
import './app_overlay.dart';

enum AppPullOverlayAnimation {
  left,
  top,
  right,
  bottom,
  topLeft;

  Alignment get alignment => switch (this) {
        left => Alignment.centerLeft,
        top => Alignment.topCenter,
        right => Alignment.centerRight,
        bottom => Alignment.bottomCenter,
        topLeft => Alignment.topLeft,
      };
}

class AppPullOverlayBuilder<T>
    extends AppOverlayBuilder<AppPullOverlayBuilder<T>> {
  AppPullOverlayBuilder.of(super.context) : super.of();

  AppPullOverlayAnimation get animationType => _animationType;
  AppPullOverlayAnimation _animationType = AppPullOverlayAnimation.bottom;

  T setAnimation(AppPullOverlayAnimation type) {
    _animationType = type;
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

  Future<void> _showGeneralDialog() {
    return showGeneralDialog<void>(
      context: context,
      barrierLabel: runtimeType.toString(),
      // 是否点击背景关闭
      barrierDismissible: false,
      // 转场动画时长
      transitionDuration: duration,
      // 背景的颜色
      barrierColor: barrierColor,
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        animation = animation.drive(CurveTween(curve: Curves.decelerate));
        Offset offset = Offset.zero;
        switch (_animationType) {
          case AppPullOverlayAnimation.left:
            offset = Offset(animation.value - 1, 0);
            break;
          case AppPullOverlayAnimation.top:
            offset = Offset(0, animation.value - 1);
            break;
          case AppPullOverlayAnimation.right:
            offset = Offset(0, animation.value - 1);
            break;
          case AppPullOverlayAnimation.topLeft:
            offset =
                Offset(animation.value - 1, 0) + Offset(0, animation.value - 1);
            break;
          default:
            break;
        }
        return FractionalTranslation(
          translation: offset,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return AppPullOverlay(builder: this);
      },
    );
  }

  Future<void> _showModalBottomSheet() {
    return showModalBottomSheet<void>(
      context: context,
      // 前景的颜色
      backgroundColor: Colors.transparent,
      // 阴影置为0
      elevation: 0,
      // 背景的颜色
      barrierColor: barrierColor,
      // 是否控制滚动，ture开启全屏
      isScrollControlled: true,
      // 是否点击背景关闭
      isDismissible: false,
      // 是否开启拖拽，与是否点击背景关闭
      enableDrag: barrierDismissible,
      // 构建视图
      builder: (BuildContext context) {
        return AppPullOverlay<T>(builder: this);
      },
    );
  }

  @override
  Future<void> doShowAction() async {
    if (_animationType == AppPullOverlayAnimation.bottom) {
      await _showModalBottomSheet();
    } else {
      await _showGeneralDialog();
    }
    onShowCompleted?.call();
  }
}

class AppPullOverlay<T> extends AppOverlay<AppPullOverlayBuilder<T>> {
  const AppPullOverlay({super.key, required super.builder});

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
      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: BoxDecoration(
        color:
            builder._containerBackgroundColor ?? context.color.dialogBackground,
        borderRadius: builder._containerBorderRadius ??
            const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: current,
    );
    current = Align(
      alignment: builder.animationType.alignment,
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
