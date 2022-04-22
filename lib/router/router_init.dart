import 'package:flutter/cupertino.dart';

abstract class IRouterProvider{
  void initRouter(Map<String, WidgetBuilder> routerMap);
}