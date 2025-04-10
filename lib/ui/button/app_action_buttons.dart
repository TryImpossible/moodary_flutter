import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../image/app_asset_image.dart';
import 'app_icon_button.dart';

abstract class _AppActionButton extends StatelessWidget {
  const _AppActionButton({
    super.key,
    this.icon,
    this.size,
    this.color,
    this.onPressed,
  });

  final AssetImage? icon;
  final Size? size;
  final Color? color;
  final VoidCallback? onPressed;

  void _onPressed(BuildContext context);

  AssetImage getUsingIcon(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      width: 44,
      height: 44,
      onTap: onPressed ?? () => _onPressed(context),
      child: AppAssetImage(
        getUsingIcon(context),
        color: color,
        width: size?.width ?? 20,
        height: size?.height ?? 20,
        fit: BoxFit.contain,
      ),
    );
  }
}

class AppBackButton extends _AppActionButton {
  const AppBackButton({
    super.key,
    super.size,
    super.color,
    super.onPressed,
  });

  /// 默认的返回处理器
  static void Function(BuildContext context) defaultBackHandler =
      (BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Navigator.defaultRouteName,
        (_) => false,
      );
    }
  };

  @override
  void _onPressed(BuildContext context) => defaultBackHandler(context);

  @override
  AssetImage getUsingIcon(BuildContext context) {
    return context.image.ic_nav_back;
  }
}

class AppCloseButton extends _AppActionButton {
  AppCloseButton({
    super.key,
    super.size,
    super.color,
    super.onPressed,
  });

  @override
  void _onPressed(BuildContext context) =>
      AppBackButton.defaultBackHandler(context);

  @override
  AssetImage getUsingIcon(BuildContext context) {
    return context.image.ic_nav_close;
  }
}

class AppOverlayCloseButton extends _AppActionButton {
  const AppOverlayCloseButton({
    super.key,
    super.size,
    super.color,
    super.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      width: 44,
      height: 44,
      onTap: onPressed,
      child: AppAssetImage(
        getUsingIcon(context),
        color: color,
        width: size?.width ?? 30,
        height: size?.height ?? 30,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  void _onPressed(BuildContext context) {}

  @override
  AssetImage getUsingIcon(BuildContext context) {
    return context.image.ic_overlay_close;
  }
}
