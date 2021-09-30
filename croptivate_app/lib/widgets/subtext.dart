import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';

class SubText extends StatelessWidget {
  const SubText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Kindly fill out your information below.",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w200,
            color: cWhite,
          ),
        ),
      ),
    );
  }
}
