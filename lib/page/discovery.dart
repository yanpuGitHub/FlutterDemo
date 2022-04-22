import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(child: const Text("这是发现页面", style: TextStyle(fontSize: 18, color: Colors.white)))
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