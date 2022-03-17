import 'package:flutter/material.dart';
import 'list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter跳转",
      theme: ThemeData(primaryColor: Colors.deepOrange),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.accessibility_sharp),
            GestureDetector(
              child: const Text(
                "赶紧点我",
                style: TextStyle(fontSize: 22, color: Colors.deepOrangeAccent),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RandomWords()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
