import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/widget/calendar.dart';
import 'package:personal_information_app/widget/custom_text_form.dart';
import 'package:intl/intl.dart';

class PersonalInfoPage extends StatefulWidget {
  final GlobalKey<FormState> keyForm;
  final Function(DateTime?)? dateCallBack;
  const PersonalInfoPage({Key? key, required this.keyForm,this.dateCallBack}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController idNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? daySelected;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextForm(
            controller: idNumberController,
            titleText: "เลขประจำตัวประชาชน",
            hintText: "กรอกหมายเลขประจำตัวประชาชน",
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(13)],
            keyboardType: TextInputType.number,
            validator: (value) {
              if (idNumberController.text.trim().isEmpty) {
                return "กรุณาเลขประจำตัวประชาชน";
              } else if (idNumberController.text.trim().length < 13) {
                return "รูปเลขประจำตัวประชาชนไม่ถูกต้อง";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 14,
          ),
          CustomTextForm(
            controller: nameController,
            titleText: "ชื่อ",
            hintText: "กรอกชื่อ",
            validator: (value) {
              if (idNumberController.text.trim().isEmpty) {
                return "กรุณากรอกชื่อ";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 14,
          ),
          CustomTextForm(
            controller: lastNameController,
            titleText: "นามสกุล",
            hintText: "กรอกนามสกุล",
            validator: (value) {
              if (idNumberController.text.trim().length == 0) {
                return "กรุณากรอกนามสกุล";
              } else {
                return null;
              }
            },
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            "วัน/เดือน/ปี เกิด",
            style: FontTheme.light,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              daySelected = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Calendar(),
                ),
              );
              widget.dateCallBack!.call(daySelected);
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        daySelected != null ? "${DateFormat('dd/MM/y').format(daySelected!)}" : "กรอก วัน/เดือน/ปี เกิด",
                        style: FontTheme.light.copyWith(color: daySelected != null ? Colors.black : Colors.grey),
                      ),
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 24,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
