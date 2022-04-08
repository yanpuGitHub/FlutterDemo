import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeUtil {
  /// 列表页时间显示规则：
  /// 1分钟内显示【刚刚】，如：刚刚
  /// 大于1分钟小于等于24小时显示【时时：分分】，如：09:09
  /// 大于24小时，小于等于48小时，显示【昨天】，如：昨天
  /// 大于48小时，小于等于72小时，显示【前天】，如：前天
  /// 大于3天的显示【MM-dd】，如：09-09
  /// 超出自然年一年的显示【yyyy-MM-dd】，如：2016-09-0
  static String basePrettyTime(int timestamp) {
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime cDate = DateTime.fromMillisecondsSinceEpoch(1648707432000);
    // DateTime cDate = DateTime.now();
    String timeStr = "";
    DateFormat format;
    if (datetime.year == cDate.year) {
      if (datetime.month == cDate.month) {
        var dif = cDate.difference(datetime);
        if (dif.inMinutes <= 1) {
          timeStr = "刚刚";
        } else if (dif.inMinutes > 1 && dif.inHours <= 24) {
          format = DateFormat("HH-mm");
          timeStr = format.format(datetime);
        } else if (dif.inDays == 1) {
          timeStr = "昨天";
        } else if (dif.inDays == 2) {
          timeStr = "前天";
        } else {
          format = DateFormat("MM-dd");
          timeStr = format.format(datetime);
        }
      } else {
        format = DateFormat("MM-dd");
        timeStr = format.format(datetime);
      }
    } else {
      format = DateFormat("yyyy-MM-dd");
      timeStr = format.format(datetime);
    }
    return timeStr;
  }

  /// 比较两个日期之间相差的天数
  static int betweenDay(int startTime, int endTime) {
    debugPrint("endTime=$endTime");
    DateTime start = DateTime.fromMillisecondsSinceEpoch(startTime);
    DateTime end = DateTime.fromMillisecondsSinceEpoch(endTime);
    var dif = end.difference(start);
    int day = dif.inDays;
    debugPrint("day=$day");
    return day;
  }
}
