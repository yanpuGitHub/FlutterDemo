import 'dart:convert';

import 'package:f_demo/uitls/log.dart';
import 'package:f_demo/uitls/shared_preferences.dart';
import 'package:f_demo/uitls/time.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    L.d(DateTime.now().millisecondsSinceEpoch, tag: "开始时间");
    L.d(SpUtil.getString("count_key"), tag: "value");
    L.d(DateTime.now().millisecondsSinceEpoch, tag: "方法后面的时间");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
        title: const Text(
          "这是首页",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                testClick("一号点击");
                thread();
              },
              child: const Text(
                "多线程点击",
                style: TextStyle(
                    inherit: false, fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            TextButton(
              onPressed: () {
                testClick("二号点击");
              },
              child: const Text(
                "多线程点击",
                style: TextStyle(
                    inherit: false, fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            TextButton(
              onPressed: () {
                // save();
                toList();
              },
              child: const Text(
                "存数据",
                style: TextStyle(
                    inherit: false, fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            TextButton(
              onPressed: () {
                getP();
              },
              child: const Text(
                "取数据",
                style: TextStyle(
                    inherit: false, fontSize: 18, color: Colors.deepOrange),
              ),
            ),
            Text(str,
                style: const TextStyle(
                    inherit: false, fontSize: 18, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  String str = "";

  void save() {
    var p = Person(name: "法外狂徒张三", age: 20);
    SpUtil.saveObject("person", p);

    var list = <Person>[];
    var p1 = Person(name: "李四", age: 32);
    var p2 = Person(name: "王五", age: 15);
    list.add(p);
    list.add(p1);
    list.add(p2);
    SpUtil.saveObjectList("personList", list);
  }

  void getP() {
    var p = SpUtil.getObject<Person>("person", (v) {
      setState(() {
        str = "${v["name"]} + ${v["age"]}";
      });
      return Person(name: v["name"], age: v["age"]);
    });
    L.d("${p?.name}, ${p?.age}");

    var list = SpUtil.getObjectList<Person>("personList", (v) {
      L.d(v);
      return Person(name: v["name"], age: v["age"]);
    });
    L.d("list=${list.length}, ${list.toString()}");
    for (var element in list) {
      L.d("element=${element.toJson()}");
    }
  }

  void toList() {
    L.d("toList----");
    var list = <Person>[];
    var p = Person(name: "法外狂徒张三", age: 20);
    var p1 = Person(name: "李四", age: 32);
    var p2 = Person(name: "王五", age: 15);
    list.add(p);
    list.add(p1);
    list.add(p2);
    L.d("toList----m1------开始");
    var m = list.map((e) {
      var json = jsonEncode(e);
      L.d("json m1 = $json");
      return e.age as int;
    }).toList();
    L.d("toList----m1------结束");
    L.d("toList----m2------开始");
    var m2 = list.map((e) {
      var json = jsonEncode(e);
      L.d("json m2 = $json");
      return e.name;
    }).toList();
    L.d("toList----m2------结束");
    var fold = m.fold<int>(3, (previousValue, element) => previousValue + element);
    var fold2 = m2.fold<String>("咦~这是谁啊！！！", (previousValue, element) => "$previousValue和$element");
    L.d("m =$m, $fold");
    L.d("m2 =$m2, $fold2");
  }

  bool _bCounting = false;

  final Lock _lock = Lock();
  final Lock _lock2 = Lock();

  void thread() {
    L.d("${DateTime.now().toString()} : $_bCounting");
    _lock2.synchronized(() async {
      _bCounting = !_bCounting;
      L.d("1:in lock. changed to: $_bCounting");
      await _lock2.synchronized(() async {
        _bCounting = !_bCounting;
        L.d("2:in lock. changed to: $_bCounting");
      });
    });
  }

  int count = 0;

  void testClick(String tag) {
    L.d("$count   data=${TimeUtil.todayTime(temp: date1)}", tag: tag);
    _lock.synchronized(() async {
      L.d("lock 开始-->$count   data=${TimeUtil.todayTime(temp: date1)}",
          tag: tag);
      await Future.delayed(const Duration(seconds: 5));
      count++;
      L.d("lock 结束-->$count   data=${TimeUtil.todayTime(temp: date1)}",
          tag: tag);
    });
  }
}

class Person {
  Person({this.name, this.age});

  String? name;
  int? age;

  Person.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    age = json["age"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["age"] = age;
    return data;
  }
}
