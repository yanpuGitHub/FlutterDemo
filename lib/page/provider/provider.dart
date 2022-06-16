import 'package:f_demo/page/provider/son.dart';
import 'package:f_demo/res/my_color.dart';
import 'package:f_demo/uitls/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../widget/underline_tab_Indicator.dart';

class FatherPager extends StatefulWidget{

  const FatherPager({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState()=> _FatherPager();

}

class _FatherPager extends State<FatherPager> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  /// 上一次选择的index
  int _lastIndex = 0;
  List<String> tabs = ['课程', '专辑'];
  String yearStr = "0";
  List<int> selectIds = [0];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black87,
          ),
        ),
        title: Text(
          '已购课程',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              showPicker(context);
            },
           child: Text(yearStr == "0" ? "年份" : "$yearStr年",
               style: TextStyle(fontSize: 15, color: Color(0xff666666))),
          )
        ],
        bottom: TabBar(
          isScrollable: false,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
                child: SizedBox(
                    width: tabWidth, child: Center(child: Text('课程')))),
            Tab(
                child: SizedBox(
                    width: tabWidth, child: Center(child: Text('专辑')))),
          ],
          unselectedLabelColor: MyColors.color66,
          labelColor: MyColors.color33,
          indicatorColor: MyColors.colorD93639,
          indicatorWeight: 3,
          labelStyle: TextStyle(fontSize: 17),
          unselectedLabelStyle: TextStyle(fontSize: 17),
          indicator: const MyUnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: MyColors.colorD93639),
              isRadius: true),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: const <Widget>[SonPage(type: 1), SonPage(type: 2)]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void showPicker(BuildContext context) {
    List<PickerItem> datas = [];
    var datetime = DateTime.now();
    datas.add(PickerItem(text: Text('全部'), value: "0"));
    for (var i = datetime.year; i >= 2015; i--) {
      datas.add(PickerItem(text: Text('$i年'), value: '$i'));
    }
    Picker(
        adapter: PickerDataAdapter<dynamic>(data: datas),
        selecteds: selectIds,
        height: 260,
        changeToFirst: false,
        columnPadding: const EdgeInsets.all(8.0),
        headerColor: Colors.white12,
        textAlign: TextAlign.center,
        cancelText: "取消",
        cancelTextStyle:
        TextStyle(inherit: false, fontSize: 17, color: Colors.grey),
        confirmText: "确定",
        diameterRatio: 1.0,
        confirmTextStyle:
        TextStyle(inherit: false, fontSize: 17, color: Colors.red),
        selectionOverlay: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: MyColors.color66, width: 0.5),
                  bottom: BorderSide(color: MyColors.color66, width: 0.5))),
        ),
        onConfirm: (Picker picker, List value) {
          setState(() {
            yearStr = picker.getSelectedValues()[0];
            selectIds = value as List<int>;
            L.d("year = $yearStr, selectIds = $selectIds");
          });
        }).showModal(this.context);
  }

}