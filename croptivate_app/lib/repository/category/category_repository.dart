import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/category.dart';
import 'package:croptivate_app/repository/category/base_category_repo.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepository({FirebaseFirestore? firebaseFirestore}) :
  _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  
  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
  
}