class NumUtil {
  static String intCount2Str(int count) {
    if (count < 10000) {
      return count.toString();
    }else if (count >= 10000) {
      return "${(count / 10000).toStringAsFixed(1)}万";
    }
    return "";
  }
}
