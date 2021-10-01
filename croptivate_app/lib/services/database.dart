import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  //collection reference
  CollectionReference sellerCollection = FirebaseFirestore.instance.collection('userSeller');
// String myInitialItem,
  Future addUserSeller(var myInitialItem, String fname, String lname, String loc, String shopname, String shopdesc, int cnum) async {
    return await sellerCollection.doc(uid)
    .set({'myInitialItem' : myInitialItem,
      'fname' : fname,
      'lname' : lname,
      'loc' : loc,
      'shopname' : shopname,
      'shopdesc' : shopdesc,
      'cnum' : cnum,});
      
    
  }

  //Get Seller Stream
  Stream<QuerySnapshot?> get userSeller {
    return sellerCollection.snapshots();
  }


  //get user doc stream
  Stream<DocumentSnapshot> get userSellerData {
    return sellerCollection.doc(uid).snapshots();
  }
}

