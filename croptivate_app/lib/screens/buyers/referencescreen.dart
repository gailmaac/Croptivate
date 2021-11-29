import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
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
        backgroundColor: cWhite,
        elevation: 0,
        title: Text(
          "Reference ID",
          style: TextStyle(
              color: cGreen,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(children: [
          Center(
            child: Text(
              referenceID,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
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
          Center(
            child: Text(
              DO,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          )
        ]),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('OK'),
      ),
    );
  }
}
