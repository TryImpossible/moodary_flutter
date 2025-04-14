import 'package:flutter/cupertino.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CupertinoActivityIndicator(radius: 15),
        const SizedBox(height: 16),
        Text(
          '正在加载...',
          style: TextStyle(
            color: context.color.secondaryText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
