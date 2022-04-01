import 'package:f_demo/res/my_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshList2 extends StatefulWidget {
  const RefreshList2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RefreshList();
}

class _RefreshList extends State<RefreshList2> {
  bool isAttention = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned(
              top: 10,
              child: Image(
                image: AssetImage("assets/images/bj1.png"),
              ),
            ),
            // Text("Title在这里？"),
            Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () {},
                    ),
                    title: Visibility(
                      visible: true,
                      child: Row(
                        children: [
                          const Image(
                            image: AssetImage("assets/images/icon.png"),
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "这里是标题",
                                style: TextStyle(
                                    color: MyColors.color33, fontSize: 14),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "这里是简介",
                                style: TextStyle(
                                    color: MyColors.color99, fontSize: 8),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    titleSpacing: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    actions: [
                      Visibility(
                        visible: true,
                        child: GestureDetector(
                          child: Center(
                            heightFactor: 1,
                            child: isAttention
                                ? Container(
                                    height: 24,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: const Text(
                                      "+ 关注",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  )
                                : const Text(
                                    "已关注",
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 14),
                                  ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Fluttertoast.showToast(msg: "分享");
                          },
                          icon: const Icon(Icons.share))
                    ],
                  ),
                  Expanded(
                      child: Container(
                          height: double.infinity,
                          color: Colors.transparent,
                          child: SmartRefresher(
                            controller:
                                RefreshController(initialRefresh: false),
                            child: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    color: Colors.transparent,
                                    child: Stack(
                                      // fit: StackFit.expand,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(top: 38),
                                          padding: const EdgeInsets.only(left: 16, bottom: 21, right: 16),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                          ),
                                          child: const Text("我在哪里"),
                                        ),
                                        const Positioned(
                                          left: 16,
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/icon.png"),
                                            width: 76,
                                            height: 76,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
