import 'package:flutter_easyloading/flutter_easyloading.dart';

typedef AppToastPosition = EasyLoadingToastPosition;

class AppToast {
  static void show(
    String msg, {
    int duration = 1500,
    AppToastPosition? position = AppToastPosition.center,
  }) {
    EasyLoading.showToast(
      msg,
      duration: Duration(milliseconds: duration),
      toastPosition: position,
    );
  }

  static void showShort(String msg) {
    show(msg);
  }

  static void showLong(String msg) {
    show(msg, duration: 3000);
  }
}
