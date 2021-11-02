import 'package:croptivate_app/models/category.dart';

abstract class BaseCategoryRepository {
  Stream<List<Category>> getAllCategories();
}