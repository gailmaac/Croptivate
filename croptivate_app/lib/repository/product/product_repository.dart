import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/repository/product/base_product_repo.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore}) 
    : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('sellerPosts').snapshots().map((snapshot) {
      
      return snapshot.docs.map((doc) {
        print(doc.reference.id);
        return Product.fromSnapshot(doc);
      }).toList();
    });
  }
  
}

