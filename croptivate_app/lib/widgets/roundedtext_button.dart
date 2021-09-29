import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton({
    Key? key, 
    required this.buttonName,
  }) : super(key: key);

final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cGreen),
      child: TextButton(
        onPressed: () {},
        child: Text(
          buttonName,
          style: cBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      );
  }
}