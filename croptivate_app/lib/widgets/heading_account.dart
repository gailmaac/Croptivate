import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';

class HeadingCreateAccount extends StatelessWidget {
  const HeadingCreateAccount({
    Key? key, 
    required this.acctype,
  }) : super(key: key);

final String acctype;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          acctype,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: cWhite
          ),
        )
      )
    );
  }
}