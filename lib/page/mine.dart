import 'package:f_demo/widget/cover_image.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MinePage();
}

class _MinePage extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    debugPrint("instate: mine");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              width: 100,
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              const AspectRatio(
                aspectRatio: 3 / 1,
                child: CoverImage(
                  imageUrl: "https://studioyszimg.yxj.org.cn/l3ylkeipbbk.jpg",
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AspectRatio(
                  aspectRatio: 3.86 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.transparent,
                          Colors.black54,
                        ])),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("专题·13个视频",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    SizedBox(height: 4),
                    Text(
                      "糖尿病患者血脂管理的临床困惑与对策糖尿病患者血脂管理的临床困惑与对策糖尿病患者血脂管理的临床困惑与对策",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    //   Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: (){},
    //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
    //     ),
    //     title: ,
    //     backgroundColor:,),
    // );
  }
}
