import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_information_app/bloc/models/information_model.dart';
import 'package:personal_information_app/bloc/personal_information_bloc.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/views/show_personal_information.dart';

class ShowByProvince extends StatefulWidget {
  const ShowByProvince({Key? key}) : super(key: key);

  @override
  State<ShowByProvince> createState() => _ShowByProvinceState();
}

class _ShowByProvinceState extends State<ShowByProvince> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<List<InformationModel>> byProvinceList = [];
        var provinceList = state.informationList?.map((e) => e.province).toSet().toList() ?? [];

        for (int i = 0; i < provinceList.length; i++) {
          var infoByProvince = state.informationList?.where((e) {
                return e.province == provinceList[i];
              }).toList() ??
              [];
          byProvinceList.add(infoByProvince);
        }
        return state.informationList != null
            ? Container(
                color: Colors.white,
                padding: EdgeInsets.all(24),
                child: ListView.builder(
                  itemCount: byProvinceList.length,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueAccent.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${provinceList[index]}",
                            style: FontTheme.medium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ...byProvinceList[index].map(
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowPersonalInformation(
                                      info: e,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(6),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${e.prefix ?? ""} ${e.name ?? ""} ${e.lastName ?? ""}",
                                      style: FontTheme.regular,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  child: Container(
                                                    padding: EdgeInsets.all(24),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "คุณต้องการลบข้อมูลใช่ หรือไม่",
                                                          style: FontTheme.medium.copyWith(color: Colors.red, fontWeight: FontWeight.w800),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                width: double.infinity,
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                                                                  child: Text(
                                                                    "ยกเลิก",
                                                                    style: FontTheme.regular,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                width: double.infinity,
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    state.informationList?.removeWhere((element) => element == e);
                                                                    Navigator.pop(context);
                                                                    setState(() {});
                                                                  },
                                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                                                                  child: Text(
                                                                    "ลบ",
                                                                    style: FontTheme.regular,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      child: Icon(
                                        Icons.remove_circle_outline_rounded,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            : Center(
                child: Text(
                  "ไม่มีข้อมูล",
                  style: FontTheme.medium,
                ),
              );
      },
    );
  }
}
