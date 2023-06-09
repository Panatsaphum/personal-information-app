import 'package:flutter/material.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/views/show_all_information.dart';
import 'package:personal_information_app/views/show_by_province.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "รายชื่อผู้ลงทะเบียน",
            style: FontTheme.medium,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "เพิ่มรายชื่อใหม่",
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.yellow,
          child: Column(
            children: [
              TabBar(
                indicatorColor: Colors.blue,
                controller: _controller,
                tabs: [
                  Tab(
                    child: Text(
                      "ทั้งหมด",
                      style: FontTheme.regular,
                    ),
                  ),
                  Tab(
                    child: Text("จังหวัด", style: FontTheme.regular),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.lightGreen,
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      ShowAllInformation(),
                      ShowByProvince(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
