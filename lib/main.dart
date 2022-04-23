import 'dart:io';

import 'package:f_demo/router/routers.dart';
import 'package:f_demo/test.dart';
import 'package:f_demo/uitls/log.dart';
import 'package:f_demo/uitls/shared_preferences.dart';
import 'package:f_demo/uitls/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synchronized/synchronized.dart';
import 'list.dart';

void main() {
  runApp(const MyApp());
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
    print("routerMap$routerMap");
    return MaterialApp(
      title: "flutter跳转",
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: const MyHomePage(),
      routes: routerMap,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spInstance();
  }

  void spInstance() async {
    L.d(DateTime.now().millisecondsSinceEpoch, tag: "启动开始时间");
    await SpUtil.getInstance();
    L.d(DateTime.now().millisecondsSinceEpoch, tag: "启动结束时间");
    SpUtil.saveString("count_key", "111");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.accessibility_sharp),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("main_home");
              },
              child: const Text(
                "赶紧点我",
                style: TextStyle(
                    inherit: false,
                    fontSize: 22,
                    color: Colors.deepOrangeAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
