import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    this.icon,
    this.prompt,
    this.button,
  });

  ///图标
  final Widget? icon;

  /// 提示
  final String? prompt;

  /// 按钮
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon ?? Image(image: context.image.ic_empty, width: 80, height: 80),
        const SizedBox(height: 12),
        Text(
          prompt ?? '空空如也',
          style: TextStyle(
            color: context.color.secondaryText,
            fontSize: context.dimen.textNormal,
          ),
          textAlign: TextAlign.center,
        ),
        button ?? const SizedBox.shrink(),
      ],
    );
  }
}
