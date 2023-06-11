import 'package:flutter/material.dart';
import 'package:personal_information_app/bloc/models/information_model.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/widget/custom_text_box.dart';
import 'package:intl/intl.dart';

class ShowPersonalInformation extends StatelessWidget {
  final InformationModel? info;
  const ShowPersonalInformation({
    Key? key,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "รายละเอียด",
          style: FontTheme.medium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CustomTextBox(
                title: "เลขประจำตัวประชาชน",
                value: info?.idNumber ?? "",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextBox(
                title: "ชื่อ",
                value: "${info?.prefix ?? ""} ${info?.name ?? ""} ${info?.lastName ?? ""}",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextBox(
                title: "วัน/เดือน/ปี เกิด",
                value: "${info != null ? DateFormat('dd/MM/y').format(info!.birthDate!) : ""}",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextBox(
                title: "บ้านเลขที่",
                value: info?.address ?? "",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextBox(
                title: "แขวง/ตำบล",
                value: info?.subDistrict ?? "",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextBox(
                title: "เขต/เภอ",
                value: info?.district ?? "",
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextBox(
                title: "จังหวัด",
                value: info?.province ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
