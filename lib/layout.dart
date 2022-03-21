import 'dart:ffi';

import 'package:english_words/english_words.dart';
import 'package:f_demo/shopping.dart';
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

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ShoppingListItem(
              product: const Product(name: 'Chips'),
              inCart: true,
              onCartChanged: (product, inCart) {
                debugPrint("${product.name}, $inCart");
              },
            )));
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
                  TextBtn(click: _click, pair: "${text}2"),
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
        height: 50,
        padding: const EdgeInsets.only(left: 8, right: 8),
        color: Colors.amber,
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
