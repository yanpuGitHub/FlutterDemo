import 'dart:ffi';

import 'package:english_words/english_words.dart';
import 'package:f_demo/page/demo/refresh_list.dart';
import 'package:f_demo/page/demo/text_field.dart';
import 'package:f_demo/res/my_color.dart';
import 'package:f_demo/res/my_string.dart';
import 'package:f_demo/uitls/num_util.dart';
import 'package:f_demo/uitls/shared_preferences.dart';
import 'package:f_demo/uitls/time.dart';
import 'package:f_demo/view/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _textStyle =
    TextStyle(fontSize: 18, color: Colors.deepPurpleAccent, inherit: false);

class WordPairDetail extends StatefulWidget {
  final WordPair pair;

  const WordPairDetail({Key? key, required this.pair}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WordPairDetail();
}

class _WordPairDetail extends State<WordPairDetail>
    with SingleTickerProviderStateMixin {
  String text = "";
  bool isVisibility = true;
  /// 标题栏key
  GlobalKey headerKey = GlobalKey();

  var map = {"title":"这是标题", "name":"名称"};

  @override
  void initState() {
    super.initState();
    text = widget.pair.asPascalCase;

    animationController = AnimationController(
        value: 0, duration: const Duration(milliseconds: 1500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    // animationController.forward();
  }

  void _click() {
    debugPrint("点我干哈");
    setState(() {
      text = "点我干哈";
    });
    isVisibility = false;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginActivity(phone: "")));
  }

  void _click2() async{
    debugPrint("点我干哈");
    setState(() {
      text = "点我干哈";
    });
    isVisibility = false;
    var value= SpUtil.getString("name");
    debugPrint("name=$value");



    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RefreshList()));
  }

  void _click3() {
    animationController.reverse();
    String time = TimeUtil.basePrettyTime(1648707402000);
    debugPrint("时间 = $time");
    debugPrint("数据 = ${NumUtil.intCount2Str(1)}");
    addParams(map);
    SpUtil.saveString("name", "真的是张三？");

    TimeUtil.betweenDay(1648707402000, DateTime.now().millisecondsSinceEpoch);
  }

  late Animation<double> animation;
  late AnimationController animationController;

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    debugPrint(("状态栏高度=${MediaQuery.of(context).padding.top}"));
    // AppLocalizations.of();
    // final app = AppLocalizations.of();

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: PreferredSize(
          child: AppBar(
            key: headerKey,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text("我是标题", style: TextStyle(fontSize: 16, color: Colors.black),),
            foregroundColor: Colors.green,
            actions: const [
              Text("右侧图标颜色？", style: TextStyle(fontSize: 16, color: Colors.white),),
              Icon(Icons.share)
            ],
            toolbarOpacity: 1.0,
          ),
          preferredSize: const Size(double.infinity, 50),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textDirection: TextDirection.ltr,
                  children: [
                    TextBtn(click: _click2, pair: "${text}1"),
                    Visibility(
                      child: TextBtn(click: _click3, pair: "${text}2"),
                      visible: true,
                    ),
                    TextBtn(click: _click, pair: "${text}3"),
                  ],
                ),
                const SizedBox(
                  height: 50,
                  width: 90,
                ),
                Image.asset("assets/images/111.png"),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 8, bottom: 21),
                  child: const ExpandableText(MyStrings.str,
                      expandText: "展开", maxLines: 2, linkColor: Colors.blue, style: TextStyle(
                          inherit: false,
                          fontSize: 12,
                          color: MyColors.color99,
                          height: 1.3)),
                ),
                FadeTransition(
                  opacity: animation,
                  child: const Text(
                    "AppLocalizations.of(context)",
                    style: TextStyle(
                        inherit: false,
                        fontSize: 16,
                        color: MyColors.colorD93639),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isShow = true;
                      });
                      animationController.forward();
                      debugPrint("appbar高度=${headerKey.currentContext?.size?.height ?? 0}");
                      headerKey.currentContext?.size?.height ?? 0;
                    },
                    child: const Text("开始",
                        style: TextStyle(
                            inherit: false,
                            fontSize: 16,
                            color: MyColors.colorD93639))),
                Container(
                  width: 10,
                  height: 10,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(20),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  placeholder: "输入提示音",
                  scrollPadding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amberAccent, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textAlignVertical: TextAlignVertical.center,
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }


  void addParams(Map<String, Object> params){
    params["age"]="年龄12";
    params["sex"]="性别男";
    debugPrint("map=$params");
  }
}

class TextBtn extends StatelessWidget {
  const TextBtn({Key? key, required this.click, required this.pair})
      : super(key: key);

  final GestureTapCallback? click;
  final String pair;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellow[900]!,
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,
          // 阴影模糊层度由blurRadius大小决定（大就更透明更扩散），
          // 阴影模糊大小由spreadRadius决定
          boxShadow: const [
            BoxShadow(
              color: Colors.yellow,
              offset: Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.greenAccent,
              offset: Offset(1.0, 1.0),
            ),
          ],
        ),
        height: 50,
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Center(
          child: Text(
            pair,
            style: _textStyle,
          ),
        ),
      ),
      onTap: click,
    );
  }
}
