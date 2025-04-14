import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../image/app_asset_image.dart';
import 'app_icon_button.dart';

abstract class _AppActionButton extends StatelessWidget {
  const _AppActionButton({
    super.key,
    this.width,
    this.height,
    this.onPressed,
  });

  final double? width;
  final double? height;
  final VoidCallback? onPressed;

  Size get _getSize => const Size(44, 44);

  void _onPressed(BuildContext context);

  Widget _getIcon(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      width: _getSize.width,
      height: _getSize.height,
      onTap: onPressed ?? () => _onPressed(context),
      child: _getIcon(context),
    );
  }
}

class AppBackButton extends _AppActionButton {
  const AppBackButton({
    super.key,
    super.width,
    super.height,
    super.onPressed,
    this.color,
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

  final Color? color;

  @override
  Widget _getIcon(BuildContext context) {
    return AppAssetImage(
      context.image.ic_nav_back,
      color: color,
      width: width ?? 20,
      height: height ?? 20,
      fit: BoxFit.contain,
    );
  }

  @override
  void _onPressed(BuildContext context) => defaultBackHandler(context);
}

class AppCloseButton extends _AppActionButton {
  const AppCloseButton({
    super.key,
    super.width,
    super.height,
    super.onPressed,
    this.color,
  });

  final Color? color;

  @override
  Widget _getIcon(BuildContext context) {
    return AppAssetImage(
      context.image.ic_nav_close,
      color: color,
      width: width ?? 20,
      height: height ?? 20,
      fit: BoxFit.contain,
    );
  }

  @override
  void _onPressed(BuildContext context) =>
      AppBackButton.defaultBackHandler(context);
}

class AppOverlayCloseButton extends _AppActionButton {
  const AppOverlayCloseButton({
    super.key,
    super.width,
    super.height,
    super.onPressed,
    this.color,
  });

  final Color? color;

  @override
  Widget _getIcon(BuildContext context) {
    return AppAssetImage(
      context.image.ic_overlay_close,
      color: color,
      width: width ?? 30,
      height: height ?? 30,
      fit: BoxFit.contain,
    );
  }

  @override
  void _onPressed(BuildContext context) {}
}
