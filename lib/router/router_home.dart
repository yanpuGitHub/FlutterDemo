
import 'package:f_demo/page/home.dart';
import 'package:f_demo/router/router_init.dart';
import 'package:flutter/cupertino.dart';

class HomeRouter implements IRouterProvider{

  @override
  void initRouter(Map<String, WidgetBuilder> routerMap) {
    routerMap["home_page"] = (context)=> const HomePage();
  }
}