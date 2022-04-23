import 'package:flutter/cupertino.dart';

class L {
  static void d(Object object, {String? tag}) {
    print("${null == tag || "" == tag ? "打印数据" : tag}--->$object");
  }
}
