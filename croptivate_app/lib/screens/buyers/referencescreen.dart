import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/backgroundimageref.dart';
import 'package:croptivate_app/widgets/ordersummary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReferenceScreen extends StatefulWidget {
  final dateordered;
  const ReferenceScreen({Key? key, this.dateordered}) : super(key: key);

  @override
  _ReferenceScreenState createState() => _ReferenceScreenState();
  static const String routeName = '/reference';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => ReferenceScreen());
  }
}

class _ReferenceScreenState extends State<ReferenceScreen> {
  final _auth = FirebaseAuth.instance;
  String referenceID = '';
  String buyer = '';
  String seller = '';
  String loc = '';
  String PM = '';
  String DO = '';
  String date = '';

  @override
  void initState() {
    super.initState();
    findReference();
  }

  findReference() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['Date ordered'].toString());
        print(widget.dateordered);
        if (doc['Date ordered'].toString() == widget.dateordered &&
            _auth.currentUser!.uid == doc['Buyer']) {
          print('meron');
          setState(() {
            buyer = doc['Buyer'];
            date = doc['Date ordered'];
            loc = doc['location'];
            PM = doc['Payment Method'];
            DO = doc['Delivery Option'];
            referenceID = doc.id;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(referenceID);
    print('loc');
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        backgroundColor: cGreen,
        elevation: 1,
        title: Text(
          "Order Reference",
          style: TextStyle(
              color: cWhite,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          BackgroundImageRef(image: "assets/ref-bg.png"),
          Container(
          child: Column(
            children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 120, 0, 10),
              child: Container(
                child: Text(
                  "Reference Number",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: cBrown,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),
            Center(
              child: Text(
                referenceID,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: cBlack),
              ),
            ),
            Center(
              child: Text(
                "Date Ordered: " + date,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: cBlack),
              ),
            ),
            SizedBox(height: 20),
      
            Container(
              child: Text(
                "Ordered By:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: cBrown,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Center(
              child: Text(
                buyer,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "Payment Method",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: cBrown,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Center(
              child: Text(
                PM,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),

            SizedBox(height: 20),
            Container(
              child: Text(
                "Delivery Options",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: cBrown,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Center(
              child: Text(
                DO,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 60,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Divider(thickness: 1, height: 20,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: OrderSummary(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Divider(thickness: 1,),
            )
          ]),
        ),
        ]
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Close', 
        style: TextStyle(
          color: cGreen, 
          fontSize: 18)),
      ),
    );
  }
}
