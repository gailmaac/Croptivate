import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key, 
    required this.icon, 
    required this.hint, 
    required this.inputType, 
    required this.inputAction,
  }) : super(key: key);

final IconData icon;
final String hint;
final TextInputType inputType;
final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon, 
                  size: 20, 
                  color: cWhite),
              ),
              hintText: hint,
              hintStyle: cBodyText,
            ),
            obscureText: true,
            style: cBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        )
      ),
    );
  }
}