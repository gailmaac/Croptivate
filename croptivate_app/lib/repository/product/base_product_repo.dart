import 'package:croptivate_app/models/product_model.dart';

abstract class BaseProductRepository {

  Stream<List<Product>> getAllProducts();
}