import 'dart:async';

typedef StorageGenericConverter<T> = T Function(String data);

/// Storage存储接口
abstract class AbstractStorage {
  /// 初始化
  Future<void> init();

  /// 写入int数据
  Future<bool> writeInt(String key, int value);

  /// 读取int数据
  int? readInt(String key);

  /// 写入double数据
  Future<bool> writeDouble(String key, double value);

  /// 读取double数据
  double? readDouble(String key);

  /// 写入string数据
  Future<bool> writeString(String key, String value);

  /// 读取string数据
  String? readString(String key);

  /// 写入bool数据
  Future<bool> writeBool(String key, bool value);

  /// 读取bool数据
  bool? readBool(String key);

  /// 写入List数据
  Future<bool> writeList(String key, List<dynamic> value);

  /// 读取List数据
  List<T>? readList<T>(String key, StorageGenericConverter<T> converter);

  /// 写入StringList数据
  Future<bool> writeStringList(String key, List<String> value) =>
      writeList(key, value);

  /// 读取StringList数据
  List<String>? readStringList(String key) =>
      readList<String>(key, (dynamic data) => data.toString());

  /// 写入Map数据
  Future<bool> writeMap(String key, Map<String, dynamic> value);

  /// 读取Map数据
  Map<String, dynamic>? readMap(String key);

  /// 删除数据
  Future<bool> remove(String key);

  /// 判断是否存在数据
  bool has(String key);

  /// 清理数据
  Future<bool> clear();
}
