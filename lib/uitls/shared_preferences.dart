import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  SpUtil._instance();

  static final SpUtil instance = SpUtil._instance();

  static SpUtil getInstance() {
    return instance;
  }

  ///写入String数据
  setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  ///获取写入的String数据
  getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String value = preferences.getString(key) ?? "";
    return value;
  }
}
