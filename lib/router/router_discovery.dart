
import 'package:f_demo/page/discovery.dart';
import 'package:f_demo/router/router_init.dart';
import 'package:flutter/cupertino.dart';

class DiscoveryRouter implements IRouterProvider{

  @override
  void initRouter(Map<String, WidgetBuilder> routerMap) {
    routerMap["discovery_page"] = (context)=> const DiscoveryPage();
  }
}