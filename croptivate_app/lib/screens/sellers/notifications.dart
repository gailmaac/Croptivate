import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/sellers/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
  static const String routeName = '/notifications';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => NotificationsPage());
  }
}

class _NotificationsPageState extends State<NotificationsPage> {
  String orderid = '';
  String name = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = '';

  getorderid(String buyer, String dateordered) async {
    try {
      await FirebaseFirestore.instance
          .collection('Orders')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (buyer == doc['Buyer'] && dateordered == doc['Date ordered']) {
            setState(() {
              orderid = doc.id;
            });
          }
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getname(String buyer) async {
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

  @override
  Widget build(BuildContext context) {
    uid = _auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 0,
        title: Text(
          "Notifications",
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
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Notifications')
                  .where("Seller", isEqualTo: uid)
                  //.orderBy("Date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No Notifications'),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      QueryDocumentSnapshot x = snapshot.data!.docs[i];
                      getorderid(x['Buyer'], x['Date ordered']);
                      getname(x['Buyer']);
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrdersPage(
                                          fr: 'Seller',
                                          buyer: x['Buyer'].toString(),
                                          dateordered:
                                              x['Date ordered'].toString(),
                                          orderid: orderid,
                                        )));
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Container(
                                height: 80,
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (x['Status'] == 'OrderPlaced') ...[
                                          Text(
                                              name.toString() +
                                                  ' placed an order',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: cGreen,
                                                  fontWeight: FontWeight.w800))
                                        ] else if (x['Status'] ==
                                            'OrderReceived') ...[
                                          Text(
                                              name.toString() +
                                                  ' received an order',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: cGreen,
                                                  fontWeight: FontWeight.w800))
                                        ] else if (x['Status'] ==
                                            'OrderCancelled') ...[
                                          Text(
                                              name.toString() +
                                                  ' cancelled an order',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: cGreen,
                                                  fontWeight: FontWeight.w800))
                                        ],
                                        Text('date: ' + x['Date'],
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: cGreen,
                                                fontWeight: FontWeight.w800))
                                      ]),
                                ),
                              )));
                    });
              })),
    );
  }
}
