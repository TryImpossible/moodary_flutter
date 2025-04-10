import 'package:flutter/widgets.dart';

class AppTouchableOpacity extends StatefulWidget {
  const AppTouchableOpacity({
    super.key,
    this.enabled = true,
    this.activeOpacity = 0.6,
    this.debounceInterval = 300,
    required this.child,
    this.behavior = HitTestBehavior.opaque,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  /// 启用组件交互，默认true
  final bool enabled;

  /// 触摸操作激活时以多少不透明度显示，默认0.6
  final double activeOpacity;

  /// 点击防抖间隔时间
  final int debounceInterval;

  /// 命中行为
  final HitTestBehavior? behavior;

  /// 内容
  final Widget child;

  /// 点击回调
  final GestureTapCallback? onTap;

  /// 长按回调
  final GestureTapCallback? onLongPress;

  /// 按下回调
  final GestureTapDownCallback? onTapDown;

  /// 抬起回调
  final GestureTapUpCallback? onTapUp;

  /// 按下取消回调
  final VoidCallback? onTapCancel;

  @override
  State<StatefulWidget> createState() => _AppButtonPressedStatusState();
}

class _AppButtonPressedStatusState extends State<AppTouchableOpacity>
    with SingleTickerProviderStateMixin {
  int _timestamp = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: widget.activeOpacity,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget current = GestureDetector(
      behavior: widget.behavior,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: widget.onTap,
      onTapCancel: onTapCancel,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(opacity: _controller, child: child);
        },
        child: widget.child,
      ),
    );
    current = IgnorePointer(ignoring: !widget.enabled, child: current);
    return current;
  }

  /// 按下事件
  void onTapDown(TapDownDetails details) {
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    if (_timestamp == 0 ||
        currentTimestamp - _timestamp > widget.debounceInterval) {
      _timestamp = currentTimestamp;
      if (widget.activeOpacity != 1.0) {
        _controller.reverse();
      }
      widget.onTapDown?.call(details);
    }
  }

  /// 抬起事件
  void onTapUp(TapUpDetails details) {
    if (widget.activeOpacity != 1.0) {
      _controller.forward();
    }
    widget.onTapUp?.call(details);
  }

  /// 关闭事件
  void onTapCancel() {
    if (widget.activeOpacity != 1.0) {
      _controller.forward();
    }
    widget.onTapCancel?.call();
  }
}
