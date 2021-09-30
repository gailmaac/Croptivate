import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference sellerCollection = FirebaseFirestore.instance.collection('userSeller');

  Future updateUserData(String sellerType, String fname, String lname, String loc, String shopname, String shopdesc, int cnum) async {
    return await sellerCollection.doc(uid).set({
      'sellerType' : sellerType,
      'fname' : fname,
      'lname' : lname,
      'loc' : loc,
      'shopname' : shopname,
      'shopdesc' : shopdesc,
      'cnum' : cnum,
    }); 
  }

  //Get Seller Stream
  Stream<QuerySnapshot?> get userSeller {
    return sellerCollection.snapshots();
  }

}