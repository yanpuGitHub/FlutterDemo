import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class WordPairDetail extends StatelessWidget {
  final WordPair pair;

  const WordPairDetail({Key? key, required this.pair}) : super(key: key);

  final _textStyle =
      const TextStyle(fontSize: 18, color: Colors.black, inherit: false);

  void _click() {
    debugPrint("点我干哈");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(pair.asPascalCase, style: _textStyle),
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.ltr,
              children: [
                TextBtn(click: _click, pair: "${pair.asPascalCase}1"),
                TextBtn(click: _click, pair: "${pair.asPascalCase}2"),
                TextBtn(click: _click, pair: "${pair.asPascalCase}3"),
              ],
            ),
          ],
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
            style: const TextStyle(
                fontSize: 18, color: Colors.black, inherit: false),
          ),
        ),
      ),
      onTap: click /*() {
        debugPrint("点我干哈");
      }*/
      ,
    );
  }
}
