import 'package:f_demo/page/main_page.dart';
import 'package:f_demo/page/provider/provider.dart';
import 'package:f_demo/page/provider/son.dart';
import 'package:f_demo/router/router_constant.dart';
import 'package:f_demo/router/router_discovery.dart';
import 'package:f_demo/router/router_home.dart';
import 'package:f_demo/router/router_init.dart';
import 'package:f_demo/router/router_mine.dart';
import 'package:flutter/cupertino.dart';

class MyRouters {
  static final List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Map<String, WidgetBuilder> routerMap) {
    routerMap[RouterPath.mainHome] = (context) => const MainPage();
    routerMap[RouterPath.providerFather] = (context) => const FatherPager();

    _listRouter.clear();
    _listRouter.add(HomeRouter());
    _listRouter.add(DiscoveryRouter());
    _listRouter.add(MineRouter());

    for (var routerProvider in _listRouter) {
      routerProvider.initRouter(routerMap);
    }
  }
}
