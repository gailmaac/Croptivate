import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/screens/sellers/orders.dart';
import 'package:croptivate_app/screens/sellers/user_profileseller.dart';
import 'package:croptivate_app/widgets/navigationdrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeSeller extends StatefulWidget {
  const HomeSeller({Key? key}) : super(key: key);

  @override
  _HomeSellerState createState() => _HomeSellerState();
  static const String routeName = '/homeseller';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => HomeSeller());
  }
}

List<Tab> tabs = [
  Tab(child: Text("To Ship")),
  Tab(child: Text("Shipping")),
  Tab(child: Text("Completed")),
  Tab(child: Text("Refunded")),
];

class _HomeSellerState extends State<HomeSeller> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List shipping = [];
  List to_ship = [];
  List refunded = [];
  List completed = [];
  String name = '';

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  getuser(String buyer) async {
    try {
      await FirebaseFirestore.instance
          .collection('userBuyer')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (buyer == doc.id) {
            setState(() {
              name = doc['first name'] + ' ' + doc['last name'];
            });
          }
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getOrders() async {
    List _to_ship = [];
    List _shipping = [];
    List _refunded = [];
    List _completed = [];
    try {
      await FirebaseFirestore.instance
          .collection('Orders')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['Seller'] == _auth.currentUser!.uid) {
            if (doc['To Ship'] == 'true') {
              _to_ship.add(doc.data());
            }
            if (doc['Shipping'] == 'true') {
              _shipping.add(doc.data());
            }
            if (doc['Refunded'] == 'true') {
              _refunded.add(doc.data());
            }
            if (doc['Completed'] == 'true') {
              _completed.add(doc.data());
            }
          }
        });
      });

      setState(() {
        to_ship = _to_ship;
        shipping = _shipping;
        refunded = _refunded;
        completed = _completed;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(to_ship.length);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
            iconTheme: IconThemeData(color: cGreen),
            backgroundColor: cWhite,
            elevation: 1,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: Text(
              "Orders",
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
                labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                indicatorColor: cGreen,
                isScrollable: true,
                tabs: tabs,
              ),
            )),
        body: TabBarView(children: [
          Container(
            height: double.infinity,
            child: ListView.builder(
                itemCount: to_ship.length,
                itemBuilder: (context, int) {
                  getuser(to_ship[int]['Buyer'].toString());
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersPage(
                                    fr: 'Seller',
                                    buyer: to_ship[int]['Buyer'].toString(),
                                    dateordered:
                                        to_ship[int]['Date ordered'].toString(),
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: cWhite,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 6),
                              blurRadius: 10,
                              color: cGrey.withOpacity(0.6),
                            )
                          ]
                        ),
                    child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reference ID",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: cBrown,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrdersPage(
                                    fr: 'Seller',
                                    buyer: to_ship[int]['Buyer'].toString(),
                                    dateordered:
                                      to_ship[int]['Date ordered'].toString(),
                                    )
                                  )
                                );
                              }, 
                              child: Text(
                                "View Order Details",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: cGreen
                                )
                              )
                            )
                          ],
                        ),
                        Text(
                          "sampleLBzkB6f0wVdPOVgw",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: cBlack),
                        ),
                        SizedBox(height: 10),
                        Text(
                              "Ordered By",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: cBrown,
                                fontWeight: FontWeight.w600),
                            ),
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: cBlack),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: #total",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: cBlack),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: cGreen),
                                onPressed: (){}, 
                                child: Text(
                                  "Ship Order",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                            ),
                          ],
                        )
                      ]
                      ),
                    ),
                  )));
                  // return ListTile(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => OrdersPage(
                  //                   fr: 'Seller',
                  //                   buyer: to_ship[int]['Buyer'].toString(),
                  //                   dateordered:
                  //                       to_ship[int]['Date ordered'].toString(),
                  //                 )));
                  //   },
                  //   tileColor: cGrey,
                  //   title: Text(name),
                  //   trailing: Text(to_ship[int]['Delivery Option'].toString()),
                  // );
                }),
          ),
          Container(
            height: double.infinity,
            color: cWhite,
            child: ListView.builder(
                itemCount: shipping.length,
                itemBuilder: (context, int) {
                  getuser(shipping[int]['Buyer'].toString());
                  return ListTile(
                    tileColor: cGrey,
                    title: Text(name),
                    trailing: Text(shipping[int]['Delivery Option'].toString()),
                  );
                }),
          ),
          Container(
            height: double.infinity,
            color: cWhite,
            child: ListView.builder(
                itemCount: completed.length,
                itemBuilder: (context, int) {
                  getuser(completed[int]['Buyer'].toString());
                  return ListTile(
                    tileColor: cGrey,
                    title: Text(completed[int]['Buyer'].toString()),
                    trailing:
                        Text(completed[int]['Delivery Option'].toString()),
                  );
                }),
          ),
          Container(
            height: double.infinity,
            color: cWhite,
            child: ListView.builder(
                itemCount: refunded.length,
                itemBuilder: (context, int) {
                  getuser(refunded[int]['Buyer'].toString());
                  return ListTile(
                    tileColor: cGrey,
                    title: Text(refunded[int]['Buyer'].toString()),
                    trailing: Text(refunded[int]['Delivery Option'].toString()),
                  );
                }),
          ),
        ]),
        bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 20,
              top: 10,
            ),
            height: 60,
            decoration: BoxDecoration(color: cWhite, boxShadow: [
              BoxShadow(
                offset: Offset(1, 10),
                blurRadius: 35,
                color: cGrey.withOpacity(0.40),
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/message');
                  },
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addproduct');
                  },
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/userprofileseller');
                    },
                    icon: Icon(
                      Icons.person_outline_rounded,
                    )),
              ],
            )),
      ),
    );
  }
}
