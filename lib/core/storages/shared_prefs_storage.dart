import 'dart:convert';

import 'package:moodary_flutter/core/storages/abstract_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage extends AbstractStorage {
  late SharedPreferences _sp;

  @override
  Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> writeInt(String key, int value) {
    return _sp.setInt(key, value);
  }

  @override
  int? readInt(String key) {
    return _sp.getInt(key);
  }

  @override
  Future<bool> writeDouble(String key, double value) {
    return _sp.setDouble(key, value);
  }

  @override
  double? readDouble(String key) {
    return _sp.getDouble(key);
  }

  @override
  Future<bool> writeString(String key, String value) {
    return _sp.setString(key, value);
  }

  @override
  String? readString(String key) {
    return _sp.getString(key);
  }

  @override
  Future<bool> writeBool(String key, bool value) {
    return _sp.setBool(key, value);
  }

  @override
  bool? readBool(String key) {
    return _sp.getBool(key);
  }

  @override
  Future<bool> writeList(String key, List<dynamic> value) {
    final List<String> stringListValue = value.map(jsonEncode).toList();
    return _sp.setStringList(key, stringListValue);
  }

  @override
  List<T>? readList<T>(String key, StorageGenericConverter<T> converter) {
    final List<String>? stringListValue = _sp.getStringList(key);
    if (stringListValue == null) {
      return null;
    }
    return stringListValue.map(converter).toList();
  }

  @override
  Future<bool> writeMap(String key, Map<String, dynamic> value) {
    final String valueString = jsonEncode(value);
    return _sp.setString(key, valueString);
  }

  @override
  Map<String, dynamic>? readMap(String key) {
    final String? valueString = _sp.getString(key);
    if (valueString == null) {
      return null;
    }
    return (jsonDecode(valueString) as Map<dynamic, dynamic>)
        .cast<String, dynamic>();
  }

  @override
  Future<bool> remove(String key) {
    return _sp.remove(key);
  }

  @override
  bool has(String key) {
    return _sp.containsKey(key);
  }

  @override
  Future<bool> clear() {
    return _sp.clear();
  }
}
