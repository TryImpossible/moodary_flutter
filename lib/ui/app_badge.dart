import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

enum AppBadgeMode {
  /// 圆角矩形
  capsule,

  /// 圆形
  square,

  /// 小圆点
  dot,
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    this.count = 0,
    this.maxCount = 99,
    this.mode = AppBadgeMode.dot,
    required this.child,
  });

  final int count;
  final int maxCount;
  final AppBadgeMode mode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[child, _buildIndicator()],
    );
  }

  Widget _buildIndicator() {
    final String countText = (count > maxCount ? maxCount : count).toString();
    return switch (mode) {
      AppBadgeMode.dot => Visibility(
          visible: count > 0,
          child: const Positioned(
            top: 0,
            right: 0,
            child: _DotIndicator(),
          ),
        ),
      AppBadgeMode.square => Visibility(
          visible: count > 0,
          child: Positioned(
            top: 0,
            right: 0,
            child: _SquareIndicator(text: countText),
          ),
        ),
      AppBadgeMode.capsule => Visibility(
          visible: count > 0,
          child: Positioned(
            top: 0,
            right: 0,
            child: _CapsuleIndicator(text: countText),
          ),
        ),
    };
  }
}

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5,
      height: 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.color.error,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _SquareIndicator extends StatelessWidget {
  const _SquareIndicator({super.key, this.text = '0'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.color.error,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: 18,
        height: 18,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: context.color.white,
              fontSize: context.dimen.textSmaller,
            ),
          ),
        ),
      ),
    );
  }
}

class _CapsuleIndicator extends StatelessWidget {
  const _CapsuleIndicator({super.key, this.text = '0'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.color.error,
        borderRadius: BorderRadius.circular(7),
      ),
      child: SizedBox(
        width: 22,
        height: 14,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: context.color.white,
              fontSize: context.dimen.textSmaller,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
