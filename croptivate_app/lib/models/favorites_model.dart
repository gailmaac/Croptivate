import 'package:croptivate_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Favorites extends Equatable {
  final List<Product> products;

  const Favorites({this.products = const<Product>[]});

  @override
  List<Object?> get props => [products];
  
}