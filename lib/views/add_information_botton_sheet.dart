import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_information_app/bloc/personal_information_bloc.dart';
import 'package:personal_information_app/theme/font_theme.dart';
import 'package:personal_information_app/widget/calendar.dart';
import 'package:personal_information_app/widget/custom_text_form.dart';
import 'package:intl/intl.dart';

class AddInformationBottomSheet extends StatefulWidget {
  const AddInformationBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddInformationBottomSheet> createState() => _AddInformationBottomSheetState();
}

class _AddInformationBottomSheetState extends State<AddInformationBottomSheet> {
  int currentStep = 0;
  DateTime? birthDateSelected;
  bool infoIsValidate = false;
  bool addressIsValidate = false;

  GlobalKey<FormState> personalKeyForm = GlobalKey<FormState>();
  GlobalKey<FormState> addressInfoKeyForm = GlobalKey<FormState>();

  TextEditingController idNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // DateTime? daySelected;

  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController subDistrictController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController prefixController = TextEditingController();

  List<String> prefixList = ["นาย", "นาง", "นางสาว", "เด็กชาย", "เด็กหญิง"];
  List<DropdownMenuEntry<String>> prefixEntry = [];
  bool next = false;

  @override
  void initState() {
    getPrefixEntry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        top: true,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          stepIconBuilder: (index, stage) {
            if (currentStep == index) {
              return Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlueAccent),
              );
            } else {
              return Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              );
            }
          },
          onStepContinue: () {
            if (currentStep == 0) {
              setState(() {
                infoIsValidate = personalKeyForm.currentState?.validate() ?? false;
                next = true;
                if (infoIsValidate && birthDateSelected != null) {
                  currentStep = 1;
                  setState(() => next = false);
                }
                ;
              });
            } else {
              setState(() {
                addressIsValidate = addressInfoKeyForm.currentState?.validate() ?? false;
                next = true;
                if (addressIsValidate) {
                  context.read<PersonalInformationBloc>().add(
                        SaveInformation(
                          idNumber: idNumberController.text,
                          prefix: prefixController.text,
                          name: nameController.text,
                          lastName: lastNameController.text,
                          birthDate: birthDateSelected,
                          address: addressController.text,
                          subDistrict: subDistrictController.text,
                          district: districtController.text,
                          province: provinceController.text,
                        ),
                      );
                  Navigator.pop(context);
                }
              });
            }
          },
          onStepCancel: () {
            setState(() {
              if (currentStep != 0) {
                currentStep--;
              } else {
                Navigator.pop(context);
              }
            });
          },
          steps: [
            Step(
              title: Text("ข้อมูลส่วนตัว"),
              content: PersonalInfoWidget(),
            ),
            Step(
              title: Text("ที่อยู่"),
              content: AddressInfoWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget PersonalInfoWidget() {
    return Form(
      key: personalKeyForm,
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
                return "กรุณากรอกหมายเลขประจำตัวประชาชน";
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
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "คำนำหน้าชื่อ:",
                  style: FontTheme.regular,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: DropdownMenu(
                    menuHeight: 200,
                    dropdownMenuEntries: prefixEntry,
                    controller: prefixController,
                    errorText: (next && prefixController.text.trim().isEmpty) ? "กรุณาคำนำหน้าชื่อ" : null,
                  ),
                ),
              ],
            ),
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
              birthDateSelected = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Calendar(),
                ),
              );
              // widget.dateCallBack!.call(daySelected);
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
                        birthDateSelected != null ? "${DateFormat('dd/MM/y').format(birthDateSelected!)}" : "กรอก วัน/เดือน/ปี เกิด",
                        style: FontTheme.light.copyWith(color: birthDateSelected != null ? Colors.black : Colors.grey),
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

  Widget AddressInfoWidget() {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      builder: (context, state) {
        return Form(
          key: addressInfoKeyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForm(
                controller: addressController,
                titleText: "บ้านเลขที่",
                hintText: "กรอกบ้านเลขที่",
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (addressController.text.trim().isEmpty) {
                    return "กรุณากรอกบ้านเลขที่";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 14,
              ),
              CustomTextForm(
                controller: subDistrictController,
                titleText: "แขวง/ตำบล",
                hintText: "กรอกแขวง/ตำบล",
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (addressController.text.trim().isEmpty) {
                    return "กรุณากรอกแขวง/ตำบล";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 14,
              ),
              CustomTextForm(
                controller: districtController,
                titleText: "เขต/เภอ",
                hintText: "กรอกเขต/เภอ",
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (addressController.text.trim().isEmpty) {
                    return "กรุณากรอกเขต/เภอ";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "จังหวัด:",
                      style: FontTheme.regular,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: DropdownMenu(
                        menuHeight: 200,
                        dropdownMenuEntries: state.proVinceListEntry ?? [],
                        controller: provinceController,
                        errorText: (next && provinceController.text.trim().isEmpty) ? "กรุณาเลือกจังหวัด" : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getPrefixEntry() {
    for (int i = 0; i < prefixList.length; i++) {
      prefixEntry.add(
        DropdownMenuEntry(
          value: prefixList[i],
          label: prefixList[i],
        ),
      );
    }
    setState(() => prefixEntry);
  }
}
