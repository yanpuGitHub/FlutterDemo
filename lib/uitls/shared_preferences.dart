import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtil {
  SpUtil._instance();

  static SpUtil? _spUtil;
  static final Lock _lock = Lock();
  static SharedPreferences? _prefs;

  static Future<SpUtil?> getInstance() async {
    if (null == _spUtil) {
      await _lock.synchronized(() async {
        if (null == _spUtil) {
          var singleton = SpUtil._instance();
          await singleton._init();
          _spUtil = singleton;
        }
      });
    }
    return _spUtil;
  }

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///写入String数据
  static Future<bool>? saveString(String key, String value) {
    return _prefs?.setString(key, value);
  }

  ///获取写入的String数据
  static String getString(String key, {String defValue = ""}) {
    return _prefs?.getString(key) ?? defValue;
  }

  ///写入int数据
  static Future<bool>? saveInt(String key, int value) {
    return _prefs?.setInt(key, value);
  }

  ///获取写入的int数据
  static int getInt(String key, {int defValue = 0}) {
    return _prefs?.getInt(key) ?? defValue;
  }

  ///写入bool数据
  static Future<bool>? saveBool(String key, bool value) {
    return _prefs?.setBool(key, value);
  }

  ///获取写入的bool数据
  static bool getBool(String key, {bool defValue = false}) {
    return _prefs?.getBool(key) ?? defValue;
  }

  /// 存储object
  static Future<bool>? saveObject(String key, Object value) {
    return _prefs?.setString(key, jsonEncode(value));
  }

  /// 获取object
  static T? getObject<T>(String key, T Function(Map v) f, {T? defValue}) {
    Map? map = getObj(key);
    return null == map ? defValue : f(map);
  }

  static Map? getObj(String key) {
    String? _data = _prefs?.getString(key);
    return (null == _data || _data.isEmpty) ? null : jsonDecode(_data);
  }

  /// 存储列表数据
  static Future<bool>? saveObjectList(String key, List<Object> list) {
    List<String> _dataList = list.map((e) {
      return jsonEncode(e);
    }).toList();
    return _prefs?.setStringList(key, _dataList);
  }

  /// 获取列表数据
  static List<T> getObjectList<T>(String key, T Function(Map v) f,
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  static List<Map>? getObjList(String key) {
    List<String>? dataLis = _prefs?.getStringList(key);
    return dataLis?.map((value) {
      Map _dataMap = jsonDecode(value);
      return _dataMap;
    }).toList();
  }
}
