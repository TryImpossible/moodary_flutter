import 'dart:async';

import 'package:flutter/material.dart';

typedef OverlayViewBuilder<T extends AppOverlayBuilder<T>> = Widget Function(
    T builder);

abstract class AppOverlayBuilder<T extends AppOverlayBuilder<T>> {
  AppOverlayBuilder.of(BuildContext context) : _context = context;

  BuildContext get context => _context;
  final BuildContext _context;

  bool get barrierDismissible => _barrierDismissible;
  bool _barrierDismissible = true;

  T setBarrierDismissible(bool barrierDismissible) {
    _barrierDismissible = barrierDismissible;
    return this as T;
  }

  Color get barrierColor => _barrierColor;
  Color _barrierColor = Colors.black.withOpacity(0.4);

  T setBarrierColor(Color barrierColor) {
    _barrierColor = barrierColor;
    return this as T;
  }

  Duration get duration => _duration;
  Duration _duration = kThemeAnimationDuration;

  T setDuration(int duration) {
    _duration = Duration(milliseconds: duration);
    return this as T;
  }

  VoidCallback? get onShowCompleted => _onShowCompleted;
  VoidCallback? _onShowCompleted;

  T setOnShowCompleted(VoidCallback onShowCompleted) {
    _onShowCompleted = onShowCompleted;
    return this as T;
  }

  VoidCallback? get onDismissCompleted => _onDismissCompleted;
  VoidCallback? _onDismissCompleted;

  T setOnDismissCompleted(VoidCallback onDismissCompleted) {
    _onDismissCompleted = onDismissCompleted;
    return this as T;
  }

  ValueGetter<bool> get onWillPop => _onWillPop;
  ValueGetter<bool> _onWillPop = () => true;

  T setOnWillPop(ValueGetter<bool> onWillPop) {
    _onWillPop = onWillPop;
    return this as T;
  }

  OverlayViewBuilder<T> get viewBuilder => _viewBuilder;
  OverlayViewBuilder<T> _viewBuilder =
      (T builder) => throw Exception("call setViewBuilder first");

  T create(OverlayViewBuilder<T> builder) {
    _viewBuilder = builder;
    return this as T;
  }

  bool get isShowing => _isShowing;
  bool _isShowing = false;

  Future<void> show() async {
    _isShowing = true;
    await doShowAction();
    onShowCompleted?.call();
  }

  @protected
  Future<void> doShowAction() async {
    await showDialog(
      context: _context,
      barrierLabel: runtimeType.toString(),
      // 是否点击背景关闭
      barrierDismissible: false,
      // 背景的颜色
      barrierColor: barrierColor,
      // 构建视图
      builder: (BuildContext context) {
        return _viewBuilder(this as T);
      },
    );
  }

  Future<void> dismiss() async {
    final Completer<void> completer = Completer();

    /// 先隐藏键盘
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _isShowing = false;
      doDismissAction();
      _onDismissCompleted?.call();
      completer.complete();
    });
    return completer.future;
  }

  @protected
  void doDismissAction() {
    /// 再关闭浮层
    Navigator.of(_context).pop();
  }
}

abstract class AppOverlay<T extends AppOverlayBuilder<T>>
    extends StatelessWidget {
  const AppOverlay({super.key, required this.builder});

  final T builder;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        // 当Route弹出时会触发此回调
        // 当调用`Navigator.of(_context).pop()`弹出时，didPop为true
        // 当通过手势侧滑弹出时，didPop为false，再根据`builder._onWillPop()`判断是否允许弹出
        if (!didPop && builder._onWillPop()) {
          builder.dismiss();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (builder._barrierDismissible) {
            builder.dismiss();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: buildChild(context),
      ),
    );
  }

  Widget buildChild(BuildContext context);
}
