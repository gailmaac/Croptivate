import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 20,
        top: 10,
      ),
      height: 60,
      decoration: BoxDecoration(
        color: cWhite,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 10),
            blurRadius: 35,
            color: cGrey.withOpacity(0.40),
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/homebuyer');
            }, 
            icon: Icon(Icons.home_outlined, ),
          ),
          IconButton(
            onPressed: () {
              print("Messaging is pressed");
            }, 
            icon: Icon(Icons.chat_bubble_outline_rounded, ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/basket');
            }, 
            icon: Icon(Icons.shopping_basket_outlined, ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
            }, 
            icon: Icon(Icons.person_outline_rounded, )
          ),
      ],)
    );
  }
}
