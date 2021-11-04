import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/user_model_buyer.dart';
import 'package:croptivate_app/repository/user_buyer/base_user_buyer_repo.dart';

class UserBuyerRepository extends BaseUserBuyerRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserBuyerRepository({FirebaseFirestore? firebaseFirestore})
    : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<User>> getUserBuyer() {
    return _firebaseFirestore.collection('userBuyer').snapshots().map((snapshot){
      return snapshot.docs.map((uid) {
        print(uid);
        return User.fromSnapshot(uid);
      }).toList();
    });
  }
}