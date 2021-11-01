import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/sellers/add_product.dart';
import 'package:croptivate_app/widgets/navigationdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeSeller extends StatefulWidget {

  const HomeSeller({ Key? key }) : super(key: key);

  @override
  _HomeSellerState createState() => _HomeSellerState();
  static const String routeName = '/';
  static Route route() {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => HomeSeller());
  }
}

List<Tab> tabs = [
  Tab(child: Text("To Ship")),
  Tab(child: Text("Shipping")),
  Tab(child: Text("Completed")),
  Tab(child: Text("Refunded")),
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
          title: Text("Orders",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: cGreen,
            fontWeight: FontWeight.bold,
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
                }, 
                icon: Icon(Icons.person_outline_rounded, )
              ),
          ],)
        ),
      ),
    );
  }
}