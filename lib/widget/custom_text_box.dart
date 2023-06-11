import 'package:flutter/material.dart';
import 'package:personal_information_app/theme/font_theme.dart';

class CustomTextBox extends StatelessWidget {
  final String? title;
  final String? value;
  const CustomTextBox({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ""),
        SizedBox(height: 10,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1,color: Colors.blueAccent),
            color: Colors.white,
          ),
          child: Text(
            value ?? "",
            style: FontTheme.regular,
          ),
        ),
        SizedBox(height: 14,),
      ],
    );
  }
}
