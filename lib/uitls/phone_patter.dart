import 'package:flutter/cupertino.dart';

class SplitPhoneNumber {

  int inputLength = 0;

  void splitPhoneNumber(TextEditingController controller,String text) {
    if (text.length > inputLength) {
      //输入
      if (text.length == 4 || text.length == 9) {
        text = text.substring(0, text.length - 1) +
            " " +
            text.substring(text.length - 1, text.length);
        controller.text = text;
        controller.selection = TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: text.length)); //光标移到最后
      }
    } else {
      //删除
      if (text.length == 4 || text.length == 9) {
        text = text.substring(0, text.length - 1);
        controller.text = text;
        controller.selection = TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: text.length)); //光标移到最后
      }
    }
    inputLength = text.length;
  }
}
