import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/basketdata_model.dart';
import 'package:croptivate_app/repository/basket/base_basketdata_repo.dart';

class BasketDataRepository extends BaseBasketDataRepository {

  final FirebaseFirestore _firebaseFirestore;

  BasketDataRepository({FirebaseFirestore? firebaseFirestore,}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addBasket(BasketData basketData) {
    return _firebaseFirestore.collection('basket').add(basketData.toDocument());
  }

}