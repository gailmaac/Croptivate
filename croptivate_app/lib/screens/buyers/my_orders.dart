import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/sellers/orders.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();

  static const String routeName = '/myorders';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => MyOrders());
  }
}

List<Tab> tabs = [
  Tab(child: Text("To Ship")),
  Tab(child: Text("Shipping")),
  Tab(child: Text("Completed")),
  Tab(child: Text("Cancelled")),
];

class _MyOrdersState extends State<MyOrders> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
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
              child: Showtoship(
                owner: _auth.currentUser!.uid,
              )),
          Container(
              height: double.infinity,
              color: cWhite,
              child: Shipping(
                owner: _auth.currentUser!.uid,
              )),
          Container(
              height: double.infinity,
              color: cWhite,
              child: Completed(
                owner: _auth.currentUser!.uid,
              )),
          Container(
              height: double.infinity,
              color: cWhite,
              child: Cancelled(
                owner: _auth.currentUser!.uid,
              )),
        ]),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class Showtoship extends StatefulWidget {
  final owner;
  const Showtoship({Key? key, this.owner}) : super(key: key);

  @override
  State<Showtoship> createState() => _ShowtoshipState();
}

class _ShowtoshipState extends State<Showtoship> {
  String name = '';
  getuser(String seller) async {
    try {
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (seller == doc.id) {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where("Buyer", isEqualTo: widget.owner)
            .where("To Ship", isEqualTo: "true")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Orders to Ship'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                getuser(x['Seller']);
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersPage(
                                    fr: 'Buyer',
                                    seller: x['Seller'].toString(),
                                    dateordered: x['Date ordered'].toString(),
                                    orderid: x.id,
                                  )));
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdersPage(
                                                          fr: 'Seller',
                                                          seller: x['Seller']
                                                              .toString(),
                                                          dateordered:
                                                              x['Date ordered']
                                                                  .toString(),
                                                          orderid: x.id,
                                                          buyer: x['Buyer'],
                                                        )));
                                          },
                                          child: Text("View Order Details",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13,
                                                  color: cGreen)))
                                    ],
                                  ),
                                  Text(
                                    x.id,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: cBlack),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Ordered From",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total: " + x['total'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: cBlack),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: cGreen),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('Orders')
                                                .doc(x.id)
                                                .update({
                                              'To Ship': 'false',
                                              'Refunded': 'true'
                                            });
                                          },
                                          child: Text(
                                            "Cancel Order",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ],
                                  )
                                ]),
                          ),
                        )));
              });
        });
  }
}

class Shipping extends StatefulWidget {
  final owner;
  const Shipping({Key? key, this.owner}) : super(key: key);

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  String name = '';
  getuser(String seller) async {
    try {
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (seller == doc.id) {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where("Buyer", isEqualTo: widget.owner)
            .where("Shipping", isEqualTo: "true")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Shipped Orders'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                getuser(x['Seller']);
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersPage(
                                    fr: 'Buyer',
                                    seller: x['Seller'].toString(),
                                    dateordered: x['Date ordered'].toString(),
                                    orderid: x.id,
                                  )));
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdersPage(
                                                          fr: 'Buyer',
                                                          seller: x['Seller']
                                                              .toString(),
                                                          dateordered:
                                                              x['Date ordered']
                                                                  .toString(),
                                                          orderid: x.id,
                                                          buyer: x['Buyer'],
                                                        )));
                                          },
                                          child: Text("View Order Details",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13,
                                                  color: cGreen)))
                                    ],
                                  ),
                                  Text(
                                    x.id,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: cBlack),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Ordered From",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total: " + x['total'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: cBlack),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: cGreen),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('Orders')
                                                .doc(x.id)
                                                .update({
                                              'Shipping': 'false',
                                              'Completed': 'true'
                                            });
                                          },
                                          child: Text(
                                            "Order Received",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ],
                                  )
                                ]),
                          ),
                        )));
              });
        });
  }
}

class Completed extends StatefulWidget {
  final owner;
  const Completed({Key? key, this.owner}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  String name = '';
  getuser(String seller) async {
    try {
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (seller == doc.id) {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where("Buyer", isEqualTo: widget.owner)
            .where("Completed", isEqualTo: "true")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Completed Orders'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                getuser(x['Seller']);
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersPage(
                                    fr: 'Buyer',
                                    seller: x['Seller'].toString(),
                                    dateordered: x['Date ordered'].toString(),
                                    orderid: x.id,
                                  )));
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdersPage(
                                                          fr: 'Buyer',
                                                          seller: x['Seller']
                                                              .toString(),
                                                          dateordered:
                                                              x['Date ordered']
                                                                  .toString(),
                                                          orderid: x.id,
                                                          buyer: x['Buyer'],
                                                        )));
                                          },
                                          child: Text("View Order Details",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13,
                                                  color: cGreen)))
                                    ],
                                  ),
                                  Text(
                                    x.id,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: cBlack),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Ordered From",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total: " + x['total'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: cBlack),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        )));
              });
        });
  }
}

class Cancelled extends StatefulWidget {
  final owner;
  const Cancelled({Key? key, this.owner}) : super(key: key);

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
  String name = '';
  getuser(String seller) async {
    try {
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (seller == doc.id) {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where("Buyer", isEqualTo: widget.owner)
            .where("Refunded", isEqualTo: "true")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Cancelled Orders'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                getuser(x['Seller']);
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersPage(
                                    fr: 'Buyer',
                                    seller: x['Seller'].toString(),
                                    dateordered: x['Date ordered'].toString(),
                                    orderid: x.id,
                                  )));
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdersPage(
                                                          fr: 'Buyer',
                                                          seller: x['Seller']
                                                              .toString(),
                                                          dateordered:
                                                              x['Date ordered']
                                                                  .toString(),
                                                          orderid: x.id,
                                                          buyer: x['Buyer'],
                                                        )));
                                          },
                                          child: Text("View Order Details",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13,
                                                  color: cGreen)))
                                    ],
                                  ),
                                  Text(
                                    x.id,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: cBlack),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Ordered From",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total: " + x['total'].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: cBlack),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        )));
              });
        });
  }
}
