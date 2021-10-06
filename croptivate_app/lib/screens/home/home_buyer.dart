import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/basket.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomeBuyer extends StatelessWidget {
  const HomeBuyer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: cGreen,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Align(
            alignment: AlignmentDirectional(0.4, 0),
            child: Container(
              width: 350,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: AlignmentDirectional(0,0),
                child: Container(
                  width: 380,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -3.52),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 5, 5, 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: "What are you looking for?",
                                    hintStyle: hintBodyText,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.95, -0.15),
                                child: Icon(
                                Icons.search_rounded,
                                color: Color(0xA3000000),
                                size: 20,
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: cWhite,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-0.95, -0.75),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                        child: Text(
                          "Deals of the Day",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: cGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.9, 0.15),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: cGreen),
                        child: TextButton(
                          onPressed: () {
                            print("More is pressed");
                          },
                          child: Text(
                            "More",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: cWhite,
                            ),
                          )
                        )
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
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
                  print("Home is pressed");
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Basket()));
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
        ),
        );
  }
}