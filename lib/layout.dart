import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class WordPairDetail extends StatelessWidget {
  final WordPair pair;

  const WordPairDetail({Key? key, required this.pair}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pair.asPascalCase,
            style: const TextStyle(fontSize: 18, color: Colors.black)),
      ),
      body: Container(),
    );
  }
}
