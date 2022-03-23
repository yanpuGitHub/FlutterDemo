import 'dart:ffi';

import 'package:english_words/english_words.dart';
import 'package:f_demo/text_field.dart';
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

class _WordPairDetail extends State<WordPairDetail> {
  String text = "";
  bool isVisibility = true;

  @override
  void initState() {
    super.initState();
    text = widget.pair.asPascalCase;
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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(colors: [Colors.yellow, Colors.pink]),
            // ),
            color: Colors.pink,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset("assets/images/back.png", width: 50, height: 30),
                  const Text("这是啥啊")
                ],
              ),
            ),
          ),
          preferredSize: const Size(double.infinity, 50),
        ),
        body: Center(
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
                  TextBtn(click: _click, pair: "${text}1"),
                  Visibility(
                    child: TextBtn(click: _click, pair: "${text}2"),
                    visible: isVisibility,
                  ),
                  TextBtn(click: _click, pair: "${text}3"),
                ],
              ),
              const SizedBox(
                height: 50,
                width: 90,
              ),
              Image.asset("assets/images/111.png")
            ],
          ),
        ),
      ),
    );
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
