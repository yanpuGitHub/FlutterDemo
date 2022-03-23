import 'package:flutter/cupertino.dart';

class SplitPhoneNumber {

  String phoneStr = "";

  void splitPhoneNumber(TextEditingController controller, String text) {
    bool isMatch1 = RegExp("\\d{3} \\d{4} \\d{0,4}").hasMatch(text);
    bool isMatch2 = RegExp("\\d{3} \\d{0,4}").hasMatch(text);
    phoneStr = "";
    // 光标的位置
    int cursor = controller.value.selection.baseOffset;
    debugPrint(
        "正则匹配：$text, $isMatch1, $isMatch2, ${controller.value.selection.baseOffset}");
    if (cursor < 0) {
      cursor = text.length;
      controller.selection = TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: cursor));
    }
    int length = text.length;
    if ((length == 4 || length == 9) && text.endsWith(" ")) {
      debugPrint("length：$text");
      String str = text.substring(0, length - 1);
      phoneStr = str;
    } else if (length > 8 && !isMatch1 ||
        length >= 4 && length < 8 && !isMatch2) {
      debugPrint("length：$text");
      text = text.trim();
      int num = getSpaceNum(cursor, text);
      String str = text.replaceAll(" ", "");
      int l = str.length;
      if (l > 7) {
        String str1 = str.substring(0, 3);
        phoneStr = str1 + " ";
        String str2 = str.substring(3, 7);
        phoneStr = phoneStr + str2 + " ";
        String str3 = str.substring(7);
        phoneStr = phoneStr + str3;
      } else if (l > 3) {
        String str1 = str.substring(0, 3);
        phoneStr = str1 + " ";
        String str2 = str.substring(3);
        phoneStr = phoneStr + str2;
      } else {
        phoneStr = str;
      }
      cursor = cursor + getSpaceNum(cursor, phoneStr) - num;
    }
    if (phoneStr.isNotEmpty) {
      controller.text = phoneStr;
      int l = controller.text.trim().length;
      if (cursor > l) {
        cursor = l;
      }
      controller.selection = TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: cursor));
    }
  }

  ///获取光标之前的空格数
  int getSpaceNum(int c, String text) {
    if (c > text.length) {
      c = text.length;
    }
    String str1 = text.substring(0, c);
    String str2 = str1.replaceAll(" ", "");
    return str1.length - str2.length;
  }
}
