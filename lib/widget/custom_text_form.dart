import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_information_app/theme/font_theme.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? titleText;
  final String? hintText;
  final String? errorText;
  final FormFieldValidator<String?>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const CustomTextForm({Key? key, required this.controller, this.titleText, this.hintText, this.errorText, this.validator,this.inputFormatters,this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null) ...[
          Text(
            titleText ?? "",
            style: FontTheme.light,
          ),
          SizedBox(
            height: 10,
          ),
        ],
        TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FontTheme.light.copyWith(color: Colors.grey),
            counter: Offstage(),
            fillColor: Colors.white,
            filled: true,
            errorText: errorText,
            errorMaxLines: 3,
            errorStyle: FontTheme.light.copyWith(color: Colors.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
           hoverColor: Colors.white,
          ),
          validator: (value) {
            if (validator != null) return validator!(value);
            return null;
          },
        ),
      ],
    );
  }
}
