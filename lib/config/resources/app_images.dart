import 'package:flutter/material.dart' show AssetImage;

// ignore_for_file: non_constant_identifier_names
class AppImages {
  AppImages({
    this.ic_unchecked = const AssetImage('assets/images/ui/ic_unchecked.png'),
    this.ic_checked = const AssetImage('assets/images/ui/ic_checked.png'),
    this.ic_empty = const AssetImage('assets/images/ui/ic_empty.png'),
    this.ic_nav_back = const AssetImage('assets/images/ui/ic_nav_back.png'),
    this.ic_nav_close = const AssetImage('assets/images/ui/ic_nav_close.png'),
    this.ic_overlay_close =
        const AssetImage('assets/images/ui/ic_overlay_close.png'),
    this.ic_eye_open = const AssetImage('assets/images/ui/ic_eye_open.png'),
    this.ic_eye_close = const AssetImage('assets/images/ui/ic_eye_close.png'),
    this.ic_clear = const AssetImage('assets/images/ui/ic_clear.png'),
  });

  final AssetImage ic_unchecked;
  final AssetImage ic_checked;
  final AssetImage ic_empty;
  final AssetImage ic_nav_back;
  final AssetImage ic_nav_close;
  final AssetImage ic_overlay_close;
  final AssetImage ic_eye_open;
  final AssetImage ic_eye_close;
  final AssetImage ic_clear;
}

final AppImages defaultAppImages = AppImages();
