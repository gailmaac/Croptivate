import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';

class GestureDetectorCatb extends StatelessWidget {
  const GestureDetectorCatb({
    Key? key,
    required this.accounttype,
  }) : super(key: key);

  final String accounttype;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'RegisterBuyer'),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        child: Center(
          child:Text(
            accounttype,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              color: cWhite,
              fontSize: 16,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cGreen),
      ),
    );
  }
}