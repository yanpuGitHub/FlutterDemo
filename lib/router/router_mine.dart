
import 'package:f_demo/page/mine.dart';
import 'package:f_demo/router/router_init.dart';
import 'package:flutter/cupertino.dart';

class MineRouter implements IRouterProvider{

  @override
  void initRouter(Map<String, WidgetBuilder> routerMap) {
    routerMap["mine_page"] = (context)=> const MinePage();
  }
}