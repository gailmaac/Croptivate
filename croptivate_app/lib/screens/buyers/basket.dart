import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/screens/home/home_buyer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Basket extends StatefulWidget {
  const Basket({ Key? key }) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

List<Tab> tabs = [
  Tab(child: 
  Text("Current Orders".toUpperCase())),
  Tab(child: 
  Text("Order History".toUpperCase())),
];


class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: cWhite,
        appBar: AppBar(
                backgroundColor: cWhite,
                elevation: 0,
                title: 
                  Text(
                    "My Basket",
                    style: TextStyle(
                      color: cGreen,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                    ),
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
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: TabBar(
                    labelColor: cGreen,
                    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    indicatorColor: cGreen,
                    isScrollable: true,
                    tabs: tabs,
                  ),
                )
              ),
              body: TabBarView(
                children: [
                  Container(
                    height: double.infinity,
                    color: Colors.brown[800],
                  ),
                  Container(
                    height: double.infinity,
                    color: cDGreen,
                  )
                ]
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeBuyer()));
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
      )
    );
  }
}