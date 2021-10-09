import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/sellers/add_product.dart';
import 'package:croptivate_app/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeSeller extends StatefulWidget {
  const HomeSeller({ Key? key }) : super(key: key);

  @override
  _HomeSellerState createState() => _HomeSellerState();
}

List<Tab> tabs = [
  Tab(child: Text("Overview")),
  Tab(child: Text("To-Do List")),
  Tab(child: Text("Cost Analysis")),
  Tab(child: Text("Revenue and Sales")),
  Tab(child: Text("Business Insights")),
];

class _HomeSellerState extends State<HomeSeller> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: cGreen),
          backgroundColor: cWhite,
          elevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Text("Dashboard",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            color: cGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: TabBar(
            labelColor: cGreen,
            labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
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
                ),
                Container(
                  height: double.infinity,
                  color: cGrey,
                ),
                Container(
                  height: double.infinity,
                  color: cBlack,
                ),
                Container(
                  height: double.infinity,
                  color: Colors.yellowAccent,
                ),
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
                  print("Messaging is pressed");
                }, 
                icon: Icon(Icons.chat_bubble_outline_rounded, ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                }, 
                icon: Icon(Icons.add_circle_outline_rounded, ),
              ),
              IconButton(
                onPressed: () {
                  
                }, 
                icon: Icon(Icons.person_outline_rounded, )
              ),
          ],)
        ),
      ),
    );
  }
}