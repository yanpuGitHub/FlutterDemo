import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'layout.dart';

/// 列表
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Color(0xFF2D5CBA));

  final _saved = <WordPair>{};

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      /*对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
       在偶数行，该函数会为单词对添加一个ListTile row.
       在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
       注意，在小屏幕上，分割线看起来可能比较吃力。*/
      itemBuilder: (context, i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (i.isOdd) {
          return const Divider(
            color: Colors.deepOrange,
          );
        }
        /*语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
         时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量*/
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("列表"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _pushSaved(_saved, context);
              },
              icon: const Icon(Icons.list))
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  final _biggerFont2 =
      const TextStyle(fontSize: 16.0, color: Color(0xFFBA972D));

  void _pushSaved(Set<WordPair> list, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont2,
          ),
          onTap: () {
            debugPrint(pair.asPascalCase);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WordPairDetail(pair: pair)));
          },
        );
      });
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text("收藏"),
          centerTitle: true,
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }
}
