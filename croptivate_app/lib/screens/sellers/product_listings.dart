import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({ Key? key }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // FirebaseAuth _auth = FirebaseAuth.instance;

  // late QuerySnapshot products;

  // getData() {
  //   var userId = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseFirestore.instance.collection('userSeller').doc(userId).get().then((results){
  //     setState(() {
  //       getName = results.data()!["fname"];
  //     });
  //   });
  // }
  
  // @override
  // void initState() {
  //   super.initState();
  //   userId = FirebaseAuth.instance.currentUser!.uid;
  //   userEmail = FirebaseAuth.instance.currentUser!.uid;

  //   FirebaseFirestore.instance.collection('sellerPosts').where('status', isEqualTo: "active")
  //   .orderBy("time", descending: true).get().then((results){

  //     setState(() {
  //       products = results;
  //     });
  //   });

  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text("Product Listings"),
        backgroundColor: cGreen,
      )
    );
  }
}
