import 'package:f_demo/router/router_constant.dart';
import 'package:f_demo/uitls/log.dart';
import 'package:f_demo/uitls/shared_preferences.dart';
import 'package:f_demo/widget/cover_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

import 'widget/skip_down_time_progress.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    L.d("启动开始时间: ${DateTime.now().millisecondsSinceEpoch}");
    // spInstance();
    Future.delayed(const Duration(milliseconds: 1000), () {
      imageUrl =
          "https://pic.netbian.com/uploads/allimg/220614/004643-16551388035ce0.jpg";
      if (imageUrl.length > 0) {
        setState(() {});
      } else {
        Future.delayed(Duration(milliseconds: 10), goMainHome);
      }
    });
  }

  void spInstance() async {
    var startTime = DateTime.now().millisecondsSinceEpoch;
    L.d("启动开始时间: $startTime");
    await SpUtil.getInstance();
    var endTime = DateTime.now().millisecondsSinceEpoch;
    L.d("启动结束时间: $endTime");
    L.d("sp启动花费时间：${endTime - startTime}ms");
    SpUtil.saveString("count_key", "111");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ConstrainedBox(
        //   constraints: const BoxConstraints.expand(),
        //   child:
        imageUrl.length > 0
            ?
            Image.network(imageUrl, height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,)
        // CoverImage(
        //         imageUrl: imageUrl,
        //         height: double.infinity,
        //         width: double.infinity,
        //         errorImage: "assets/images/splash.jpg",
        //         holderImage: "assets/images/splash.jpg",
        //         errorFit: BoxFit.fill,
        //         fit: BoxFit.fill,
        //       )
            : Image.asset(
                "assets/images/splash.jpg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
                // ),
              ),
        Visibility(
          visible: imageUrl.length > 0,
          child: Positioned(
            top: MediaQueryData.fromWindow(ui.window).padding.top + 20,
            right: 30,
            child: SkipDownTimeProgress(
              color: Colors.red,
              radius: 22.0,
              duration: Duration(seconds: 5),
              size: Size(25.0, 25.0),
              skipText: "跳过",
              onTap: () => goMainHome(),
              onFinishCallback: (bool value) {
                if (value) goMainHome();
              },
            ),
          ),
        )
      ],
    );
  }

  void goMainHome() {
    L.d("进入主页");
    Navigator.of(context).pushReplacementNamed(RouterPath.mainHome);
  }
}
