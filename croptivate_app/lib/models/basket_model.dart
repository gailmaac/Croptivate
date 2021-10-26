import 'dart:math';

import 'package:croptivate_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Basket extends Equatable {
  final List<Product> products;
  
  const Basket({this.products = const <Product>[]});


  double get subtotal => 
  products.fold(0, (total, current) => total + current.price);

  double shippingFee(subtotal) {
    if(subtotal >= 500.0) {
      return 30.0;
    } else {
      return 100.0;
    }
  }

  double total(subtotal, shippingFee) {
    return subtotal + shippingFee(subtotal);
  }

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get shippingFeeString => shippingFee(subtotal).toStringAsFixed(2);

  String get totalString => total(subtotal, shippingFee).toStringAsFixed(2);

  

  @override
  List<Object?> get props => [products];
}