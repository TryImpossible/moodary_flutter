import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import 'app_touchable_opacity.dart';
import 'button/app_action_buttons.dart';
import 'button/app_icon_button.dart';

class AppNavBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavBar({
    super.key,
    this.backIcon,
    this.backIconColor,
    this.backIconSize,
    this.onBackPressed,
    this.leading,
    this.titleText,
    this.titleTextStyle,
    this.title,
    this.menuText,
    this.menuTextStyle,
    this.menuIcon,
    this.menuIconColor,
    this.menuIconSize,
    this.onMenuPressed,
    this.trailing,
    this.showLeading = true,
    this.titleSpacing,
    this.toolbarHeight = 44,
    this.leadingWidth = 44,
    this.bottom,
    this.showDivider = false,
    this.backgroundColor,
    this.elevation,
    this.centerTitle = true,
    this.systemOverlayStyle,
  });

  /// 左侧
  final AssetImage? backIcon;
  final Color? backIconColor;
  final Size? backIconSize;
  final VoidCallback? onBackPressed;
  final Widget? leading;

  /// 中间
  final String? titleText;
  final TextStyle? titleTextStyle;
  final Widget? title;

  /// 右侧
  final String? menuText;
  final TextStyle? menuTextStyle;
  final AssetImage? menuIcon;
  final Color? menuIconColor;
  final Size? menuIconSize;
  final VoidCallback? onMenuPressed;
  final List<Widget>? trailing;

  final bool showLeading;
  final double? titleSpacing;
  final double toolbarHeight;
  final double leadingWidth;
  final PreferredSizeWidget? bottom;
  final bool showDivider;
  final Color? backgroundColor;
  final double? elevation;
  final bool? centerTitle;

  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? context.color.background,
      leading: _buildLeading(context),
      titleSpacing: titleSpacing,
      title: _buildTitle(context),
      actions: _buildTrailing(context),
      elevation: elevation ?? (showDivider ? 0.3 : 0),
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (!showLeading) {
      return null;
    }
    if (leading != null) {
      return leading;
    }
    if (backIcon != null) {
      return AppIconButton(
        width: backIconSize?.width ?? 0,
        height: backIconSize?.height ?? 0,
        icon: backIcon,
        color: backIconColor,
        onTap: onBackPressed ?? () => AppBackButton.defaultBackHandler(context),
      );
    }
    return AppBackButton(
      width: backIconSize?.width ?? 0,
      height: backIconSize?.height ?? 0,
      color: backIconColor,
      onPressed: onBackPressed,
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (title != null) {
      return title;
    }
    return Visibility(
      visible: titleText?.isNotEmpty ?? false,
      child: Text(
        titleText ?? '',
        style: titleTextStyle ??
            TextStyle(
              fontSize: context.dimen.textBig,
              color: context.color.primaryText,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  List<Widget>? _buildTrailing(BuildContext context) {
    if (trailing != null && trailing!.isNotEmpty) {
      return trailing;
    }
    if (menuIcon != null) {
      return <Widget>[
        AppTouchableOpacity(
          behavior: HitTestBehavior.opaque,
          onTap: onMenuPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: SizedBox(
              width: 44,
              height: 44,
              child: UnconstrainedBox(
                child: Image(
                  image: menuIcon!,
                  width: menuIconSize?.width ?? 20,
                  height: menuIconSize?.height ?? 20,
                ),
              ),
            ),
          ),
        ),
      ];
    }
    if (menuText?.isNotEmpty ?? false) {
      return <Widget>[
        AppTouchableOpacity(
          onTap: onMenuPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Center(
              child: Text(
                menuText!,
                style: menuTextStyle ??
                    TextStyle(
                      color: context.color.primaryText,
                      fontSize: context.dimen.textNormal,
                    ),
              ),
            ),
          ),
        ),
      ];
    }
    return null;
  }
}
