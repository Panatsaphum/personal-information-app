import 'package:flutter/material.dart';
import 'package:personal_information_app/theme/font_theme.dart';

class ShowByProvince extends StatefulWidget {
  const ShowByProvince({Key? key}) : super(key: key);

  @override
  State<ShowByProvince> createState() => _ShowByProvinceState();
}

class _ShowByProvinceState extends State<ShowByProvince> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AAAAA",
                style: FontTheme.regular,
              ),
              Icon(
                Icons.remove_circle_outline_rounded,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
