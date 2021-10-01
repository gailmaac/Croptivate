import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  //collection reference
  CollectionReference sellerCollection = FirebaseFirestore.instance.collection('userSeller');
// String myInitialItem,
  Future<void> addUserSeller(Map<String, dynamic> sellerInfo) async {
    return await sellerCollection.doc(uid).set(sellerInfo);
      
    
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

