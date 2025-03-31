import 'package:moodary_flutter/core/storages/shared_prefs_storage.dart';

/// 存储基类
abstract class AppStorage {
  static SharedPrefsStorage get sharedPrefs =>
      _sharedPrefs ??= SharedPrefsStorage();
  static SharedPrefsStorage? _sharedPrefs;

  static Future<void> initDefault() async {
    await sharedPrefs.init();
  }
}
