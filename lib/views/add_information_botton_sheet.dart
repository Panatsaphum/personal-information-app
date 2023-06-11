import 'package:flutter/material.dart';
import 'package:personal_information_app/views/personal_info_page.dart';

class AddInformationBottomSheet extends StatefulWidget {
  const AddInformationBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddInformationBottomSheet> createState() => _AddInformationBottomSheetState();
}

class _AddInformationBottomSheetState extends State<AddInformationBottomSheet> {
  int currentStep = 0;
  DateTime? daySelected;
  bool isValidate = false;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("=> daySelected :$daySelected");
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        top: true,
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepContinue: () {
            isValidate = keyForm.currentState?.validate() ?? false;
            print("=> isValidate :$isValidate");
            setState(() {
              if (isValidate && daySelected != null) currentStep++;
            });
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
                content: PersonalInfoPage(
                  keyForm: keyForm,
                  dateCallBack: (value) {
                    daySelected = value;
                  },
                )),
            Step(
              title: Text("ที่อยู่"),
              content: Container(
                height: 500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
