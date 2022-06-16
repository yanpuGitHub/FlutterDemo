import 'dart:io';

import 'package:f_demo/router/routers.dart';
import 'package:f_demo/splash.dart';
import 'package:f_demo/uitls/log.dart';
import 'package:f_demo/uitls/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  /// 去除状态栏阴影
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routerMap = {};
    MyRouters.configureRoutes(routerMap);
    L.d("routerMap$routerMap");
    return MaterialApp(
      title: "flutter跳转",
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: const SplashPage(),
      routes: routerMap,
    );
  }
}