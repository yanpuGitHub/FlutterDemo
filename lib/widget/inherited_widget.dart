import 'package:flutter/cupertino.dart';

class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({Key? key, required Widget child, required this.data})
      : super(key: key, child: child);

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class ChangeNotifier implements Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    for (var element in listeners) {
      element();
    }
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierProvider(
      {Key? key, required this.data, required this.child})
      : super(key: key);

  final Widget child;
  final T data;

  static T? of<T>(BuildContext context) {
    // final type = _typeOf<InheritedProvider<T>>();
    final provider =
        context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();

    return provider?.data;
  }

  @override
  _ChangeNotifierProvider<T> createState() => _ChangeNotifierProvider<T>();
}

class _ChangeNotifierProvider<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}
