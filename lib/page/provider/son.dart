import 'package:f_demo/uitls/log.dart';
import 'package:flutter/cupertino.dart';

class SonPage extends StatefulWidget {
  const SonPage({Key? key, required this.type}) : super(key: key);

  final int type;

  @override
  State<StatefulWidget> createState() => _SonPage();
}

class _SonPage extends State<SonPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    L.d("initState -> type = ${widget.type}");
    handlerData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("我是子${widget.type}号页面"),
    );
  }

  void handlerData() async {
    await Future.delayed(const Duration(seconds: 3), () {
      L.d("我是子${widget.type}号页面打印的数据");
    });
  }

  @override
  bool get wantKeepAlive => true;
}
