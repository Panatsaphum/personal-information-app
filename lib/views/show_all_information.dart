import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_information_app/bloc/personal_information_bloc.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/views/show_personal_information.dart';

class ShowAllInformation extends StatefulWidget {
  const ShowAllInformation({Key? key}) : super(key: key);

  @override
  State<ShowAllInformation> createState() => _ShowAllInformationState();
}

class _ShowAllInformationState extends State<ShowAllInformation> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.informationList != null
            ? Container(
                padding: EdgeInsets.all(24),
                color: Colors.white,
                child: ListView.builder(
                  itemCount: state.informationList?.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowPersonalInformation(
                            info: state.informationList?[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${state.informationList?[index].prefix ?? ""} ${state.informationList?[index].name ?? ""} ${state.informationList?[index].lastName ?? ""}",
                              style: FontTheme.regular,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                                          state.informationList?.removeAt(index);
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
