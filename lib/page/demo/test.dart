import 'package:flutter/cupertino.dart';

typedef inA = bool Function();

String a = "";
/// 测试git回退版本1
bool isNoble() => true;

void main() => runApp(const MyPage());

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()  => _MyHomePageState();

}

class MyHomePage extends StatefulWidget{

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<Homepage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}