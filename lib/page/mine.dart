import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MinePage();
}

class _MinePage extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: const Text("这是我的页面", style: TextStyle(fontSize: 18, color: Colors.white),),),
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