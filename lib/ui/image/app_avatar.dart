import 'package:flutter/material.dart';

import 'app_asset_image.dart';
import 'app_network_image.dart';

enum _AppAvatarMode {
  network,
  asset;
}

class AppAvatar extends StatelessWidget {
  const AppAvatar.network(
    String url, {
    super.key,
    required this.size,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.placeholder,
  })  : data = url,
        _mode = _AppAvatarMode.network;

  const AppAvatar.asset(
    AssetImage image, {
    super.key,
    required this.size,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.placeholder,
  })  : data = image,
        _mode = _AppAvatarMode.asset;

  final Object? data;
  final _AppAvatarMode _mode;
  final double size;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    return switch (_mode) {
      _AppAvatarMode.network => AppNetworkImage(
          data as String,
          width: size,
          height: size,
          fit: fit,
          radiusAll: size / 2,
          borderColor: borderColor,
          borderWidth: borderWidth,
          placeholder: placeholder,
        ),
      _AppAvatarMode.asset => AppAssetImage(
          data as AssetImage,
          width: size,
          height: size,
          fit: fit,
          radiusAll: size / 2,
          borderColor: borderColor,
          borderWidth: borderWidth,
          placeholder: placeholder,
        ),
    };
  }
}
