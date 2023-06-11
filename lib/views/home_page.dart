import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_information_app/bloc/personal_information_bloc.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/views/add_information_botton_sheet.dart';
import 'package:personal_information_app/views/show_all_information.dart';
import 'package:personal_information_app/views/show_by_province.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _controller;
  bool isLoading = true;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<PersonalInformationBloc>().add(GetAddess());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInformationBloc, PersonalInformationState>(
      listener: (context, state) {
        if (state.status == PersonalInformationStatus.loading) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
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
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => AddInformationBottomSheet(),
              );
            },
            tooltip: "เพิ่มรายชื่อใหม่",
            child: Icon(Icons.add),
          ),
          body: SafeArea(
            child: Container(
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.grey,
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
                      color: Colors.white,
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
        ),
      ),
    );
  }
}
