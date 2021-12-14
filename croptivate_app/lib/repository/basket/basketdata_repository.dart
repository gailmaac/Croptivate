import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/basketdata_model.dart';
import 'package:croptivate_app/repository/basket/base_basketdata_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasketDataRepository extends BaseBasketDataRepository {

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BasketDataRepository({FirebaseFirestore? firebaseFirestore,}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addBasket(BasketData basketData) {
    var uid = _auth.currentUser!.uid;
    return _firebaseFirestore.collection('basket').doc(uid).set(basketData.toDocument());
  }

}