import 'dart:ffi';

import 'package:f_demo/res/my_color.dart';
import 'package:f_demo/res/my_string.dart';
import 'package:f_demo/view/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshList extends StatefulWidget {
  const RefreshList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RefreshList();
}

class _RefreshList extends State<RefreshList>
    with SingleTickerProviderStateMixin {
  bool isAttention = false;
  List dataList = [
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
    ColumnBean(
        title: "美国最新草案：60岁以上心血管病一级预防",
        des: "8评论·28分享·03-20",
        image: "assets/images/pujing.png"),
  ];

  ScrollController controller = ScrollController();
  GlobalKey listGlobalKey = GlobalKey();

  /// 是否获取高度
  bool isGetHeight = true;

  bool isShowTitle = false;
  double height = 0;

  late Animation<double> animation;
  late AnimationController animationController;

  double alpha = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        value: 0, duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    controller.addListener(() {
      if (isGetHeight) {
        height = listGlobalKey.currentContext?.size?.height ?? 0;
      }
      debugPrint("height--> $height = ${controller.offset}");
      if (controller.offset <= height) {
        isGetHeight = true;
        setState(() {
          isShowTitle = false;
        });
        animationController.reverse();
        alpha = 0;
      } else {
        setState(() {
          isShowTitle = true;
        });
        isGetHeight = false;
        double h = controller.offset - height;
        if (h <= 80) {
          alpha = h / 80;
        } else {
          alpha = 1;
        }
        // animationController.animateTo(target);
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        constraints: const BoxConstraints.expand(),
        height: double.infinity,
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage("assets/images/bj1.png"),
                fit: BoxFit.cover,
              ),
            ),
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
                    title: Opacity(
                      opacity: alpha,
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
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    shadowColor: Colors.transparent,
                    actions: [
                      Opacity(
                        opacity: alpha,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            heightFactor: 1,
                            child: Container(
                              height: 24,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: isAttention
                                      ? Colors.transparent
                                      : Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    isAttention ? "已关注" : "+ 关注",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    child: const CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 1.0,
                                      valueColor:
                                      AlwaysStoppedAnimation(Colors.red),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // : const Text(
                            //     "已关注",
                            //     style: TextStyle(
                            //         color: Colors.white38, fontSize: 14),
                            //   ),
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
                            // scrollController: controller,
                            controller:
                                RefreshController(initialRefresh: false),
                            child: CustomScrollView(
                              controller: controller,
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          key: listGlobalKey,
                                          // fit: StackFit.expand,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(
                                                  top: 38),
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: 28,
                                                        margin: const EdgeInsets
                                                            .only(top: 21),
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 38,
                                                                right: 38),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .red.shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        28)),
                                                        child: const Text(
                                                          "+ 关注",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              inherit: false),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  const Text(
                                                    "这是标题？",
                                                    style: TextStyle(
                                                        inherit: false,
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    children: const [
                                                      Text(
                                                        "505",
                                                        style: TextStyle(
                                                            inherit: false,
                                                            color: MyColors
                                                                .color33,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "内容",
                                                        style: TextStyle(
                                                            inherit: false,
                                                            color: MyColors
                                                                .color99,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(width: 16),
                                                      Text(
                                                        "505",
                                                        style: TextStyle(
                                                            inherit: false,
                                                            color: MyColors
                                                                .color33,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "关注",
                                                        style: TextStyle(
                                                            inherit: false,
                                                            color: MyColors
                                                                .color99,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(width: 16),
                                                      Text(
                                                        "505",
                                                        style: TextStyle(
                                                            inherit: false,
                                                            color: MyColors
                                                                .color33,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "浏览",
                                                        style: TextStyle(
                                                            inherit: false,
                                                            color: MyColors
                                                                .color99,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
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
                                        Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 21, right: 16),
                                          child: const ExpandableText(
                                            MyStrings.str,
                                            expandText: "展开",
                                            collapseText: "收起",
                                            maxLines: 2,
                                            linkColor: Colors.blue,
                                            style: TextStyle(
                                                inherit: false,
                                                fontSize: 12,
                                                color: MyColors.color99,
                                                height: 1.3),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyColors.colorEe,
                                                width: 0.5),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
                                SliverFixedExtentList(
                                    delegate: SliverChildBuilderDelegate(
                                      _item,
                                      childCount: dataList.length,
                                    ),
                                    itemExtent: 100.0),
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

  Widget _item(BuildContext context, int index) {
    ColumnBean bean = dataList[index];
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: "我是第$index条数据");
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 13, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        bean.title,
                        style: const TextStyle(
                            inherit: false,
                            fontSize: 16,
                            color: MyColors.color22),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Text(
                        bean.des,
                        style: const TextStyle(
                            inherit: false,
                            fontSize: 11,
                            color: MyColors.color99),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Image(
                    image: AssetImage(bean.image),
                    width: 90,
                    height: 68,
                    fit: BoxFit.fill)
              ],
            )),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.colorEe, width: 0.5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColumnBean {
  ColumnBean({
    required this.title,
    required this.des,
    required this.image,
  });

  String title;

  String des;

  String image;
}
