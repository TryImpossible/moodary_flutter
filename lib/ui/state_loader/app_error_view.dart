import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import '../app_touchable_opacity.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    this.prompt,
    this.onRetry,
  });

  /// 提示
  final String? prompt;

  /// 重试
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AppTouchableOpacity(
      onTap: onRetry,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: context.color.secondaryText,
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            prompt ?? '加载失败\n点击空白处刷新 ~',
            style: TextStyle(
              color: context.color.secondaryText,
              fontSize: context.dimen.textNormal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
