import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

/// 指示器宽度模式
enum AppCarouselIndicatorMode {
  /// 自动，根据总宽度和数量计算占比
  auto,

  /// 固定，指定的宽度
  fixed,
}

class AppCarouselIndicator extends StatelessWidget {
  const AppCarouselIndicator({
    super.key,
    required this.mode,
    required this.itemCount,
    this.activeIndex = 0,
    this.color,
    this.activeColor,
    this.radius = 2.5,
    this.itemSize,
    this.itemSpace,
    this.size,
  });

  const AppCarouselIndicator.auto({
    super.key,
    required this.itemCount,
    this.activeIndex = 0,
    this.color,
    this.activeColor,
    this.radius = 2.5,
    this.itemSize,
    this.itemSpace,
  })  : size = null,
        mode = AppCarouselIndicatorMode.auto;

  const AppCarouselIndicator.fixed({
    super.key,
    required this.itemCount,
    this.activeIndex = 0,
    this.color,
    this.activeColor,
    this.radius = 2.5,
    this.size,
  })  : itemSize = null,
        itemSpace = null,
        mode = AppCarouselIndicatorMode.fixed;

  final AppCarouselIndicatorMode mode;

  final int itemCount;
  final int activeIndex;

  final Color? color;
  final Color? activeColor;

  final double radius;

  final Size? itemSize;
  final double? itemSpace;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    if (<int>[0, 1].contains(itemCount)) {
      return const SizedBox.shrink();
    }
    return switch (mode) {
      AppCarouselIndicatorMode.fixed => _buildFixedModeWidget(context),
      AppCarouselIndicatorMode.auto => _buildAutoModeWidget(context),
    };
  }

  Widget _buildFixedModeWidget(BuildContext context) {
    final Size itemSize = this.itemSize ?? const Size(32, 6);
    final double itemSpace = this.itemSpace ?? 8;
    Widget buildItem({required Color color}) {
      return Container(
        width: itemSize.width,
        height: itemSize.height,
        margin: EdgeInsets.symmetric(horizontal: itemSpace),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(itemCount, (int index) {
            return buildItem(color: color ?? context.color.border);
          }),
        ),
        AnimatedPositionedDirectional(
          start: 0 + activeIndex * (itemSize.width + itemSpace * 2),
          curve: Curves.decelerate,
          duration: kThemeAnimationDuration,
          child: buildItem(color: activeColor ?? context.color.primary),
        )
      ],
    );
  }

  Widget _buildAutoModeWidget(BuildContext context) {
    final Size size = this.size ?? const Size(32, 6);
    final double itemWidth = size.width / itemCount;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: color ?? context.color.border,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        AnimatedPositionedDirectional(
          start: activeIndex * itemWidth,
          curve: Curves.decelerate,
          duration: kThemeAnimationDuration,
          child: Container(
            width: itemWidth,
            height: size.height,
            decoration: BoxDecoration(
              color: activeColor ?? context.color.primary,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
          ),
        )
      ],
    );
  }
}
