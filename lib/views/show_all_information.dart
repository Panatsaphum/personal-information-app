import 'package:flutter/material.dart';
import 'package:personal_information_app/theme/font_theme.dart';

class ShowAllInformation extends StatefulWidget {
  const ShowAllInformation({Key? key}) : super(key: key);

  @override
  State<ShowAllInformation> createState() => _ShowAllInformationState();
}

class _ShowAllInformationState extends State<ShowAllInformation> {
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
                "data",
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
