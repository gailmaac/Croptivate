import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  //collection reference
  CollectionReference sellerCollection = FirebaseFirestore.instance.collection('userSeller');
  // CollectionReference sellerPostsCollection = FirebaseFirestore.instance.collection('sellerPosts');

  CollectionReference buyerCollection = FirebaseFirestore.instance.collection('userBuyer');
  CollectionReference transporterCollection = FirebaseFirestore.instance.collection('userTransporter');

// UserSeller
  Future<void> addUserSeller(Map<String, dynamic> sellerInfo) async {
    return await sellerCollection.doc(uid).set(sellerInfo);
  }

  Future getUserInfo() async {
    try{

    } catch (e) {
      
    }
  }
  //   Future<void> addUserPosts(Map<String, dynamic> sellerPostsInfo) async {
  //   return await sellerPostsCollection.doc(uid).set(sellerPostsInfo);
  // }
  

//UserBuyer
Future<void> addUserBuyer(Map<String, dynamic> buyerInfo) async {
    return await buyerCollection.doc(uid).set(buyerInfo);
  }

//UserTransporter
Future<void> addUserTransporter(Map<String, dynamic> transporterInfo) async {
    return await transporterCollection.doc(uid).set(transporterInfo);
  }


  // //Get Seller Stream
  // Stream<QuerySnapshot?> get userSeller {
  //   return sellerCollection.snapshots();
  // }

  // //Get Buyer


  // //get user doc stream
  // Stream<DocumentSnapshot> get userSellerData {
  //   return sellerCollection.doc(uid).snapshots();
  // }
}

