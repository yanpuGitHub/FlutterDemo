import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("count--->${count++}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(child: Text("这是首页页面", style: TextStyle(fontSize: 18, color: Colors.white),)),
    );

    //   Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: (){},
    //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
    //     ),
    //     title: ,
    //     backgroundColor:,),
    // );
  }
}
