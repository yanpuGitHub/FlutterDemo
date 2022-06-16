import 'package:f_demo/page/discovery.dart';
import 'package:f_demo/page/home.dart';
import 'package:f_demo/page/mine.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  var bottomNavItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.date_range_rounded), label: "发现"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
  ];

  int _currentIndex = 0;

  var pageList = <Widget>[const HomePage(), const DiscoveryPage(), const MinePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        unselectedItemColor: Colors.greenAccent,

        ///selectedItemColor,fixedColor都是选中颜色，fixedColor是为了向后兼容
        fixedColor: Colors.red,
        selectedFontSize: 16,
        unselectedFontSize: 13,
        currentIndex: _currentIndex,
        onTap: (int index){
          _currentIndex = index;
           setState(() {

           });
        },
      ),
    );
  }
}
