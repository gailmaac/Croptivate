import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({ Key? key }) : super(key: key);

  static const String routeName = '/reference';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => ReferenceScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: cWhite,
      appBar: AppBar(
            backgroundColor: cWhite,
            elevation: 0,
            title: Text(
              "Reference Number",
              style: TextStyle(
                  color: cGreen,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: cBlack,
                size: 15,
              ),
            ),
          ),
    );
  }
}