import 'package:flutter/cupertino.dart';

///state生命周期

class CounterWidget extends StatefulWidget {
  final int initValue;

  const CounterWidget({Key? key, this.initValue = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
