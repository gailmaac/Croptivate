import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/gesturedetector_catb.dart';
import 'package:croptivate_app/widgets/gesturedetector_cats.dart';
import 'package:croptivate_app/widgets/gesturedetector_catt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountCategories extends StatelessWidget {
  const AccountCategories({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: "assets/vegetable4.jpg"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                onPressed: () {
                Navigator.pop(context);
              },
                  icon: Icon(
                  Icons.arrow_back_ios,
                  color: cWhite,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 30, 0, 0),
                width: size.width * 0.8,
                child: Text(
                  "Choose your category.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: cWhite
                  ),
                )
              ),
              SizedBox(height: 80),
              GestureDetectorCats(accounttype: "I am a Seller"),
              SizedBox(height: 30),
              GestureDetectorCatb(accounttype: "I am a Buyer"),
              SizedBox(height: 30),
              GestureDetectorCatt(accounttype: "I am a Transporter"),
            ],
          ),
        )
      ]
    );
  }
}

